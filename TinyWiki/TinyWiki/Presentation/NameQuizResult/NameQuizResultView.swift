//
//  NameQuizResultView.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/28/24.
//

import SwiftUI

struct NameQuizResultView: View {
    var body: some View {
        ZStack {
            Image(.imgPinkgradientbackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                ResultImage()
                Spacer()
                    .frame(height: 68)
                ResultText(totalCount: 10, correctCount: 10)
            }
        }
    }
}

private struct ResultImage: View {
    var body: some View {
        VStack {
            Text("♡대단해츄♡")
                .font(.Head.head3)
                .foregroundStyle(.tinyWhite)
            Spacer()
                .frame(height: 32)
            Image(.imgHeartyouping)
                .resizable()
                .scaledToFit()
                .frame(height: 220)
                .background {
                    Image(.imgTwinklebackground)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 348, height: 300)
                }
        }
    }
}

private struct ResultText: View {
    let totalCount: Int
    let correctCount: Int
    var body: some View {
        ZStack(alignment: .top) {
            Text("\(totalCount)개 중에\n\(correctCount)개 맞췄어요♡")
                .font(.Head.head1)
                .multilineTextAlignment(.center)
                .foregroundStyle(.tinyPink)
                .frame(width: 348, height: 240)
                .background {
                    Image(.imgQuizresultbackground)
                        .resizable()
                        .scaledToFill()
                }
            Text("♡결과♡")
                .font(.Head.head1)
                .foregroundStyle(.tinyWhite)
                .customStroke(strokeSize: 4, strokeColor: .tinyPink)
                .offset(y: -20)
        }
    }
}

#Preview {
    NameQuizResultView()
        .environment(PathModel())
}
