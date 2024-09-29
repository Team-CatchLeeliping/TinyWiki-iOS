//
//  NameQuizServiceInterface.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/29/24.
//

import Foundation

protocol NameQuizServiceInterface {
    func generateNewQuiz(state: inout NameQuizUseCase.State)
    func addCorrectTinyPing(state: inout NameQuizUseCase.State, tinyPing: TinyPing)
    func resetQuiz(state: inout NameQuizUseCase.State)
}
