//
//  NavigationBarAppearanceModifier.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/21/24.
//

import SwiftUI

struct NavigationBarAppearanceModifier: UIViewControllerRepresentable {
    var scrollOffset: CGFloat
    var navigationTitleColor: UIColor

    // makeUIViewController는 SwiftUI에서 UIKit의 뷰 컨트롤러를 생성하는 역할을 합니다.
    func makeUIViewController(context: Context) -> UIViewController {
        // 빈 UIViewController를 반환합니다. SwiftUI에서 네비게이션 바를 제어하기 위한 더미 뷰 컨트롤러입니다.
        return UIViewController()
    }

    // updateUIViewController는 뷰가 업데이트될 때 호출되며, 여기서 네비게이션 바 외관을 업데이트합니다.
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        updateNavigationBarAppearance(scrollOffset: scrollOffset, navigationTitleColor: navigationTitleColor, uiViewController: uiViewController)
    }

    // 네비게이션 바 외관을 업데이트하는 함수입니다.
    private func updateNavigationBarAppearance(scrollOffset: CGFloat, navigationTitleColor: UIColor, uiViewController: UIViewController) {
        let maxAlpha: CGFloat = 0.5
        let alpha =  (-1) * max(0, maxAlpha) * scrollOffset * 3 / 1000
        let userInterfaceStyle = uiViewController.traitCollection.userInterfaceStyle  // 라이트모드/다크모드 감지
        
        // 다크모드와 라이트모드에 따른 텍스트 및 배경 색상 설정
        let foregroundColor: UIColor = (userInterfaceStyle == .light) ? .white : .black

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            .font: UIFont.Head.head1,  // UIFont 사용
            .foregroundColor: foregroundColor  // 다크 모드에 따라 색상 설정
        ]
        appearance.backgroundColor = navigationTitleColor.withAlphaComponent(alpha)
        appearance.shadowColor = nil

        // 네비게이션 바에 외관을 적용합니다.
        if let navigationController = uiViewController.navigationController {
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = appearance
        }
    }
}

