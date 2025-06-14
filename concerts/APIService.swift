//
//  APIService.swift
//  concerts
//
//  Created by Eryk Janiczek on 6/14/25.
//

import Foundation

struct APIService {
    private let apiKey: String
    
    init() {
        apiKey = Bundle.main.infoDictionary?["TM_API_KEY"] as? String ?? ""
    }
    
    func events(keyword: String? = nil,
                city: String? = nil,
                maxPrice: Double? = nil) async throws -> [Concert] {
        var comps = URLComponents(string: "https://app.ticketmaster.com/discovery/v2/events.json")!
        var query: [URLQueryItem] = [
            .init(name: "apikey", value: apiKey),
            .init(name: "size",   value: "50"),
            .init(name: "sort",   value: "date,asc")
        ]
        if let keyword { query.append(.init(name: "keyword", value: keyword)) }
        if let city    { query.append(.init(name: "city",    value: city)) }
        if let maxPrice {
            query.append(.init(name: "priceMax", value: String(Int(maxPrice))))
        }
        comps.queryItems = query
        
        print(apiKey)
        
        let (data, _) = try await URLSession.shared.data(from: comps.url!)
        let decoded   = try JSONDecoder().decode(TMResponse.self, from: data)
        return decoded.embedded?.events.map(\.asConcert) ?? []
    }
}

private struct TMResponse: Decodable {
    let embedded: Embedded?
    enum CodingKeys: String, CodingKey { case embedded = "_embedded" }
    
    struct Embedded: Decodable {
        let events: [TMEvent]
    }
}

private struct TMEvent: Decodable {
    let id: String
    let name: String
    let dates: Dates
    let priceRanges: [PriceRange]?
    let images: [TMImage]?
    let embedded: Embedded?
    
    enum CodingKeys: String, CodingKey {
        case id, name, dates, priceRanges, images
        case embedded = "_embedded"
    }
    
    struct Dates: Decodable {
        let start: Start
        struct Start: Decodable { let dateTime: String? }
    }
    
    struct PriceRange: Decodable { let min: Double? }
    struct TMImage: Decodable   { let url: String }
    
    struct Embedded: Decodable {
        let venues: [Venue]
        struct Venue: Decodable { let name: String? }
    }
}

private extension TMEvent {
    var asConcert: Concert {
        let isoDate = ISO8601DateFormatter().date(from: dates.start.dateTime ?? "")
        return Concert(
            id: id,
            artist: name,
            venue: embedded?.venues.first?.name ?? "—",
            date: isoDate,
            price: priceRanges?.first?.min,
            imageURL: images?
                .first(where: { $0.url.contains("RETINA_PORTRAIT") })
                .map { URL(string: $0.url) } ?? nil
        )
    }
}
