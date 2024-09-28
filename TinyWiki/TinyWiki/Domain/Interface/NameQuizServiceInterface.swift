//
//  NameQuizServiceInterface.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/29/24.
//

import Foundation

protocol NameQuizServiceInterface {
    func generateNewQuiz(state: inout NameQuizUseCase.State)
}
