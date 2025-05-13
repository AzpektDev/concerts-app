//
//  ConcertDetailView.swift
//  concerts
//
//  Created by Eryk Janiczek on 6/13/25.
//

import SwiftUI

struct ConcertDetailView: View {
    @EnvironmentObject private var library: Library
    let concert: Concert

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(concert.artist.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 260)
                    .clipped()

                VStack(alignment: .leading, spacing: 8) {
                    Text(concert.artist.name)
                        .font(.largeTitle.bold())

                    Text(concert.venue)
                        .font(.title3)
                        .foregroundStyle(.secondary)

                    Text(concert.date.formatted(date: .abbreviated, time: .shortened))
                        .font(.headline)

                    Text(String(format: "From %.0f PLN", concert.price))
                        .font(.headline)
                        .padding(.top, 4)

                    Divider()

                    Text(loremIpsum)
                        .font(.body)
                }
                .padding()
            }
        }
        .ignoresSafeArea(edges: .top)
        .toolbar {
            Button {
                library.toggle(concert)
            } label: {
                Label("Save", systemImage: library.contains(concert) ? "bookmark.fill" : "bookmark")
            }
        }
        .navigationTitle(concert.artist.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var loremIpsum: String {
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sit amet commodo quam. Phasellus facilisis sed elit quis commodo. In hac habitasse platea dictumst."
    }
}

#Preview { ConcertDetailView(concert: sampleConcerts[0]).environmentObject(Library()) }
