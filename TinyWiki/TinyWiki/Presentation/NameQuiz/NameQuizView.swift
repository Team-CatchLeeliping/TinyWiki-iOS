//
//  NameQuizView.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/27/24.
//

import SwiftUI

struct NameQuizView: View {
    @State var selectedTinyPing: TinyPing?
    @Environment(PathModel.self) private var pathModel
    
    @Environment(NameQuizUseCase.self) private var nameQuizUseCase
    
    var body: some View {
        @Bindable var nameQuizUseCase = nameQuizUseCase
        ZStack {
            Image(.imgHomebackground)
                .resizable()
            VStack(spacing: 0) {
                TimerView {
                    pathModel.paths.append(.nameQuisResultView)  // 타이머 종료 후 결과 화면으로 이동
                }
                Spacer()
                    .frame(height: 84)
                TinyPingNameText()
                Spacer()
                    .frame(height: 36)
                TinyPingGrid(
                    selectedTinyPing: $selectedTinyPing
                )
            }
            .onAppear {
                nameQuizUseCase.generateNewQuiz()
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
    let maxTime = 3
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

// MARK: - 티니핑 이름 텍스트
private struct TinyPingNameText: View {
    @Environment(NameQuizUseCase.self) private var nameQuizUseCase: NameQuizUseCase
    
    var body: some View {
        @Bindable var nameQuizUseCase = nameQuizUseCase
        Text("♡\(nameQuizUseCase.state.answerTinyPing.name)♡")
            .font(.CustomTitle.customTitle1)
            .foregroundStyle(.tinyPink)
            .padding(EdgeInsets(top: 24, leading: 36, bottom: 24, trailing: 36))
            .background {
                Image(.imgQuiznamebackground)
                    .resizable()
                    .scaledToFill()
            }
    }
}

// MARK: - 티니핑 그리드
private struct TinyPingGrid: View {
    @Binding var selectedTinyPing: TinyPing?
    @Environment(NameQuizUseCase.self) private var nameQuizUseCase: NameQuizUseCase
    
    private let columns: [GridItem] = Array(repeating: .init(.fixed(180), spacing: nil), count: 2)
    
    var body: some View {
        @Bindable var nameQuizUseCase = nameQuizUseCase
        LazyVGrid(columns: columns , spacing: 8) {
            ForEach(nameQuizUseCase.state.exmapleTinyPings) { tinyPing in
                TinyPingCell(
                    selectedTinyPing: $selectedTinyPing,
                    tinyPing: tinyPing
                )
            }
        }
        .padding(8)
    }
}

// MARK: - 티니핑 리스트 셀
private struct TinyPingCell: View {
    @Environment(PathModel.self) private var pathModel
    @Binding private(set) var selectedTinyPing: TinyPing?
    var tinyPing: TinyPing
    
    @Environment(NameQuizUseCase.self) private var nameQuizUseCase: NameQuizUseCase
    
    var body: some View {
        @Bindable var nameQuizUseCase = nameQuizUseCase
        Button {
            selectedTinyPing = tinyPing
            if let selectedTinyPing = selectedTinyPing {
                if selectedTinyPing.name == nameQuizUseCase.state.answerTinyPing.name {
                    nameQuizUseCase.addCorrectTinyPing(tinyPing: nameQuizUseCase.state.answerTinyPing)
                    print(nameQuizUseCase.state.correctTinyPings)
                    print(nameQuizUseCase.state.correctTinyPings.count)
                }
                nameQuizUseCase.generateNewQuiz()  // 정답 맞췄을 때 새로운 퀴즈 생성
            }
        } label: {
            ZStack {
                VStack(spacing: 0) {
                    Image(tinyPing.avatar)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 130)
                }
                .frame(width: 180, height: 180)
                .background(.tinyWhite)
                .cornerRadius(20)
                .contentShape(Rectangle())
                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 1)
            }
        }
        .environment(pathModel)
    }
}

#Preview {
    NameQuizView()
        .environment(PathModel())
        .environment(NameQuizUseCase(nameQuizService: NameQuizService()))
}
