//
//  MockDataBuilder.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/18/24.
//

import Foundation

struct MockDataBuilder {
    
    // tinyping 데이터를 반환합니다.
    static var tinyPing: TinyPing {
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
            dislikeFood: "신 맛이 나는 모든 것",
            backgroundColor: .pink,
            isLiked: true
        )
    }
    
    // tinypings 데이터를 반환합니다.
    static var tinyPings: [TinyPing] {
        return [
            TinyPing(
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
                dislikeFood: "신 맛이 나는 모든 것",
                backgroundColor: .pink,
                isLiked: true
            ),
            TinyPing(
                name: "꾸래핑",
                avatar: "img_gguraeping",
                sex: Sex.female,
                nameDescription: "그래 -> 꾸래",
                item: "눈사람(3기)",
                symbol: "없음",
                partner: "없음",
                transformation: "프린세스 크리스탈",
                magic: "<평화의 눈덩이>\n눈사람으로 다양한 크기의 눈덩이를 만들 수 있다.\n<평화의 크리스탈>\n단단한 크리스탈 재질의 얼음으로 얼려버린다.",
                favoriteThing: "낮잠자기, 간식타임, 추운 날, 눈 오는 날",
                dislikeThing: "다툼, 혼란한 상황",
                favoriteFood: "-",
                dislikeFood: "-",
                backgroundColor: .blue,
                isLiked: true
            )
        ]
    }
}
