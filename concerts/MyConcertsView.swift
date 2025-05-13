//
//  MyConcertsView.swift
//  concerts
//
//  Created by Eryk Janiczek on 6/13/25.
//

import SwiftUI

struct MyConcertsView: View {
    @EnvironmentObject private var library: Library

    var body: some View {
        NavigationStack {
            Group {
                if library.saved.isEmpty {
                    ContentUnavailableView("No saved concerts",
                                           systemImage: "bookmark",
                                           description: Text("Browse events and tap the bookmark to save them."))
                } else {
                    List(library.saved) { concert in
                        NavigationLink(value: concert) {
                            ConcertRow(concert: concert)
                        }
                    }
                }
            }
            .navigationTitle("My Concerts")
            .navigationDestination(for: Concert.self) { ConcertDetailView(concert: $0) }
        }
    }
}
