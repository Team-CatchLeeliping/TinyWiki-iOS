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
    
    init(
        nameQuizService: NameQuizServiceInterface
    ) {
        self.nameQuizService = nameQuizService
        // exmapleTinyPings를 먼저 초기화한 후 answerTinyPing을 설정
        let shuffledTinyPings = Array(MockDataBuilder.tinyPings.shuffled().prefix(4))
        let answerTinyPing = shuffledTinyPings.randomElement() ?? MockDataBuilder.tinyPings.first! // 기본값 설정
        
        self.state = State(
            usedTinyPings: [],
            exmapleTinyPings: shuffledTinyPings,
            correctTinyPings: [],
            answerTinyPing: answerTinyPing
        )
    }
}


// MARK: - State

extension NameQuizUseCase {
    
    struct State {
        var usedTinyPings: [TinyPing]
        var exmapleTinyPings: [TinyPing]
        var correctTinyPings: [TinyPing] = []
        var answerTinyPing: TinyPing
    }
}

// MARK: - UseCase Method

extension NameQuizUseCase {
    // TODO: UI와 분리하기
    // 새로운 퀴즈를 생성하는 함수
    func generateNewQuiz() {
        // Service를 호출해서 state를 갱신
        nameQuizService.generateNewQuiz(state: &state)
    }
    
    // MARK: - Method to add correctTinyPing safely
    func addCorrectTinyPing(_ tinyPing: TinyPing) {
        state.correctTinyPings.append(tinyPing)
    }
}
