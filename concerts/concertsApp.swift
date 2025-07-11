//
//  concertsApp.swift
//  concerts
//
//  Created by Eryk Janiczek on 6/13/25.
//

import SwiftUI

@main
struct concertsApp: App {
    @StateObject private var library = Library()
    @StateObject private var store = ConcertStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(library)
                .environmentObject(store)
        }
    }
}
