//
//  Models.swift
//  concerts
//
//  Created by Eryk Janiczek on 6/13/25.
//

import Foundation

struct Concert: Identifiable, Hashable, Codable {
    let id: String
    let artist: String
    let venue: String
    let date: Date?
    let price: Double?
    let imageURL: URL?
}


@MainActor
final class Library: ObservableObject {
    @Published private(set) var saved: [Concert] = [] {
        didSet { persist() }
    }
    
    private let saveKey = "SavedConcerts"
    
    func toggle(_ concert: Concert) {
        if let idx = saved.firstIndex(of: concert) {
            saved.remove(at: idx)
        } else {
            saved.append(concert)
        }
    }
    
    func contains(_ concert: Concert) -> Bool {
        saved.contains(concert)
    }
    
    init() { load() }
    
    private func persist() {
        guard let data = try? JSONEncoder().encode(saved) else { return }
        UserDefaults.standard.set(data, forKey: saveKey)
    }
    
    private func load() {
        guard
            let data  = UserDefaults.standard.data(forKey: saveKey),
            let items = try? JSONDecoder().decode([Concert].self, from: data)
        else { return }
        saved = items
    }
}
