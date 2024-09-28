//
//  NameQuizService.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/29/24.
//

import Foundation

struct NameQuizService: NameQuizServiceInterface {
    func generateNewQuiz(state: inout NameQuizUseCase.State) {
        // 이전에 사용된 티니핑을 제외하고 새로운 티니핑 목록을 필터링
        let availableTinyPings = MockDataBuilder.tinyPings.filter { !state.usedTinyPings.contains($0) }
        
        // 4개의 티니핑을 랜덤으로 선택 (TinyPing이 있는 경우에만)
        if !availableTinyPings.isEmpty {
            state.exmapleTinyPings = Array(availableTinyPings.shuffled().prefix(4))
            
            // 정답은 availableTinyPings 중에서 선택, 빈 배열일 경우 nil 유지
            state.answerTinyPing = state.exmapleTinyPings.randomElement() ?? MockDataBuilder.tinyPings.first!
            
            // 사용된 티니핑에 정답 추가 (정답이 있을 때만 추가)
//            if let answer = state.answerTinyPing {
//                state.usedTinyPings.append(answer)
//            }
            state.usedTinyPings.append(state.answerTinyPing)
        }
        
        // 만약 사용된 티니핑이 전체보다 많아지면 초기화 (전부 다 사용된 경우를 대비)
        if state.usedTinyPings.count >= MockDataBuilder.tinyPings.count {
            state.usedTinyPings.removeAll()
        }
    }
}
