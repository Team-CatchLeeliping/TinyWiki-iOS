//
//  BackgroundColor.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/18/24.
//

import Foundation

enum BackgroundColor: String, Codable {
    case clear
    case pink
    case yellow
    case green
    case blue
    case purple
    
    var baseBackground: String {
        switch self {
        case .clear: return ""
        case .pink: return "img_detailbackgroundpink"
        case .yellow: return "img_detailbackgroundyellow"
        case .green: return "img_detailbackgroundgreen"
        case .blue: return "img_detailbackgroundblue"
        case .purple: return "img_detailbackgroundpurple"
        }
    }
    
    var descriptionBackground: String {
        switch self {
        case .clear: return ""
        case .pink: return "img_detaildescriptionbackgroundpink"
        case .yellow: return "img_detaildescriptionbackgroundyellow"
        case .green: return "img_detaildescriptionbackgroundgreen"
        case .blue: return "img_detaildescriptionbackgroundblue"
        case .purple: return "img_detaildescriptionbackgroundpurple"
        }
    }
}
