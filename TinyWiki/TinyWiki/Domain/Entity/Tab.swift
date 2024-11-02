//
//  Tab.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/18/24.
//

import Foundation

enum Tab: Identifiable, CaseIterable {
    case wiki
    case quiz
    
    /// ID를 생성합니다.
    var id: UUID {
        return .init()
    }
    
    /// 탭바의 타이틀을 반환합니다.
    var title: String {
        switch self {
        case .wiki: return "티니위키"
        case .quiz: return "티니퀴즈"
        }
    }
    
    /// 탭바의 아이콘을 반환합니다.
    var icon: String {
        switch self {
        case .wiki: return SystemImage.menu
        case .quiz: return SystemImage.heart
        }
    }
    
    var emptyIcon: String {
        switch self {
        case .wiki: return SystemImage.emptyMenu
        case .quiz: return SystemImage.emptyHeart
        }
    }
}
