//
//  HomeView.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/18/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(PathModel.self) private var pathModel
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTab: Tab = .wiki
    // TODO: 임시 데이터 추후 수정하기
    @State var selectedTinyPing: TinyPing = MockDataBuilder.tinyPing
    @State private var searchKeyword: String = ""
    
    var body: some View {
        @Bindable var pathModel = pathModel
        NavigationStack(path: $pathModel.paths) {
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                    .frame(height: 10)
                Header(searchKeyword: $searchKeyword, selectedTab: $selectedTab)
                switch selectedTab {
                case .wiki: WikiView(searchKeyword: $searchKeyword, selectedTinyping: $selectedTinyPing)
//                case .quiz: QuizView()
                }
                TabBar(selection: $selectedTab)
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationDestination(for: MainPath.self) { path in
                switch path {
                case .detailView: WikiDetailView(tinyPing: selectedTinyPing)
                        .navigationTitle("♡\(selectedTinyPing.name)♡")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
            .background {
                Image(.imgHomebackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
        }
        .environment(pathModel)
    }
}

// MARK: - 헤더
private struct Header: View {
    @Binding private(set) var searchKeyword: String
    @Binding var selectedTab: Tab
    var body: some View {
        HStack(spacing: 0) {
            Text(selectedTab.title)
                .font(.Head.head5)
                .foregroundStyle(.tinyPink)
            Spacer()
            if selectedTab == Tab.wiki {
                SearchView(searchKeyword: $searchKeyword)
            }
        }
        .frame(height: 44)
        .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
        .onTapGesture {
            UIApplication.shared.endEditing()  // 빈 공간 클릭 시 키보드 내리기
        }
    }
}

// MARK: - 검색창
private struct SearchView: View {
    @Binding private(set) var searchKeyword: String
    var body: some View {
        HStack(spacing: 0) {
            ZStack(alignment: .leading) {
                if searchKeyword.isEmpty {
                    Text("티니핑을 찾아봐요♥")
                        .foregroundColor(.gray)
                        .font(.Body.body4)
                        .padding(.leading, 10)
                }
                TextField("", text: $searchKeyword)
                    .font(.Body.body4)
                    .foregroundColor(.black)
                    .padding(.leading, 8)
            }
            Image(systemName: SystemImage.search)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundStyle(.tinyLightpink)
        }
        .padding(12)
        .overlay {
            RoundedRectangle(cornerRadius: 40)
                .stroke(.tinyPink, lineWidth: 4)
        }
        .background(.tinyWhite)
        .cornerRadius(40)
        .contentShape(Rectangle())
    }
}

// MARK: - 탭바
private struct TabBar: View {
    @Binding private(set) var selection: Tab
    var body: some View {
        HStack {
            // TODO: 티니퀴즈 구현되면 아래 코드 주석 복원하기
            Spacer()
//            ForEach(Tab.allCases) { tab in
                Button {
                    print(selection)
//                    selection = tab
                    selection = .wiki
                } label: {
                    VStack {
                        Image(systemName: /*selection == tab ? tab.icon : tab.emptyIcon*/ selection.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 24)
                        Text(selection.title)
                            .font(.Body.body5)
                    }
                }
                .contentShape(Rectangle())
                .foregroundStyle(.tinyWhite)
                .frame(width: 60)
//                if tab != .quiz {
//                    Spacer()
//                        .frame(width: 128)
//                }
//            }
            Spacer()
        }
        .frame(height: 88)
//        .padding(30)
        .background(Color.tinyLightpink)
//        .cornerRadius(20)
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
