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
                
                AsyncImage(url: concert.imageURL) { phase in
                    switch phase {
                    case .success(let img): img
                            .resizable()
                            .scaledToFill()
                    default: Color.gray.opacity(0.3)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 260)
                .clipped()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(concert.artist)
                        .font(.largeTitle.bold())
                    
                    Text(concert.venue)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                    
                    if let date = concert.date {
                        Text(date.formatted(date: .abbreviated, time: .shortened))
                            .font(.headline)
                    }
                    
                    if let price = concert.price {
                        Text(String(format: "From %.0f %@", price, "PLN"))
                            .font(.headline)
                            .padding(.top, 4)
                    }
                    
                    Divider()
                    
//                    Text("no desc")
//                        .font(.body)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .toolbar {
            Button { library.toggle(concert) } label: {
                Label("Save", systemImage: library.contains(concert) ? "bookmark.fill" : "bookmark")
            }
        }
        .navigationTitle(concert.artist)
        .navigationBarTitleDisplayMode(.inline)
    }
}


//#Preview { ConcertDetailView(concert: sampleConcerts[0]).environmentObject(Library()) }
