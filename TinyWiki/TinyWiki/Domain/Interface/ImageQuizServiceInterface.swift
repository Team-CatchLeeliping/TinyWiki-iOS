//
//  ImageQuizServiceInterface.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/30/24.
//

import Foundation

protocol ImageQuizServiceInterface {
    func generateNewQuiz(state: inout ImageQuizUseCase.State)
    func addCorrectTinyPing(state: inout ImageQuizUseCase.State, tinyPing: TinyPing)
    func resetQuiz(state: inout ImageQuizUseCase.State)
}
