//
//  ImageQuizService.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/30/24.
//

import Foundation

struct ImageQuizService: ImageQuizServiceInterface {
    func addCorrectTinyPing(state: inout ImageQuizUseCase.State, tinyPing: TinyPing) {
        state.correctTinyPings.append(tinyPing)
    }
    
    func generateNewQuiz(state: inout ImageQuizUseCase.State) {
        // 사용된 티니핑을 제외하고 새로운 티니핑 목록을 필터링
        var availableTinyPings = MockDataBuilder.tinyPings.filter { tinyPing in
            !state.usedTinyPings.contains { $0.name == tinyPing.name }
        }
        
        // 4개의 티니핑이 부족할 경우, usedTinyPings를 초기화하고 다시 필터링
        if availableTinyPings.count < 4 {
            state.usedTinyPings.removeAll()
            availableTinyPings = MockDataBuilder.tinyPings
        }
        
        // 4개의 티니핑을 랜덤으로 선택 (TinyPing이 있는 경우에만)
        if !availableTinyPings.isEmpty {
            state.exmapleTinyPings = Array(availableTinyPings.shuffled().prefix(4))
            
            // 정답은 availableTinyPings 중에서 선택, 빈 배열일 경우 nil 유지
            state.answerTinyPing = state.exmapleTinyPings.randomElement() ?? MockDataBuilder.tinyPings.first!
            
            // 정답을 사용된 티니핑 목록에 추가
            state.usedTinyPings.append(state.answerTinyPing)
        }
        
        // 만약 사용된 티니핑이 전체보다 많아지면 초기화 (전부 다 사용된 경우를 대비)
        if state.usedTinyPings.count >= MockDataBuilder.tinyPings.count {
            state.usedTinyPings.removeAll()
        }
    }
    
    func resetQuiz(state: inout ImageQuizUseCase.State) {
        state.usedTinyPings.removeAll()
        state.exmapleTinyPings.removeAll()
        state.answerTinyPing = state.exmapleTinyPings.randomElement() ?? MockDataBuilder.tinyPings.first!
        state.correctTinyPings.removeAll()
    }
}
