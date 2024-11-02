//
//  FeedTemplate.swift
//  TinyWiki
//
//  Created by kyungsoolee on 10/10/24.
//

import Foundation

let title = "티니위키의 티니퀴즈!"
let description = "시간 안에 누가 가장 많은 티니핑을 맞출 수 있을까? 츄~"
let image_url = "https://private-user-images.githubusercontent.com/21362256/382459476-a8311444-6ab0-498d-99cb-20e2acbbf323.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzA1MzcyMjUsIm5iZiI6MTczMDUzNjkyNSwicGF0aCI6Ii8yMTM2MjI1Ni8zODI0NTk0NzYtYTgzMTE0NDQtNmFiMC00OThkLTk5Y2ItMjBlMmFjYmJmMzIzLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDExMDIlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQxMTAyVDA4NDIwNVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWYwYmYwM2I0N2I1MzVmZDEyNTU4ZDU4OGZiNzQxYTYyZTUyYjBjNThmOWFjNmU0ODY0NGM0MjNjNGM1NjdiMjImWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.OHD-lrWEvzvSObOXBobwt-WJ9wfdq7vxiovg98xRZ08"
let mobile_web_url = "https://apps.apple.com/kr/app/%ED%8B%B0%EB%8B%88%EC%9C%84%ED%82%A4/id6705134139?l=en-GB"
let web_url = "https://apps.apple.com/kr/app/%ED%8B%B0%EB%8B%88%EC%9C%84%ED%82%A4/id6705134139?l=en-GB"

// TODO: 앱으로 보기 -> 딥링크 공부해보기
let feedTemplateJsonStringData =
    """
    {
        "object_type": "feed",
        "content": {
            "title": "\(title)",
            "description": "\(description)",
            "image_url": "\(image_url)",
            "link": {
                "mobile_web_url": "\(mobile_web_url)",
                "web_url": "\(web_url)"
            }
        },
        "buttons": [
            {
                "title": "앱으로 보기",
                "link": {
                    "mobile_web_url": "\(mobile_web_url)",
                    "web_url": "\(web_url)"
                }
            }
        ]
    }
    """.data(using: .utf8)!
