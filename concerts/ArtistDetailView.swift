//
//  ArtistDetailView.swift
//  concerts
//
//  Created by Eryk Janiczek on 6/13/25.
//

import SwiftUI

struct ArtistDetailView: View {
    let artist: Artist

    var body: some View {
        List {
            Image(artist.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 240)
                .clipped()
                .listRowInsets(EdgeInsets())

            Text(lorem)
        }
        .navigationTitle(artist.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var lorem: String {
        "Suspendisse potenti. Sed laoreet, tortor quis dignissim bibendum, ex justo viverra magna, vitae tempus lorem erat quis elit."
    }
}

#Preview { ArtistDetailView(artist: sampleArtists[0]) }
