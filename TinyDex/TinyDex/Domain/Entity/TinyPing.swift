//
//  TinyPing.swift
//  TinyDex
//
//  Created by kyungsoolee on 9/18/24.
//

import Foundation

struct TinyPing: Identifiable {
    var id: UUID
    var name: String
    var avatar: String
    var sex: Sex
    var nameDescription: String
    var item: String
    var symbol: String
    var partner: String
    var transformation: String
    var magic: String
    var favoriteThing: String
    var dislikeThing: String
    var favoriteFood: String
    var dislikeFood: String
    var backgroundColor: BackgroundColor
    
    init(
        name: String,
        avatar: String,
        sex: Sex,
        nameDescription: String,
        item: String,
        symbol: String,
        partner: String,
        transformation: String, 
        magic: String,
        favoriteThing: String,
        dislikeThing: String,
        favoriteFood: String,
        dislikeFood: String,
        backgroundColor: BackgroundColor
    ) {
        self.id = UUID()
        self.name = name
        self.avatar = avatar
        self.sex = sex
        self.nameDescription = nameDescription
        self.item = item
        self.symbol = symbol
        self.partner = partner
        self.transformation = transformation
        self.magic = magic
        self.favoriteThing = favoriteThing
        self.dislikeThing = dislikeThing
        self.favoriteFood = favoriteFood
        self.dislikeFood = dislikeFood
        self.backgroundColor = backgroundColor
    }
}
