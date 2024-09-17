//
//  MockDataBuilder.swift
//  TinyDex
//
//  Created by kyungsoolee on 9/18/24.
//

import Foundation

struct MockDataBuilder {
    
    // tinyping 데이터를 반환합니다.
    static var tinyping: TinyPing {
        return TinyPing(
            name: "플로라 하츄핑",
            avatar: "img_heartyouping",
            sex: Sex.female,
            nameDescription: "하트 + 츄",
            item: "향수(3기)",
            symbol: "하트",
            partner: "로미",
            transformation: "프린세스 플로라하트",
            magic: "<사랑의 향기>(3기 향수)\n향수를 뿌려서 상대 공격을 막을 수 있으며\n대상을 향기에 취하게 만들 수 있다.",
            favoriteThing: "로미와 함께 있는 모든 순간",
            dislikeThing: "억지로 잠을 깨우는 것\n갑자기 깜짝 놀라게 하는 것",
            favoriteFood: "생크림 딸기 케이크, 딸기",
            dislikeFood: "신 맛이 나는 모든 것"
        )
    }
}
