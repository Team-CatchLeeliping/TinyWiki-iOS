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
    var appStoreURL: URL = URL(string:" ")!
    
    var body: some View {
        @Bindable var nameQuizUseCase = nameQuizUseCase
        // TODO: 이수랑 어떻게 할지 상의 필요
        Button {
            kakaoButtonAction()
        } label: {
            Text("♡카카오톡 공유하기♡")
                .font(.Head.head6)
                .foregroundStyle(.tinyPink)
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                .frame(width: 328, height: 52)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                }
        }
    }
}

private struct GoBackHomeButton: View {
    @Environment(PathModel.self) private var pathModel: PathModel
    @Environment(NameQuizUseCase.self) private var nameQuizUseCase: NameQuizUseCase
    @State private var isButtonDisabled: Bool = false
    
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
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                .frame(width: 328, height: 52)
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


