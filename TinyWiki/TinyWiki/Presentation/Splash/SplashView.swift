//
//  SplashView.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/17/24.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        ZStack {
            Image(.imgSplashbackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            Image(.imgSplashbook)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
        }
        .environment(PathModel())
    }
}

#Preview {
    SplashView()
        .environment(PathModel())
}
