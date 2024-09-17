//
//  HomeView.swift
//  TinyDex
//
//  Created by kyungsoolee on 9/18/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Tab = .menu
    var body: some View {
        ZStack(alignment: .bottom) {
            switch selectedTab {
            case .menu: MenuView()
            case .heart: HeartView()
            }
            TabBar(selection: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
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
}

#Preview {
    TabBar(selection: .constant(Tab.menu))
}
