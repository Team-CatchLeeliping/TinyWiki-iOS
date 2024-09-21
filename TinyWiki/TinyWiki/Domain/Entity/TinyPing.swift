//
//  TinyPing.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/18/24.
//

import Foundation

struct TinyPing: Codable, Identifiable, Equatable {
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
    
    // Equatable 프로토콜을 구현하여 같은 TinyPing을 비교할 수 있게 함
    static func == (lhs: TinyPing, rhs: TinyPing) -> Bool {
        return lhs.id == rhs.id
    }
}

class TinyPingManager: ObservableObject {
    private let userDefaults = UserDefaults.standard
    private let favoriteKey = "favoriteTinyPings"
    
    @Published var tinyPings: [TinyPing] = []
    
    init() {
        tinyPings = loadTinyPings()
    }

    // 리스트를 UserDefaults에 저장하는 함수
    func saveTinyPings(_ tinyPings: [TinyPing]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tinyPings) {
            userDefaults.set(encoded, forKey: favoriteKey)
        }
        // @Published로 업데이트를 반영하도록
        self.tinyPings = tinyPings
    }

    // UserDefaults에서 리스트를 불러오는 함수
    func loadTinyPings() -> [TinyPing] {
        if let savedData = userDefaults.data(forKey: favoriteKey) {
            let decoder = JSONDecoder()
            if let decodedTinypings = try? decoder.decode([TinyPing].self, from: savedData) {
                return decodedTinypings
            }
        }
        // 저장된 데이터가 없으면 초기 데이터를 반환
        return MockDataBuilder.tinyPings
    }
    
    // isLiked 값을 갱신하는 함수
    func updateIsLiked(for tinyPing: TinyPing) {
        var tinyPings = loadTinyPings()

        if let index = tinyPings.firstIndex(where: { $0.id == tinyPing.id }) {
            print(tinyPings[index])
            tinyPings[index].isLiked.toggle()  // isLiked 값 토글
        }
        // @Published로 업데이트를 반영하도록
        self.tinyPings = tinyPings
        
        saveTinyPings(tinyPings)  // 변경된 리스트 저장
    }

    // 특정 TinyPing을 삭제하는 함수
    func deleteTinyPing(_ tinyPing: TinyPing) {
        // 저장된 TinyPing 리스트 불러오기
        var tinyPings = loadTinyPings()
        
        // 리스트에서 해당 TinyPing을 삭제
        tinyPings.removeAll { $0 == tinyPing }
        
        // 변경된 리스트 다시 저장
        saveTinyPings(tinyPings)
    }
}
