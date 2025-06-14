//
//  Models.swift
//  concerts
//
//  Created by Eryk Janiczek on 6/13/25.
//

import Foundation

struct Concert: Identifiable, Hashable {
    let id: String
    let artist: String
    let venue: String
    let date: Date?
    let price: Double?
    let imageURL: URL?
}


final class Library: ObservableObject {
    @Published private(set) var saved: [Concert] = []
    
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
}
