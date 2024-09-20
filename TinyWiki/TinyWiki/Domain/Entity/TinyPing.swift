//
//  TinyPing.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/18/24.
//

import Foundation

struct TinyPing: Identifiable {
    var id: UUID
    // 이름
    var name: String
    // 프로필 사진
    var avatar: String
    // 기수
    var generation: Int
    // 성별
    var sex: Sex
    // 이름 유래
    var nameDescription: String
    // 소품
    var item: String
    // 마법
    var magic: String
    // 좋아하는 것
    var favoriteThings: String
    // 싫어하는 것
    var dislikeThings: String
    // 보석(Optional)
    var jewelry: String?
    // 열쇠(Optional)
    var key: String?
    // 상세 뷰 배경색
    var backgroundColor: BackgroundColor
    // 즐겨찾기 여부
    var isLiked: Bool
    
    init(
        name: String,
        avatar: String,
        generation: Int,
        sex: Sex,
        nameDescription: String,
        item: String,
        magic: String,
        favoriteThings: String,
        dislikeThings: String,
        jewelry: String?,
        key: String?,
        backgroundColor: BackgroundColor,
        isLiked: Bool
    ) {
        self.id = UUID()
        self.name = name
        self.avatar = avatar
        self.generation = generation
        self.sex = sex
        self.nameDescription = nameDescription
        self.item = item
        self.magic = magic
        self.favoriteThings = favoriteThings
        self.dislikeThings = dislikeThings
        self.jewelry = jewelry
        self.key = key
        self.backgroundColor = backgroundColor
        self.isLiked = isLiked
    }
    
}
