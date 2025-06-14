//
//  HomeView.swift
//  concerts
//
//  Created by Eryk Janiczek on 6/13/25.
//


import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var store: ConcertStore
    
    var body: some View {
        NavigationStack {
            Group {
                if store.isLoading {
                    ProgressView("Loading concerts…")
                } else if store.concerts.isEmpty {
                    ContentUnavailableView("No events found",
                                           systemImage: "music.note.list",
                                           description: Text("Pull down to refresh."))
                } else {
                    List(store.concerts) { concert in
                        NavigationLink(value: concert) {
                            ConcertRow(concert: concert)
                        }
                    }
                    .refreshable { await store.loadUpcoming() }
                }
            }
            .navigationTitle("Upcoming")
            .navigationDestination(for: Concert.self) { ConcertDetailView(concert: $0) }
            .task {         // load once when view appears
                if store.concerts.isEmpty { await store.loadUpcoming() }
            }
        }
    }
}
