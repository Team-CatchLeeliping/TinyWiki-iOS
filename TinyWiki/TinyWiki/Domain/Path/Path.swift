//
//  Path.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/18/24.
//

import Foundation

enum MainPath: Hashable {
    case detailView
    case nameQuizView
    case nameQuizResultView
    case imageQuizView
    case imageQuizResultView
}

@Observable
final class PathModel {
    var paths: [MainPath] = []
}
