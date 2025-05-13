//
//  ContentView.swift
//  concerts
//
//  Created by Eryk Janiczek on 6/13/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "music.note.house") }

            SearchView()
                .tabItem { Label("Search", systemImage: "magnifyingglass") }

            MyConcertsView()
                .tabItem { Label("My Concerts", systemImage: "bookmark") }
        }
        .tint(.pink)
    }
}

#Preview { ContentView().environmentObject(Library()) }
