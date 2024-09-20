//
//  HomeView.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/18/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(PathModel.self) private var pathModel
    @State private var selectedTab: Tab = .wiki
    // TODO: 임시 데이터 추후 수정하기
    @State var selectedTinyPing: TinyPing = MockDataBuilder.tinyPing
    
    init() {
        // 네비게이션 바의 appearance 설정
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        // 타이틀 텍스트의 폰트 및 색상 설정
        appearance.titleTextAttributes = [
            .font: UIFont.Head.head1,  // UIFont 사용
            .foregroundColor: UIColor.white  // UIColor 사용
        ]
        
        // 네비게이션 바에 appearance 적용
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        @Bindable var pathModel = pathModel
        NavigationStack(path: $pathModel.paths) {
            ZStack(alignment: .bottom) {
                switch selectedTab {
                case .wiki: WikiView(selectedTinyping: $selectedTinyPing)
                case .quiz: QuizView()
                }
                TabBar(selection: $selectedTab)
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationDestination(for: MainPath.self) { path in
                switch path {
                case .detailView: WikiDetailView(tinyPing: selectedTinyPing)
                        .navigationTitle("♡\(selectedTinyPing.name)♡")
                }
            }
        }
        .environment(pathModel)
    }
}

private struct TabBar: View {
    @Binding private(set) var selection: Tab
    var body: some View {
        HStack {
            ForEach(Tab.allCases) { tab in
                Spacer()
                Button {
                    print(tab)
                    selection = tab
                } label: {
                    VStack {
                        Image(systemName: selection == tab ? tab.icon : tab.emptyIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 36)
                        Text(tab.title)
                            .font(.Body.body5)
                    }
                }
                .contentShape(Rectangle())
                .foregroundStyle(.tinyWhite)
                Spacer()
            }
        }
        .padding(30)
        .background(Color.tinyLightpink)
        .cornerRadius(30)
    }
}


// MARK: - Preview
#Preview {
    HomeView()
        .environment(PathModel())
}

//#Preview {
//    TabBar(selection: .constant(Tab.menu))
//}
