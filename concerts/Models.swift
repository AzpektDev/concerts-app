//
//  Models.swift
//  concerts
//
//  Created by Eryk Janiczek on 6/13/25.
//

import Foundation

struct Artist: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let imageName: String      // local asset for demo
}

struct Concert: Identifiable, Hashable {
    let id = UUID()
    let artist: Artist
    let venue: String
    let date: Date
    let price: Double          // cheapest tier
    var isSaved: Bool = false
}

// Observable store for "my concerts"
final class Library: ObservableObject {
    @Published var saved: [Concert] = []

    func toggle(_ concert: Concert) {
        if let index = saved.firstIndex(of: concert) {
            saved.remove(at: index)
        } else {
            saved.append(concert)
        }
    }

    func contains(_ concert: Concert) -> Bool {
        saved.contains(concert)
    }
}
