//
//  TinyWikiApp.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/17/24.
//

import SwiftUI
import KakaoSDKCommon

@main
struct TinyWiki: App {
    @State private var pathModel: PathModel = .init()
    @State private var showSplash = true  // 스플래시 화면을 보여줄지 여부를 관리하는 변수
    
    init() {
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        print("KakaoAppKey: \(kakaoAppKey)")
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
    }
    
    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView()
                    .onAppear {
                        // 1초 후에 스플래시 화면을 숨기고 HomeView로 전환
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                HomeView()  // 스플래시 화면이 사라진 후에 HomeView를 띄움
                    .environment(pathModel)
            }
        }
    }
}
