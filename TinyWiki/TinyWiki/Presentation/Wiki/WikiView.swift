import SwiftUI

struct WikiView: View {
    @Binding var searchKeyword: String
    @Binding var selectedTinyping: TinyPing
    @StateObject private var tinyPingManager = TinyPingManager()
    @State private var scrollOffset: CGFloat = 0  // 스크롤 오프셋을 저장할 상태 변수
    @State private var isScroll: Bool = false
    @State private var filteredTinyPings: [TinyPing] = []  // 필터링된 상태를 관리하는 @State
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: ScrollOffsetKey.self, value: geometry.frame(in: .global).minY)
                }
                .frame(height: 0) // 오프셋 감지용 프레임
                VStack(spacing: 0) {
                    TinypingList(
                        selectedTinyPing: $selectedTinyping,
                        filteredTinyPings: $filteredTinyPings,
                        tinyPings: $tinyPingManager.tinyPings,
                        onHeartToggle: filterTinyPings  // 좋아요 상태가 변경되면 필터링 함수 호출
                    )
                }
            }
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                UIApplication.shared.endEditing()
                scrollOffset = value  // 스크롤 오프셋을 상태 변수에 저장
            }
            .onAppear {
                filterTinyPings()  // 초기 로딩 시 필터링
            }
            .onChange(of: searchKeyword) { _ in
                filterTinyPings()  // 검색어가 변경될 때마다 필터링
            }
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
    
    private func filterTinyPings() {
        print(filteredTinyPings)
        filteredTinyPings = tinyPingManager.tinyPings.filter { searchKeyword.isEmpty || $0.name.contains(searchKeyword) }
            .sorted { $0.isLiked && !$1.isLiked }
        
        print(filteredTinyPings)
    }
}

// MARK: - 티니핑 리스트
private struct TinypingList: View {
    @Binding var selectedTinyPing: TinyPing
    @Binding var filteredTinyPings: [TinyPing]
    @Binding private(set) var tinyPings: [TinyPing]
    let onHeartToggle: () -> Void  // 좋아요 상태 변경 후 필터링하는 클로저
    
    private let columns: [GridItem] = Array(repeating: .init(.fixed(180), spacing: nil), count: 2)
    
    var body: some View {
        LazyVGrid(columns: columns , spacing: 8) {
            ForEach(filteredTinyPings, id: \.id) { tinyPing in
                if let index = tinyPings.firstIndex(where: { $0.id == tinyPing.id }) {
                    TinypingCell(
                        selectedTinyPing: $selectedTinyPing,
                        tinyPings: $tinyPings,
                        tinyPing: $tinyPings[index],  // 실제 원본 배열의 요소를 바인딩해서 전달
                        onHeartToggle: onHeartToggle
                    )
                    .transition(.move(edge: .top))  // 애니메이션 적용
                }
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
    let onHeartToggle: () -> Void  // 좋아요 상태 변경 후 필터링하는 클로저
    
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
                HeartButton(tinyPing: $tinyPing, tinyPings: $tinyPings, onHeartToggle: onHeartToggle)
            }
        }
        .environment(pathModel)
    }
}

// MARK: - HeartButton
private struct HeartButton: View {
    @Binding var tinyPing: TinyPing
    @Binding private(set) var tinyPings: [TinyPing]
    let onHeartToggle: () -> Void  // 좋아요 상태 변경 후 필터링하는 클로저
    
    var body: some View {
        Button {
            withAnimation {
                if let index = tinyPings.firstIndex(where: { $0.id == tinyPing.id }) {
                    tinyPings[index].isLiked.toggle()  // 좋아요 상태 변경
                    TinyPingManager().saveTinyPings(tinyPings)  // 상태 저장
                    onHeartToggle()  // 좋아요 변경 후 필터링 호출
                }
            }
        } label: {
            Image(tinyPing.isLiked ? .imgHeartfill : .imgHeartempty)
                .resizable()
                .scaledToFit()
                .frame(width: 36)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
        }
        .offset(x: 60, y: 60)
    }
}

// MARK: - Preview
#Preview {
    WikiView(searchKeyword: .constant(""), selectedTinyping: .constant(MockDataBuilder.tinyPing))
        .environment(PathModel())
}
