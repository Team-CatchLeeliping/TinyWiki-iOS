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
            ),
            TinyPing(
                name: "차차핑",
                avatar: "img_chachaping",
                generation: 1,
                sex: Sex.male,
                nameDescription: "차차하다",
                item: "물뿌리개",
                magic: "<희망의 물줄기>\n① 물을 뿌려 팅클퍼프 마법을 풀 수 있다.\n② 사물/대상의 크기를 키우거나, 시든 식물을 생생하게 만든다.",
                favoriteThings: "화초에 물 주기, 식물 보살피기, 꽃 향기 맡기, 격려하기",
                dislikeThings: "꽃을 꺾거나 잔디를 밟는 등의 행동, 부정적인 말과 행동",
                jewelry: nil,
                key: nil,
                backgroundColor: .green,
                isLiked: true
            ),
            TinyPing(
                name: "라라핑",
                avatar: "img_lalaping",
                generation: 1,
                sex: Sex.female,
                nameDescription: "라라라~♪(의성어)",
                item: "마이크",
                magic: "<즐거운 댄스>\n① 대상이 춤을 추게 만들 수 있다.\n② 대상이 잠시동안 무언가를 '즐겁게' 느끼게 만들 수 있다.\n③ 마이크를 사용해, 자신이 아닌 다른 이의 목소리를 낼 수 있다.",
                favoriteThings: "노래와 춤, 신나는 놀이, 수다",
                dislikeThings: "심각한 분위기, 지루한 것",
                jewelry: nil,
                key: nil,
                backgroundColor: .purple,
                isLiked: true
            ),
            TinyPing(
                name: "해핑",
                avatar: "img_happying",
                generation: 1,
                sex: Sex.female,
                nameDescription: "Happy(행복한)",
                item: "비눗방울 장난감",
                magic: "<행복의 방울방울>\n① 비눗방울 안에 대상을 가두거나, 누군가를 태워 이동시킬 수 있다.\n② 대상을 잠시동안 행복하게 만들 수 있다.",
                favoriteThings: "비눗방울 놀이, 낙서하기, 다른 티니핑 행동 따라하기",
                dislikeThings: "더 놀고 싶은데 자야 하는 것",
                jewelry: nil,
                key: nil,
                backgroundColor: .pink,
                isLiked: true
            ),
            TinyPing(
                name: "키키핑",
                avatar: "img_kikiping",
                generation: 1,
                sex: Sex.male,
                nameDescription: "키키(웃음소리)",
                item: "막대사탕",
                magic: "막대사탕으로 팅클퍼프를 뿌려 상대방을 장난꾸러기로 만든다.",
                favoriteThings: "재미있는 것, 장난",
                dislikeThings: "심심한 것, 지루한 것",
                jewelry: nil,
                key: nil,
                backgroundColor: .yellow,
                isLiked: true
            ),
            TinyPing(
                name: "아잉핑",
                avatar: "img_charmping",
                generation: 1,
                sex: Sex.female,
                nameDescription: "아잉~(애교부리는 소리)",
                item: "리본봉",
                magic: "리본봉으로 팅클퍼프를 뿌려 상대방을 심각한 애교쟁이로 만든다.",
                favoriteThings: "솜사탕",
                dislikeThings: "심각한 상황",
                jewelry: nil,
                key: nil,
                backgroundColor: .yellow,
                isLiked: true
            ),
            TinyPing(
                name: "부끄핑",
                avatar: "img_shyping",
                generation: 1,
                sex: Sex.female,
                nameDescription: "부끄럽다",
                item: "당근쿠션",
                magic: "당근쿠션으로 팅클퍼프를 뿌려 상대방을 엄청난 부끄럼쟁이로 만든다.",
                favoriteThings: "숨바꼭질",
                dislikeThings: "주목 받는 것",
                jewelry: nil,
                key: nil,
                backgroundColor: .purple,
                isLiked: true
            ),
            TinyPing(
                name: "부투핑",
                avatar: "img_dareping",
                generation: 1,
                sex: Sex.male,
                nameDescription: "승부를 붙다 → 부투",
                item: "깃발",
                magic: "① 잠시동안 상대가 승부욕에 불타오르게 만들 수 있다.\n② 자신의 마음을 차갑게 감출 수 있어, 콤팩트에 감지되기 힘들다.",
                favoriteThings: "대결, 경쟁, 승부",
                dislikeThings: "느릿느릿하고 느긋한 것",
                jewelry: nil,
                key: nil,
                backgroundColor: .pink,
                isLiked: true
            ),
            TinyPing(
                name: "깜빡핑",
                avatar: "img_blankping",
                generation: 1,
                sex: Sex.male,
                nameDescription: "승부를 붙다 → 부투",
                item: "깃발",
                magic: "① 대상이 잠시동안 '깜빡' 잊어버리게 만들 수 있다.\n② 지우개로 사물을 지우면, 사물이 순간적으로 사라졌다 나타난다.",
                favoriteThings: "여유, 느긋함",
                dislikeThings: "정확한 규율과 규칙, 바로핑의 잔소리!",
                jewelry: nil,
                key: nil,
                backgroundColor: .yellow,
                isLiked: true
            ),
            TinyPing(
                name: "드림핑",
                avatar: "img_dreamping",
                generation: 1,
                sex: Sex.male,
                nameDescription: "띠용~(의성어)",
                item: "마술사 모자와 마술봉",
                magic: "① 대상에게 잠시동안 '허상'이 보이게 할 수 있다.\n② 자신의 모습을 바꿀 수 있지만, 완벽하지 않다.",
                favoriteThings: "재미있고 엉뚱한 상상하기",
                dislikeThings: "상상력을 제한하는 모든 것!",
                jewelry: nil,
                key: nil,
                backgroundColor: .blue,
                isLiked: true
            )
        ]
    }
}
