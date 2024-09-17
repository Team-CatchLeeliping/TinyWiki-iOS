//
//  DetailView.swift
//  TinyDex
//
//  Created by kyungsoolee on 9/18/24.
//

import SwiftUI

struct DetailView: View {
    var tinyPing: TinyPing
    var body: some View {
        VStack {
            Image(tinyPing.avatar)
                .resizable()
                .scaledToFit()
                .frame(width: 220)
        }
        .frame(maxWidth: .infinity)
        .background {
            Image(.imgDetailbackgroundpink)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    DetailView(tinyPing: MockDataBuilder.tinyping)
}
