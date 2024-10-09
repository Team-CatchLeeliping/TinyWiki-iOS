//
//  FeedTemplate.swift
//  TinyWiki
//
//  Created by kyungsoolee on 10/10/24.
//

import Foundation

let title = "피드 메시지"
let description = "피드 메시지 예제"

let feedTemplateJsonStringData =
    """
    {
        "object_type": "feed",
        "content": {
            "title": "오늘의 디저트",
            "description": "#케익 #딸기 #삼평동 #카페 #분위기 #소개팅",
            "image_url": "https://mud-kage.kakao.com/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png",
            "link": {
                "mobile_web_url": "https://developers.kakao.com",
                "web_url": "https://developers.kakao.com"
            }
        },
        "item_content" : {
            "profile_text" :"Kakao",
            "profile_image_url" :"https://mud-kage.kakao.com/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png",
            "title_image_url" : "https://mud-kage.kakao.com/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png",
            "title_image_text" :"Cheese cake",
            "title_image_category" : "Cake",
            "items" : [
                {
                    "item" :"Cake1",
                    "item_op" : "1000원"
                },
                {
                    "item" :"Cake2",
                    "item_op" : "2000원"
                },
                {
                    "item" :"Cake3",
                    "item_op" : "3000원"
                },
                {
                    "item" :"Cake4",
                    "item_op" : "4000원"
                },
                {
                    "item" :"Cake5",
                    "item_op" : "5000원"
                }
            ],
            "sum" :"Total",
            "sum_op" : "15000원"
        },
        "social": {
            "comment_count": 45,
            "like_count": 286,
            "shared_count": 845
        },
        "buttons": [
            {
                "title": "웹으로 보기",
                "link": {
                    "mobile_web_url": "https://developers.kakao.com",
                    "web_url": "https://developers.kakao.com"
                }
            },
            {
                "title": "앱으로 보기",
                "link": {
                    "android_execution_params": "key1=value1&key2=value2",
                    "ios_execution_params": "key1=value1&key2=value2"
                }
            }
        ]
    }
    """.data(using: .utf8)!
