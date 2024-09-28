//
//  NameQuizUseCase.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/29/24.
//

import Foundation

@Observable
final class NameQuizUseCase {
    private(set) var nameQuizService: NameQuizServiceInterface
    private(set) var state: State
    
    init(nameQuizService: NameQuizServiceInterface, state: State) {
        self.nameQuizService = nameQuizService
        self.state = state
    }
}


// MARK: - State

extension NameQuizUseCase {
    
    struct State {
        var usedTinyPings: [TinyPing]
        var exmapleTinyPings: [TinyPing]
        var answerTinyPing: TinyPing
    }
}

// MARK: - UseCase Method

extension NameQuizUseCase {
    // TODO: UI와 분리하기
    // 새로운 퀴즈를 생성하는 함수
    func generateNewQuiz() {
        // 이전에 사용된 티니핑을 제외하고 새로운 티니핑 목록을 필터링
        let availableTinyPings = MockDataBuilder.tinyPings.filter { !state.usedTinyPings.contains($0) }
        
        // 4개의 티니핑을 랜덤으로 선택
        state.exmapleTinyPings = Array(availableTinyPings.shuffled().prefix(4))
        
        // 정답은 exampleTinyPings 중 하나로 선택
        state.answerTinyPing = state.exmapleTinyPings.randomElement() ?? MockDataBuilder.tinyPing
        
        // 사용된 티니핑에 정답 추가
        state.usedTinyPings.append(state.answerTinyPing)
        
        // 만약 사용된 티니핑이 전체보다 많아지면 초기화 (전부 다 사용된 경우를 대비)
        if state.usedTinyPings.count >= MockDataBuilder.tinyPings.count {
            state.usedTinyPings.removeAll()
        }
    }
    
}
