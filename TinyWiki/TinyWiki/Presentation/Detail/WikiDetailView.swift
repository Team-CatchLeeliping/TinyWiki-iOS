//
//  WikiDetailView.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/18/24.
//

import SwiftUI

struct WikiDetailView: View {
    var tinyPing: TinyPing
    @State private var scrollOffset: CGFloat = 0  // 스크롤 오프셋을 저장할 상태 변수
    @State private var isScroll: Bool = false
    let navigationTitleColor: UIColor
    init(tinyPing: TinyPing) {
        self.tinyPing = tinyPing
        self.navigationTitleColor = {
            switch tinyPing.backgroundColor {
            case .clear: return UIColor.clear
            case .pink: return .tinyLightpink
            case .yellow: return .tinyLightyellow
            case .green: return .tinyLightgreen
            case .blue: return .tinyBlue
            case .purple: return .tinyLightpurple
            }
        }()
    }
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                Image(tinyPing.backgroundColor.baseBackground)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 0)
                VStack(spacing: 0) {
                    GeometryReader { geometry in
                        Color.clear
                            .preference(key: ScrollOffsetKey.self, value: geometry.frame(in: .global).minY)
                    }
                    .frame(height: 0) // 오프셋 감지용 프레임
                    VStack(spacing: 0) {
                        Spacer()
                            .frame(height: 100)
                        Image(tinyPing.avatar)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 220)
                        Description(tinyPing: tinyPing)
                    }
                }
            }
        }
        .onPreferenceChange(ScrollOffsetKey.self) { value in
            scrollOffset = value  // 스크롤 오프셋을 상태 변수에 저장
            //            alpha =  (-1) * max(0, 0.5) * scrollOffset * 2 / 1000
//            if value < 0 {
//                isScroll = true
//                updateNavigationBarAppearance(scrollOffset: value, navigationTitleColor: navigationTitleColor)
//            } else {
//                isScroll = false
//            }
        }
//        .onAppear {
//            setupNavigationAppearance(scrollOffset: scrollOffset, navigationTitleColor: navigationTitleColor)
//        }
        .background(NavigationBarAppearanceModifier(scrollOffset: scrollOffset, navigationTitleColor: navigationTitleColor))
        .ignoresSafeArea()
    }
}

//// TODO: 추후 빼기
//func setupNavigationAppearance(scrollOffset: CGFloat, navigationTitleColor: UIColor) {
//    let appearance = UINavigationBarAppearance()
//    appearance.configureWithOpaqueBackground()
//    
//    // 타이틀 텍스트 색상 및 폰트 설정
//    appearance.titleTextAttributes = [
//        .font: UIFont.Head.head1,  // UIFont 사용
//        .foregroundColor: navigationTitleColor  // 다크 모드에 따라 색상 설정
//    ]
//    appearance.backgroundColor = UIColor.white.withAlphaComponent(0)  // 투명도 조정 (0.0 ~ 1.0)
//    
//    appearance.shadowColor = nil  // 이 부분이 선을 없앰
//    
//    // 네비게이션 바에 appearance 적용
//    UINavigationBar.appearance().standardAppearance = appearance
//    UINavigationBar.appearance().scrollEdgeAppearance = appearance
//    
//}
//
//func updateNavigationBarAppearance(scrollOffset: CGFloat, navigationTitleColor: UIColor) {
//    let maxAlpha = 0.5
//    let alpha =  (-1) * max(0, maxAlpha) * scrollOffset * 2 / 1000 
//    print(alpha)
//    
//    let appearance = UINavigationBarAppearance()
//    appearance.configureWithOpaqueBackground()
//    
//    // 타이틀 텍스트 색상 및 폰트 설정
//    appearance.titleTextAttributes = [
//        .font: UIFont.Head.head1,  // UIFont 사용
//        .foregroundColor: navigationTitleColor  // 다크 모드에 따라 색상 설정
//    ]
//    appearance.backgroundColor = UIColor.white.withAlphaComponent(alpha)  // 투명도 조정 (0.0 ~ 1.0)
//    
//    appearance.shadowColor = nil  // 이 부분이 선을 없앰
//        
//    // 네비게이션 바에 appearance 적용
//    UINavigationBar.appearance().standardAppearance = appearance
//    UINavigationBar.appearance().scrollEdgeAppearance = appearance
//}


// MARK: - 스크롤 오프셋 추적을 위한 PreferenceKey
struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
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
                .frame(maxWidth: .infinity)  // 화면 너비에 맞추기
            VStack(alignment: .leading, spacing: 24) {
                Spacer()
                    .frame(height: 16)
                
                // 기본 정보
                VStack(alignment: .leading, spacing: 10) {
                    
                    HStack(spacing: 0) {
                        Text("성별")
                            .foregroundStyle(titleColor)
                            .font(.Body.body1)
                            .frame(width: 64, alignment: .leading)
                        Spacer()
                            .frame(width: 68)
                        Text(tinyPing.sex.title)
                            .foregroundStyle(sexColor)
                            .foregroundStyle(bodyColor)
                            .font(.Head.head6)
                            .lineSpacing(10)
                    }
                    
                    HStack(spacing: 0) {
                        Text("이름 유래")
                            .foregroundStyle(titleColor)
                            .font(.Body.body1)
                            .frame(width: 64, alignment: .leading)
                        Spacer()
                            .frame(width: 68)
                        Text(tinyPing.nameDescription)
                            .foregroundStyle(sexColor)
                            .foregroundStyle(bodyColor)
                            .font(.Head.head6)
                            .lineSpacing(10)
                    }
                    
                    HStack(spacing: 0) {
                        Text("소품")
                            .foregroundStyle(titleColor)
                            .font(.Body.body1)
                            .frame(width: 64, alignment: .leading)
                        Spacer()
                            .frame(width: 68)
                        Text(tinyPing.item)
                            .foregroundStyle(sexColor)
                            .foregroundStyle(bodyColor)
                            .font(.Head.head6)
                            .lineSpacing(10)
                    }
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
                            .lineSpacing(10)
                    }
                }
                
                // 열쇠
                if let key = tinyPing.key {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("키")
                            .foregroundStyle(titleColor)
                            .font(.Body.body1)
                        
                        Text(key)
                            .foregroundStyle(bodyColor)
                            .font(.Head.head6)
                            .lineSpacing(10)
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
                        .lineSpacing(10)
                }
                
                // 싫어하는 것
                VStack(alignment: .leading, spacing: 10) {
                    Text("싫어하는 것")
                        .foregroundStyle(titleColor)
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
