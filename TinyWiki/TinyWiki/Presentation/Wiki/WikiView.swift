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
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 12)
            ScrollView {
                VStack(spacing: 0) {
                    TinypingList(selectedTinyPing: $selectedTinyping, searchKeyword: $searchKeyword)
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))

    }
}



// MARK: - 티니핑 리스트
private struct TinypingList: View {
    @Binding var selectedTinyPing: TinyPing
    @Binding var searchKeyword: String
    // filteredTinypings 들어오면서 필요 없어짐.
    let tinyPings: [TinyPing] = MockDataBuilder.tinyPings
    
    var filteredTinyPings: [TinyPing] {
        if searchKeyword.isEmpty {
            return tinyPings
        } else {
            return tinyPings.filter { $0.name.contains(searchKeyword) }
        }
    }
    private let columns: [GridItem] = Array(repeating: .init(.fixed(180), spacing: nil), count: 2)
    var body: some View {
        LazyVGrid(columns: columns , spacing: 8) {
            ForEach(filteredTinyPings) { tinyPing in
                TinypingCell(selectedTinyPing: $selectedTinyPing, tinyPing: tinyPing)
            }
        }
    }
}

// MARK: - 티니핑 리스트 셀
private struct TinypingCell: View {
    @Environment(PathModel.self) private var pathModel
    @Binding private(set) var selectedTinyPing: TinyPing
    let tinyPing: TinyPing
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
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
                HeartButton(tinyPing: tinyPing)
            }
        }
        .environment(pathModel)
    }
}

// MARK: - HeartButton
private struct HeartButton: View {
    // TODO: 임시 코드
    var tinyPing: TinyPing
    @State private var isLiked: Bool = false
    var body: some View {
        Button {
            isLiked.toggle()
            print(tinyPing.isLiked)
            // TODO: UserDefault에 좋아요 한 티니핑 저장해두기
        } label: {
            Image(isLiked ? .imgHeartfill: .imgHeartempty)
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
