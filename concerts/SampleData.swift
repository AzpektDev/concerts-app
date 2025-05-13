//
//  SampleData.swift
//  concerts
//
//  Created by Eryk Janiczek on 6/13/25.
//

import Foundation

let sampleArtists: [Artist] = [
    .init(name: "Test", imageName: "test"),
    .init(name: "Test2",     imageName: "test"),
    .init(name: "Test3",     imageName: "test"),
    .init(name: "Test4",        imageName: "test")
]

let sampleConcerts: [Concert] = [
    .init(artist: sampleArtists[0], venue: "Warszawa Expo Hall",  date: .now.addingTimeInterval(60*60*24*10), price: 199),
    .init(artist: sampleArtists[1], venue: "Kraków Tauron Arena", date: .now.addingTimeInterval(60*60*24*24), price: 249),
    .init(artist: sampleArtists[2], venue: "PGE Narodowy",        date: .now.addingTimeInterval(60*60*24*40), price: 399),
    .init(artist: sampleArtists[3], venue: "Gdańsk Ergo Arena",   date: .now.addingTimeInterval(60*60*24*55), price: 179)
]
