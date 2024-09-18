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
        ScrollView {
            ZStack(alignment: .top) {
                Image(tinyPing.backgroundColor.baseBackground)
                    .resizable()
                    .scaledToFill()
                VStack(spacing: 0) {
                    Image(tinyPing.avatar)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220)
                        .padding(.top, 150)
                    Description(tinyPing: tinyPing)
                }
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - 상세 설명
private struct Description: View {
    var tinyPing: TinyPing
    var body: some View {
        ZStack(alignment: .top) {
            Image(tinyPing.backgroundColor.descriptionBackground)
                .resizable()
                .scaledToFill()
                // TODO: 왜 이거를 붙이면 화면이 안깨질까?..
                .frame(maxWidth: 0)
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                    .frame(height: 100)
                Text("어떤 내용 넣을지 고민하기...")
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    DetailView(tinyPing: MockDataBuilder.tinyPing)
}
