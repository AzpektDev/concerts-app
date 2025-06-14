//
//  ConcertRow.swift
//  concerts
//
//  Created by Eryk Janiczek on 6/13/25.
//

import SwiftUI

struct ConcertRow: View {
    @EnvironmentObject private var library: Library
    let concert: Concert
    
    var body: some View {
        HStack {
            AsyncImage(url: concert.imageURL) { phase in
                switch phase {
                case .success(let img): img
                        .resizable()
                        .scaledToFill()
                default: Image(systemName: "photo")
                }
            }
            .frame(width: 56, height: 56)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(concert.artist).font(.headline)
                Text(concert.venue).font(.subheadline).foregroundStyle(.secondary)
                if let date = concert.date {
                    Text(date, style: .date).font(.caption).foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            Button {
                library.toggle(concert)
            } label: {
                Image(systemName: library.contains(concert) ? "bookmark.fill" : "bookmark")
                    .imageScale(.large)
            }
            .buttonStyle(.plain)
        }
    }
}


//#Preview {
//    ConcertRow(concert: sampleConcerts[0]).environmentObject(Library())
//}
