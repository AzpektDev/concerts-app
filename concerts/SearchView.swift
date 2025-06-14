//
//  SearchView.swift
//  concerts
//
//  Created by Eryk Janiczek on 6/13/25.
//

import SwiftUI

struct SearchView: View {
    @State private var query = ""
    @EnvironmentObject private var store: ConcertStore
    
    var body: some View {
        NavigationStack {
            Group {
                if store.isLoading {
                    ProgressView("Searching…")
                } else if store.concerts.isEmpty {
                    ContentUnavailableView("No results",
                                           systemImage: "magnifyingglass",
                                           description: Text("Try a different search term."))
                } else {
                    List(store.concerts) { concert in
                        NavigationLink(value: concert) {
                            ConcertRow(concert: concert)
                        }
                    }
                }
            }
            .searchable(text: $query, prompt: "Artist, venue…")
            .onSubmit(of: .search) {
                Task { await store.search(keyword: query) }
            }
            .navigationTitle("Search")
            .navigationDestination(for: Concert.self) { ConcertDetailView(concert: $0) }
        }
    }
}
