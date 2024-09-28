//
//  NameQuizResultView.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/28/24.
//

import SwiftUI

struct NameQuizResultView: View {
    @State var isPresentedSharedLink: Bool = false
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
                ResultText()
                Spacer()
                    .frame(height: 28)
                ShareResultButton(isPresentedSharedLink: $isPresentedSharedLink)
                Spacer()
                    .frame(height: 16)
                GoBackHomeButton()
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
    @Environment(NameQuizUseCase.self) private var nameQuizUseCase
    var body: some View {
        @Bindable var nameQuizUseCase = nameQuizUseCase
        ZStack(alignment: .top) {
            Text("\(MockDataBuilder.tinyPings.count)개 중에\n\(nameQuizUseCase.state.correctTinyPings.count)개 맞췄어요♡")
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

private struct ShareResultButton: View {
    @Environment(PathModel.self) private var pathModel: PathModel
    @Environment(NameQuizUseCase.self) private var nameQuizUseCase: NameQuizUseCase
    
    @Binding private(set) var isPresentedSharedLink: Bool
    var appStoreURL: URL = URL(string:"https://apps.apple.com/kr/app/%ED%8B%B0%EB%8B%88%EC%9C%84%ED%82%A4/id6705134139?l=en-GB")!
    
    var body: some View {
        @Bindable var nameQuizUseCase = nameQuizUseCase
        // TODO: 이수랑 어떻게 할지 상의 필요
            ShareLink (
                item: appStoreURL,
                subject: Text("티니위키"),
                message: Text("\n티니위키로 너의 티니핑 지식을 뽐내봐 츄!\n나는 \(MockDataBuilder.tinyPings.count)개 중에 \(nameQuizUseCase.state.correctTinyPings.count)개나 맞췄어 츄!")
            ) {
                Text("♡결과 공유하기♡")
                    .font(.Head.head6)
                    .foregroundStyle(.tinyPink)
                    .padding(EdgeInsets(top: 16, leading: 96, bottom: 16, trailing: 96))
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                    }
            }
    }
}

private struct GoBackHomeButton: View {
    @Environment(PathModel.self) private var pathModel: PathModel
    @Environment(NameQuizUseCase.self) private var nameQuizUseCase: NameQuizUseCase
    
    var body: some View {
        @Bindable var nameQuizUseCase = nameQuizUseCase
        Button {
            nameQuizUseCase.resetQuiz()
            print(nameQuizUseCase.state)
            pathModel.paths.removeAll()
        } label: {
            Text("♡홈으로 나가기♡")
                .font(.Head.head6)
                .foregroundStyle(.tinyPink)
                .padding(EdgeInsets(top: 16, leading: 96, bottom: 16, trailing: 96))
                .background {
                    RoundedRectangle(cornerRadius: 16)
                }
        }
    }
}

#Preview {
    NameQuizResultView()
        .environment(PathModel())
        .environment(NameQuizUseCase(nameQuizService: NameQuizService()))
}
