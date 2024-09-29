//
//  ImageQuizView.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/27/24.
//

import SwiftUI

struct ImageQuizView: View {
    @State var selectedTinyPing: TinyPing?
    @Environment(PathModel.self) private var pathModel
    
    @Environment(ImageQuizUseCase.self) private var imageQuizUseCase
    
    var body: some View {
        @Bindable var imageQuizUseCase = imageQuizUseCase
        ZStack {
            Image(.imgHomebackground)
                .resizable()
            VStack(spacing: 0) {
                TimerView {
                    pathModel.paths.append(.imageQuizResultView)  // 타이머 종료 후 결과 화면으로 이동
                }
                Spacer()
                    .frame(height: 84)
                TinyPingAvatar()
                Spacer()
                    .frame(height: 36)
                TinyPingList(
                    selectedTinyPing: $selectedTinyPing
                )
            }
            .onAppear {
                imageQuizUseCase.generateNewQuiz()
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - 타이머
private struct TimerView: View {
    @State private var time: Int = 0
    @State private var width: CGFloat = 0
    @State private var timer: Timer?  // 타이머 상태 관리
    let maxTime = 30
    let maxWidth: CGFloat = 340
    let onTimerEnd: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Image(systemName: SystemImage.stopwatch)
                    .resizable()
                    .scaledToFit()
                Text("\(time)초")
                    .font(.Head.head3)
            }
            .foregroundStyle(.tinyPink)
            .frame(height: 28)
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 24)
                    .foregroundStyle(.tinyWhite)
                    .frame(width: maxWidth, height: 20)
                
                RoundedRectangle(cornerRadius: 24)
                    .foregroundStyle(.tinyPink)
                    .frame(width: width, height: 20)
            }
            .onAppear {
                startTimer()
            }
            .onDisappear {
                stopTimer()  // 뷰가 사라질 때 타이머 중지
            }
        }
        
    }
    
    // 타이머 시작
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if time < maxTime {
                time += 1
                withAnimation(.linear(duration: 1.0)) { // 애니메이션을 시간 증가마다 적용
                    width = (CGFloat(time) / CGFloat(maxTime)) * maxWidth
                }
            } else {
                withAnimation(.linear(duration: 0.2)) {
                    width = maxWidth
                }
                timer.invalidate()
                onTimerEnd()
            }
        }
    }
    
    // 타이머 중지
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        time = 0  // 타이머 값 초기화
        width = 0  // 타이머 바 초기화
    }
}

// MARK: - 티니핑 아바타
private struct TinyPingAvatar: View {
    @Environment(ImageQuizUseCase.self) private var imageQuizUseCase: ImageQuizUseCase
    
    var body: some View {
        @Bindable var imageQuizUseCase = imageQuizUseCase
        Image(imageQuizUseCase.state.answerTinyPing.avatar)
            .resizable()
            .scaledToFit()
            .frame(height: 180)
    }
}

// MARK: - 티니핑 리스트
private struct TinyPingList: View {
    @Binding var selectedTinyPing: TinyPing?
    @Environment(ImageQuizUseCase.self) private var imageQuizUseCase: ImageQuizUseCase
    
    var body: some View {
        @Bindable var imageQuizUseCase = imageQuizUseCase
        VStack {
            ForEach(imageQuizUseCase.state.exmapleTinyPings) { tinyPing in
                TinyPingNameCell(
                    selectedTinyPing: $selectedTinyPing,
                    tinyPing: tinyPing
                )
            }
        }
        .padding(8)
    }
}

// MARK: - 티니핑 리스트 셀
private struct TinyPingNameCell: View {
    @Environment(PathModel.self) private var pathModel
    @Binding private(set) var selectedTinyPing: TinyPing?
    var tinyPing: TinyPing
    
    @Environment(ImageQuizUseCase.self) private var imageQuizUseCase: ImageQuizUseCase
    
    var body: some View {
        @Bindable var imageQuizUseCase = imageQuizUseCase
        Button {
            selectedTinyPing = tinyPing
            if let selectedTinyPing = selectedTinyPing {
                if selectedTinyPing.name == imageQuizUseCase.state.answerTinyPing.name {
                    imageQuizUseCase.addCorrectTinyPing(tinyPing: imageQuizUseCase.state.answerTinyPing)
                }
                imageQuizUseCase.generateNewQuiz()  // 정답 맞췄을 때 새로운 퀴즈 생성
            }
        } label: {
            Text("♡\(tinyPing.name)♡")
                .font(.CustomTitle.customTitle1)
                .foregroundStyle(.tinyPink)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 64)
                }
        }
        .environment(pathModel)
    }
}

#Preview {
    ImageQuizView()
        .environment(PathModel())
        .environment(ImageQuizUseCase(imageQuizService: ImageQuizService()))
}
