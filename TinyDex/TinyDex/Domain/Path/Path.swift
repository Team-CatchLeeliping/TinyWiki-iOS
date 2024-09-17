//
//  Path.swift
//  TinyDex
//
//  Created by kyungsoolee on 9/18/24.
//

import Foundation

enum MainPath: Hashable {
    case detailView
}

@Observable
final class PathModel {
    var paths: [MainPath] = []
}
