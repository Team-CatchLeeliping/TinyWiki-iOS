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
            Text("곧 업데이트 됩니다!")
                .font(.Head.head1)
                .foregroundStyle(.tinyPink)
            Spacer()
            
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))

    }
}

#Preview {
    QuizView()
}
