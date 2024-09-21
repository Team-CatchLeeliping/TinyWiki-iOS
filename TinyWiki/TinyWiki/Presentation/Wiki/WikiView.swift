//
//  WikiView.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/18/24.
//

import SwiftUI

struct WikiView: View {
    @Binding var searchKeyword: String
    @Binding var selectedTinyping: TinyPing
    @StateObject private var tinyPingManager = TinyPingManager()
    @State private var scrollOffset: CGFloat = 0  // 스크롤 오프셋을 저장할 상태 변수
    @State private var isScroll: Bool = false
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 12)
            ScrollView {
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: ScrollOffsetKey.self, value: geometry.frame(in: .global).minY)
                }
                .frame(height: 0) // 오프셋 감지용 프레임
                VStack(spacing: 0) {
                    TinypingList(
                        selectedTinyPing: $selectedTinyping,
                        searchKeyword: $searchKeyword,
                        tinyPings: $tinyPingManager.tinyPings
                    )
                }
            }
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                UIApplication.shared.endEditing()
                scrollOffset = value  // 스크롤 오프셋을 상태 변수에 저장
            }
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
}



// MARK: - 티니핑 리스트
private struct TinypingList: View {
    @Binding var selectedTinyPing: TinyPing
    @Binding var searchKeyword: String
    @Binding private(set) var tinyPings: [TinyPing]
    // filteredTinypings 들어오면서 필요 없어짐.
    //    let tinyPings: [TinyPing] = MockDataBuilder.tinyPings
    
    
    var filteredTinyPings: [TinyPing] {
        if searchKeyword.isEmpty {
            // isLiked가 true인 항목을 먼저 정렬하여 반환
            return tinyPings.sorted { $0.isLiked && !$1.isLiked }
        } else {
            // 검색어에 맞는 항목을 필터링하고, 그 중에서 isLiked가 true인 항목을 먼저 정렬
            return tinyPings.filter { $0.name.contains(searchKeyword) }
                .sorted { $0.isLiked && !$1.isLiked }
        }
    }
    private let columns: [GridItem] = Array(repeating: .init(.fixed(180), spacing: nil), count: 2)
    var body: some View {
        LazyVGrid(columns: columns , spacing: 8) {
            ForEach(filteredTinyPings.indices, id: \.self) { index in
                TinypingCell(
                    selectedTinyPing: $selectedTinyPing,
                    tinyPings: $tinyPings,
                    tinyPing: $tinyPings[index]
                )
                    .transition(.move(edge: .top))  // 애니메이션 적용
            }
        }
        .onAppear {
            tinyPings.sort { $0.isLiked && !$1.isLiked }
        }
        .padding(8)
    }
}

// MARK: - 티니핑 리스트 셀
private struct TinypingCell: View {
    @Environment(PathModel.self) private var pathModel
    @Binding private(set) var selectedTinyPing: TinyPing
    @Binding private(set) var tinyPings: [TinyPing]
    @Binding var tinyPing: TinyPing
    var body: some View {
        Button {
            selectedTinyPing = tinyPing
            pathModel.paths.append(.detailView)
        } label: {
            ZStack {
                VStack(spacing: 0) {
                    Text("♡\(tinyPing.name)♡")
                        .font(.Body.body1)
                        .foregroundStyle(.tinyPink)
                    Spacer()
                        .frame(height: 10)
                    Image(tinyPing.avatar)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 130)
                }
                .frame(width: 180, height: 180)
                .background(.tinyWhite)
                .cornerRadius(20)
                .contentShape(Rectangle())
                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 1)
                HeartButton(tinyPing: $tinyPing, tinyPings: $tinyPings)
            }
        }
        .environment(pathModel)
    }
}

// MARK: - HeartButton
private struct HeartButton: View {
    // TODO: 임시 코드
    @Binding var tinyPing: TinyPing
    @Binding private(set) var tinyPings: [TinyPing]
//    @ObservedObject var tinyPingManager = TinyPingManager()
    var body: some View {
        Button {
            withAnimation {
                if let index = tinyPings.firstIndex(where: { $0.id == tinyPing.id }) {
                    tinyPings[index].isLiked.toggle()  // 좋아요 상태 변경
                    TinyPingManager().saveTinyPings(tinyPings)  // 상태 저장
                    
                    // 리스트를 다시 정렬하여 좋아요가 상단으로 이동되도록 처리
                    tinyPings.sort { $0.isLiked && !$1.isLiked }
                }
            }
        } label: {
            Image(tinyPing.isLiked ? .imgHeartfill: .imgHeartempty)
                .resizable()
                .scaledToFit()
                .frame(width: 36)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
        }
        .offset(x: 60 ,y: 60)
    }
}

// MARK: - Preview
#Preview {
    WikiView(searchKeyword: .constant(""), selectedTinyping: .constant(MockDataBuilder.tinyPing))
        .environment(PathModel())
}
