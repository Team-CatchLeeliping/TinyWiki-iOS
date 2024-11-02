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
                    pathModel.paths.append(.nameQuizResultView)  // 타이머 종료 후 결과 화면으로 이동
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

// MARK: - 티니핑 이름 텍스트
private struct TinyPingNameText: View {
    @Environment(NameQuizUseCase.self) private var nameQuizUseCase: NameQuizUseCase
    
    var body: some View {
        @Bindable var nameQuizUseCase = nameQuizUseCase
        Text("♡\(nameQuizUseCase.state.answerTinyPing.name)♡")
            .font(.CustomTitle.customTitle1)
            .foregroundStyle(.tinyPink)
            .lineLimit(1) // 한 줄로 제한
            .minimumScaleFactor(0.5) // 텍스트를 최소 50% 크기까지 줄임
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
    @Environment(NameQuizUseCase.self) private var nameQuizUseCase: NameQuizUseCase
    @Binding var selectedTinyPing: TinyPing?
    
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
    @State private var isCorrect: Bool = false
    
    var body: some View {
        @Bindable var nameQuizUseCase = nameQuizUseCase
        Button {
            withAnimation {
            selectedTinyPing = tinyPing
                if let selectedTinyPing = selectedTinyPing {
                    if selectedTinyPing.name == nameQuizUseCase.state.answerTinyPing.name {
                        nameQuizUseCase.addCorrectTinyPing(tinyPing: nameQuizUseCase.state.answerTinyPing)
                        isCorrect.toggle()
                        print(nameQuizUseCase.state.correctTinyPings)
                        print(nameQuizUseCase.state.correctTinyPings.count)
                    }
                    
                    // 0.1초 딜레이 후 새로운 퀴즈 생성 및 버튼 활성화
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        nameQuizUseCase.generateNewQuiz()
                        self.selectedTinyPing = nil
                    }
                }
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
                // TODO: 삼항연산자로 반복해서 쓰여진 코드 함수화시키기
                .background(selectedTinyPing == nil ? .tinyWhite : selectedTinyPing == tinyPing && tinyPing == nameQuizUseCase.state.answerTinyPing ? Color.green.opacity(0.4) : selectedTinyPing == tinyPing ? Color.red.opacity(0.4) : tinyPing == nameQuizUseCase.state.answerTinyPing ? Color.blue.opacity(0.4) : .tinyWhite)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                    // TODO: 삼항연산자로 반복해서 쓰여진 코드 함수화시키기
                        .stroke(selectedTinyPing == nil ? .tinyWhite : selectedTinyPing == tinyPing && tinyPing == nameQuizUseCase.state.answerTinyPing ? Color.green : selectedTinyPing == tinyPing ? Color.red : tinyPing == nameQuizUseCase.state.answerTinyPing ? Color.blue : .tinyWhite, lineWidth: 10)
                )
                .cornerRadius(20)
                .contentShape(Rectangle())
                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 1)
            }
        }
        .disabled(selectedTinyPing != nil)
        .environment(pathModel)
    }
}

#Preview {
    NameQuizView()
        .environment(PathModel())
        .environment(NameQuizUseCase(nameQuizService: NameQuizService()))
}
