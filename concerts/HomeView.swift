//
//  HomeView.swift
//  concerts
//
//  Created by Eryk Janiczek on 6/13/25.
//

import SwiftUI

struct HomeView: View {
    private let upcoming = sampleConcerts.sorted { $0.date < $1.date }

    var body: some View {
        NavigationStack {
            List(upcoming) { concert in
                NavigationLink(value: concert) {
                    ConcertRow(concert: concert)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Upcoming")
            .navigationDestination(for: Concert.self) { ConcertDetailView(concert: $0) }
        }
    }
}
