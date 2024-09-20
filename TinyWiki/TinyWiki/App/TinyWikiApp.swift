//
//  TinyWikiApp.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/17/24.
//

import SwiftUI

@main
struct TinyWiki: App {
    @State private var pathModel: PathModel = .init()
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .environment(pathModel)
    }
}
