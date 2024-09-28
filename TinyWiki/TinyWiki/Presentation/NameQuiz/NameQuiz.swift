//
//  NameQuiz.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/27/24.
//

import SwiftUI

struct NameQuiz: View {
    // TODO: 랜덤으로 티니핑 뽑아오기 구현. 이 때, 이전에 나온 티니핑들은 따로 리스트를 관리하여 다시 선택할 수 없게 해야함.
    @State private var exmapleTinyPings: [TinyPing] = Array(MockDataBuilder.tinyPings.prefix(4))
    @State var selectedTinyPing: TinyPing?
    @State var answerTinyPing: TinyPing = MockDataBuilder.tinyPing
    @State var usedTinyPings: [TinyPing] = []
    @State var answerCount: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            TimerView()
            Spacer()
                .frame(height: 84)
            TinyPingNameText(name: answerTinyPing.name)
            Spacer()
                .frame(height: 36)
            TinyPingGrid(selectedTinyPing: $selectedTinyPing, exmapleTinyPings: $exmapleTinyPings, answerTinyPing: $answerTinyPing, answerCount: $answerCount, onCorrectAnswer: generateNewQuiz)
        }
        .onAppear {
            generateNewQuiz()
        }
    }
    
    // TODO: UI와 분리하기
    // 새로운 퀴즈를 생성하는 함수
    private func generateNewQuiz() {
        // 이전에 사용된 티니핑을 제외하고 새로운 티니핑 목록을 필터링
        let availableTinyPings = MockDataBuilder.tinyPings.filter { !usedTinyPings.contains($0) }
        
        // 4개의 티니핑을 랜덤으로 선택
        exmapleTinyPings = Array(availableTinyPings.shuffled().prefix(4))
        
        // 정답은 exampleTinyPings 중 하나로 선택
        answerTinyPing = exmapleTinyPings.randomElement() ?? MockDataBuilder.tinyPing
        
        // 사용된 티니핑에 정답 추가
        usedTinyPings.append(answerTinyPing)
        
        // 만약 사용된 티니핑이 전체보다 많아지면 초기화 (전부 다 사용된 경우를 대비)
        if usedTinyPings.count >= MockDataBuilder.tinyPings.count {
            usedTinyPings.removeAll()
        }
    }
}

// MARK: - 타이머
private struct TimerView: View {
    @State private var time: Int = 0
    @State private var width: CGFloat = 0
    let maxTime = 30
    let maxWidth: CGFloat = 340
    
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
        }

    }
    
    // 타이머 시작
    // TODO: func 뷰와 분리하기
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if time < maxTime {
                time += 1
                withAnimation(.linear(duration: 1.0)) { // 애니메이션을 시간 증가마다 적용
                    width = (CGFloat(time) / CGFloat(maxTime)) * maxWidth
                }
            } else {
                // 마지막에 애니메이션이 끝났을 때, 최대 값까지 확실히 늘려준다.
                withAnimation(.linear(duration: 0.2)) {
                    width = maxWidth
                }
                timer.invalidate()
            }
        }
    }
}

// MARK: - 티니핑 이름 텍스트
private struct TinyPingNameText: View {
    var name: String
    
    var body: some View {
        Text("♡\(name)♡")
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
    @Binding private(set) var exmapleTinyPings: [TinyPing]
    @Binding var answerTinyPing: TinyPing
    @Binding var answerCount: Int
    let onCorrectAnswer: () -> Void  // 정답 맞췄을 때 호출하는 클로저
    
    private let columns: [GridItem] = Array(repeating: .init(.fixed(180), spacing: nil), count: 2)
    
    var body: some View {
        LazyVGrid(columns: columns , spacing: 8) {
            ForEach(exmapleTinyPings, id: \.id) { tinyPing in
                if let index = exmapleTinyPings.firstIndex(where: { $0.id == tinyPing.id }) {
                    TinypingCell(
                        selectedTinyPing: $selectedTinyPing,
                        tinyPing: $exmapleTinyPings[index],
                        answerTinyPing: $answerTinyPing,
                        answerCount: $answerCount,
                        onCorrectAnswer: onCorrectAnswer
                    )
                }
            }
        }
        .padding(8)
    }
}

// MARK: - 티니핑 리스트 셀
private struct TinypingCell: View {
    @Environment(PathModel.self) private var pathModel
    @Binding private(set) var selectedTinyPing: TinyPing?
    @Binding var tinyPing: TinyPing
    @Binding var answerTinyPing: TinyPing
    @Binding private(set) var answerCount: Int
    let onCorrectAnswer: () -> Void  // 정답 맞췄을 때 호출하는 클로저
    
    var body: some View {
        Button {
            selectedTinyPing = tinyPing
            if let selectedTinyPing = selectedTinyPing {
                if selectedTinyPing.name == answerTinyPing.name {
                    answerCount += 1
                    onCorrectAnswer()  // 정답 맞췄을 때 호출
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
    NameQuiz()
        .environment(PathModel())
}
