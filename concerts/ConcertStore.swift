//
//  ConcertStore.swift
//  concerts
//
//  Created by Eryk Janiczek on 6/14/25.
//

import Foundation

@MainActor
final class ConcertStore: ObservableObject {
    @Published private(set) var concerts: [Concert] = []
    @Published private(set) var isLoading = false
    @Published var lastError: Error?
    
    private let api = APIService()
    
    func loadUpcoming() async {
        await search(keyword: nil, city: nil, maxPrice: nil)
    }
    
    func search(keyword: String?, city: String? = nil, maxPrice: Double? = nil) async {
        isLoading = true
        defer { isLoading = false }
        do {
            concerts = try await api.events(keyword: keyword, city: city, maxPrice: maxPrice)
            lastError = nil
        } catch {
            lastError = error
            concerts = []
            print("API error:", error)
        }
    }
}
