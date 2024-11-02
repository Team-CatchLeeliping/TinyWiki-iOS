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
        VStack(spacing: 20) {
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
    @State private var isButtonDisabled: Bool = false
    
    var body: some View {
        @Bindable var imageQuizUseCase = imageQuizUseCase
        Button {
            withAnimation {
                
                selectedTinyPing = tinyPing
                isButtonDisabled = true // 버튼 비활성화
                if let selectedTinyPing = selectedTinyPing {
                    if selectedTinyPing.name == imageQuizUseCase.state.answerTinyPing.name {
                        imageQuizUseCase.addCorrectTinyPing(tinyPing: imageQuizUseCase.state.answerTinyPing)
                    }
                    // 0.1초 딜레이 후 새로운 퀴즈 생성 및 버튼 활성화
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        imageQuizUseCase.generateNewQuiz()
                        self.selectedTinyPing = nil
                    }
                }
            }
        } label: {
            Text("♡\(tinyPing.name)♡")
                .font(.CustomTitle.customTitle1)
                .foregroundStyle(.tinyPink)
                .lineLimit(1) // 한 줄로 제한
                .minimumScaleFactor(0.5) // 텍스트를 최소 50% 크기까지 줄임
                .frame(width: 320, height: 40)
                .padding()
            // TODO: 삼항연산자로 반복해서 쓰여진 코드 함수화시키기
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(selectedTinyPing == nil ? .tinyWhite : selectedTinyPing == tinyPing && tinyPing == imageQuizUseCase.state.answerTinyPing ? Color.green.opacity(0.4) : selectedTinyPing == tinyPing ? Color.red.opacity(0.4) : tinyPing == imageQuizUseCase.state.answerTinyPing ? Color.blue.opacity(0.4) : .tinyWhite)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                    // TODO: 삼항연산자로 반복해서 쓰여진 코드 함수화시키기
                        .stroke(selectedTinyPing == nil ? .tinyWhite : selectedTinyPing == tinyPing && tinyPing == imageQuizUseCase.state.answerTinyPing ? Color.green : selectedTinyPing == tinyPing ? Color.red : tinyPing == imageQuizUseCase.state.answerTinyPing ? Color.blue : .tinyWhite, lineWidth: 6)
                )
        }
        .disabled(isButtonDisabled) // 버튼 비활성화 상태 적용
        .environment(pathModel)
    }
}

#Preview {
    ImageQuizView()
        .environment(PathModel())
        .environment(ImageQuizUseCase(imageQuizService: ImageQuizService()))
}
