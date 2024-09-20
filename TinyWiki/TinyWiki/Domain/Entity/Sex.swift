//
//  Sex.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/18/24.
//

import SwiftUI

enum Sex: Identifiable, CaseIterable {
    case male
    case female
    
    /// ID를 생성합니다.
    var id: UUID {
        return .init()
    }
    
    /// 탭바의 타이틀을 반환합니다.
    var title: String {
        switch self {
        case .male: return "남자"
        case .female: return "여자"
        }
    }
    
    /// 상세 정보에 표시될 색상을 반환합니다.
    var color: Color {
        switch self {
        case .male: return .tinyBlue
        case .female: return .tinyPink
        }
    }
}
