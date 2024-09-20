//
//  Tab.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/18/24.
//

import Foundation

enum Tab: Identifiable, CaseIterable {
    case menu
    case heart
    
    /// ID를 생성합니다.
    var id: UUID {
        return .init()
    }
    
    /// 탭바의 타이틀을 반환합니다.
    var title: String {
        switch self {
        case .menu: return "메뉴"
        case .heart: return "즐겨찾기"
        }
    }
    
    /// 탭바의 아이콘을 반환합니다.
    var icon: String {
        switch self {
        case .menu: return SystemImage.menu
        case .heart: return SystemImage.heart
        }
    }
    
    var emptyIcon: String {
        switch self {
        case .menu: return SystemImage.emptyMenu
        case .heart: return SystemImage.emptyHeart
        }
    }
}
