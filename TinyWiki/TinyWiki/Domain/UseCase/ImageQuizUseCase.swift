//
//  ImageQuizUseCase.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/30/24.
//

import Foundation

@Observable
final class ImageQuizUseCase {
    private(set) var imageQuizService: ImageQuizServiceInterface
    private(set) var state: State
    
    init(
        imageQuizService: ImageQuizServiceInterface
    ) {
        self.imageQuizService = imageQuizService
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

extension ImageQuizUseCase {
    
    struct State {
        var usedTinyPings: [TinyPing]
        var exmapleTinyPings: [TinyPing]
        var correctTinyPings: [TinyPing] = []
        var answerTinyPing: TinyPing
    }
}

// MARK: - UseCase Method

extension ImageQuizUseCase {
    // TODO: UI와 분리하기
    // 새로운 퀴즈를 생성하는 함수
    func generateNewQuiz() {
        // Service를 호출해서 state를 갱신
        imageQuizService.generateNewQuiz(state: &state)
    }
    
    // MARK: - Method to add correctTinyPing safely
    func addCorrectTinyPing(tinyPing: TinyPing) {
        imageQuizService.addCorrectTinyPing(state: &state, tinyPing: tinyPing)
    }
    
    
    func resetQuiz() {
        imageQuizService.resetQuiz(state: &state)
    }
}
