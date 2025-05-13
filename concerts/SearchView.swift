//
//  SearchView.swift
//  concerts
//
//  Created by Eryk Janiczek on 6/13/25.
//

import SwiftUI

struct SearchView: View {
    @State private var query = ""
    private var results: [Concert] {
        if query.isEmpty { return sampleConcerts }
        return sampleConcerts.filter {
            $0.artist.name.lowercased().contains(query.lowercased()) ||
            $0.venue.lowercased().contains(query.lowercased())
        }
    }

    var body: some View {
        NavigationStack {
            List(results) { concert in
                NavigationLink(value: concert) {
                    ConcertRow(concert: concert)
                }
            }
            .searchable(text: $query, prompt: "Artist, venue…")
            .navigationTitle("Search")
            .navigationDestination(for: Concert.self) { ConcertDetailView(concert: $0) }
        }
    }
}
