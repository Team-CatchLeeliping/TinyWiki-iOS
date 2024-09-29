//
//  QuizView.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/18/24.
//

import SwiftUI

struct QuizView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                // TODO: 아마 이미지 크기가 안맞아서 왼쪽이 잘리는거같음 그래서 임시로 Spacer()로 늘리기
                Spacer()
            }
            Spacer()
            QuizText()
            Spacer()
                .frame(height: 44)
            QuizList()
            Spacer()
            
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))

    }
}

private struct QuizText: View {
    var body: some View {
        Text("30초 안에\n티니핑을\n몇 마리 맞출 수 있을까요?")
            .font(.Head.head3)
            .foregroundStyle(.tinyWhite)
            .multilineTextAlignment(.center)
            .customStroke(strokeSize: 4, strokeColor: .tinyPink)
    }
}

// MARK: - 퀴즈 선택 리스트
private struct QuizList: View {
    var body: some View {
        VStack {
            ForEach(QuizKind.allCases) { quizKind in
                QuizCell(quizKind: quizKind)
            }
        }
    }
}

// MARK: - 퀴즈 셀
private struct QuizCell: View {
    @Environment(PathModel.self) private var pathModel
    var quizKind: QuizKind
    var body: some View {
        Button {
            switch quizKind {
                case .name:
                pathModel.paths.append(.nameQuizView)
            case .image:
                pathModel.paths.append(.imageQuizView)
            }
        } label: {
            HStack {
                Image(.imgHeartyouping)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64)
                Text("\(quizKind.title)을 보고 나를 맞춰줘 츄~")
                    .font(.Body.body1)
                    .foregroundStyle(.tinyPink)
            }
            .frame(width: 340, height: 96)
            .background(.tinyWhite)
            .cornerRadius(20)
            .contentShape(Rectangle())
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 1)
        }
        .environment(pathModel)
    }

}

// TODO: UI와 분리하기
enum QuizKind: Identifiable, CaseIterable {
    case name
    case image
    
    /// ID를 생성합니다.
    var id: UUID {
        return .init()
    }
    
    /// 탭바의 타이틀을 반환합니다.
    var title: String {
        switch self {
        case .name: return "이름"
        case .image: return "사진"
        }
    }
}

#Preview {
    QuizView()
        .environment(PathModel())
}
