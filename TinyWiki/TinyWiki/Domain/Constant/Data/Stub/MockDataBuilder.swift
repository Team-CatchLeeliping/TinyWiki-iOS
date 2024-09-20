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
            generation: 1,
            sex: Sex.female,
            nameDescription: "하트 + 츄",
            item: "향수(3기)",
            magic: "<사랑의 향기>(3기 향수)\n향수를 뿌려서 상대 공격을 막을 수 있으며\n대상을 향기에 취하게 만들 수 있다.",
            favoriteThings: "로미와 함께 있는 모든 순간",
            dislikeThings: "억지로 잠을 깨우는 것\n갑자기 깜짝 놀라게 하는 것",
            jewelry: nil,
            key: nil,
            backgroundColor: .pink,
            isLiked: true)
    }
    
    // tinypings 데이터를 반환합니다.
    static var tinyPings: [TinyPing] {
        return [
            TinyPing(
                name: "플로라 하츄핑",
                avatar: "img_heartyouping",
                generation: 1,
                sex: Sex.female,
                nameDescription: "하트 + 츄",
                item: "향수(3기)",
                magic: "<사랑의 향기>(3기 향수)\n향수를 뿌려서 상대 공격을 막을 수 있으며\n대상을 향기에 취하게 만들 수 있다.",
                favoriteThings: "로미와 함께 있는 모든 순간",
                dislikeThings: "억지로 잠을 깨우는 것\n갑자기 깜짝 놀라게 하는 것",
                jewelry: nil,
                key: nil,
                backgroundColor: .pink,
                isLiked: true),
            TinyPing(
                name: "꾸래핑",
                avatar: "img_gguraeping",
                generation: 1,
                sex: Sex.female,
                nameDescription: "그래 -> 꾸래",
                item: "눈사람(3기)",
                magic: "<평화의 눈덩이>\n눈사람으로 다양한 크기의 눈덩이를 만들 수 있다.\n<평화의 크리스탈>\n단단한 크리스탈 재질의 얼음으로 얼려버린다.",
                favoriteThings: "낮잠자기, 간식타임, 추운 날, 눈 오는 날",
                dislikeThings: "다툼, 혼란한 상황",
                jewelry: nil,
                key: nil,
                backgroundColor: .blue,
                isLiked: true
            ),
            TinyPing(
                name: "바로핑",
                avatar: "img_baroping",
                generation: 1,
                sex: Sex.male,
                nameDescription: "(올)바르다 → 바로",
                item: "마법책",
                magic: "<올바른 문법>\n① 기호/이모티콘을 만들어 날릴 수 있다.\n② 상대가 '바른 생활'을 하도록 만들 수 있다.",
                favoriteThings: "깔끔하게 정돈된 환경, 독서, 공부, 뭔가를 가르치기",
                dislikeThings: "늦잠, 게으름, 무질서한 상태, 더러운 환경",
                jewelry: nil,
                key: nil,
                backgroundColor: .blue,
                isLiked: false
            ),
            TinyPing(
                name: "아자핑",
                avatar: "img_azaping",
                generation: 1,
                sex: Sex.male,
                nameDescription: "아자(기합 소리)",
                item: "카메라",
                magic: "<용기의 플래시>\n① 상대를 잠시동안 움직이지 못하게 만든다.\n② 대상에게 잠시동안 '용기'를 북돋아줄 수 있다.",
                favoriteThings: "체력단련, 격투기 및 액션 영화 보기",
                dislikeThings: "두려움, 도망치기, 포기하기",
                jewelry: nil,
                key: nil,
                backgroundColor: .yellow,
                isLiked: true
            )
        ]
    }
}
