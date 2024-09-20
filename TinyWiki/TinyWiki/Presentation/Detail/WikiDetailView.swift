//
//  WikiDetailView.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/18/24.
//

import SwiftUI

struct WikiDetailView: View {
    var tinyPing: TinyPing
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                Image(tinyPing.backgroundColor.baseBackground)
                    .resizable()
                    .scaledToFill()
                VStack(spacing: 0) {
                    Header(tinyPing: tinyPing)
                    Image(tinyPing.avatar)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220)
                    Description(tinyPing: tinyPing)
                }
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - 헤더
private struct Header: View {
    var tinyPing: TinyPing
    var body: some View {
        Text("♡\(tinyPing.name)♡")
            .font(.Head.head1)
            .padding(EdgeInsets(top: 64, leading: 0, bottom: 50, trailing: 0))
            .foregroundStyle(.tinyWhite)
    }
}

// MARK: - 상세 설명
private struct Description: View {
    var tinyPing: TinyPing
    var titleColor: Color
    var bodyColor: Color
    var sexColor: Color
    init(tinyPing: TinyPing) {
        self.tinyPing = tinyPing
        self.titleColor = {
            switch tinyPing.backgroundColor {
            case .clear: return Color.clear
            case .pink: return .tinyLightpink
            case .yellow: return .tinyLightyellow
            case .green: return .tinyLightgreen
            case .blue: return .tinyBlue
            case .purple: return .tinyLightpurple
            }
        }()
        self.bodyColor = {
            switch tinyPing.backgroundColor {
            case .clear: return Color.clear
            case .pink: return .tinyDarkpink
            case .yellow: return .tinyDarkyellow
            case .green: return .tinyDarkgreen
            case .blue: return .tinyDarkblue
            case .purple: return .tinyDarkpurple
            }
        }()
        self.sexColor = {
            switch tinyPing.sex {
            case .male: return .tinyBlue
            case .female: return .tinyPink
            }
        }()
    }
    var body: some View {
        ZStack(alignment: .top) {
            Image(tinyPing.backgroundColor.descriptionBackground)
                .resizable()
                .scaledToFill()
            // TODO: 왜 이거를 붙이면 화면이 안깨질까?..
                .frame(maxWidth: 0)
            
            VStack(alignment: .leading, spacing: 24) {
                Spacer()
                    .frame(height: 40)
                
                // 기본 정보
                HStack(spacing: 0) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("성별")
                        Text("이름 유래")
                        Text("소품")
                    }
                    .foregroundStyle(titleColor)
                    .font(.Body.body1)
                    
                    Spacer()
                        .frame(width: 74)
                    VStack(alignment: .leading, spacing: 10) {
                        Text(tinyPing.sex.title)
                            .foregroundStyle(sexColor)
                        Text(tinyPing.nameDescription)
                        Text(tinyPing.item)
                    }
                    .foregroundStyle(bodyColor)
                    .font(.Head.head6)
                    
                    Spacer()
                }
                
                // 마법
                VStack(alignment: .leading, spacing: 10) {
                    Text("마법")
                        .foregroundStyle(titleColor)
                        .font(.Body.body1)
                    
                    Text(tinyPing.magic)
                        .foregroundStyle(bodyColor)
                        .font(.Head.head6)
                        .lineSpacing(10)
                }
                
                // 보석
                if let jewelry = tinyPing.jewelry {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("보석")
                            .foregroundStyle(titleColor)
                            .font(.Body.body1)
                        
                        Text(jewelry)
                            .foregroundStyle(bodyColor)
                            .font(.Head.head6)
                    }
                }
                
                // 열쇠
                if let jewelry = tinyPing.jewelry {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("키")
                            .foregroundStyle(titleColor)
                            .font(.Body.body1)
                        
                        Text(jewelry)
                            .foregroundStyle(bodyColor)
                            .font(.Head.head6)
                    }
                }
                
                // 좋아하는 것
                VStack(alignment: .leading, spacing: 10) {
                    Text("좋아하는 것")
                        .foregroundStyle(titleColor)
                        .font(.Body.body1)
                    
                    Text(tinyPing.favoriteThings)
                        .foregroundStyle(bodyColor)
                        .font(.Head.head6)
                }
                
                // 싫어하는 것
                VStack(alignment: .leading, spacing: 10) {
                    Text("싫어하는 것")
                        .foregroundStyle(.tinyBlack)
                        .font(.Body.body1)
                    
                    Text(tinyPing.dislikeThings)
                        .foregroundStyle(bodyColor)
                        .font(.Head.head6)
                        .lineSpacing(10)
                }
                
                
            }
            .padding(44)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    WikiDetailView(tinyPing: MockDataBuilder.tinyPing)
}
