//
//  StrokeText.swift
//  TinyWiki
//
//  Created by kyungsoolee on 9/27/24.
//

import SwiftUI

extension View {
    func customStroke(strokeSize: CGFloat, strokeColor: Color) -> some View {
        modifier(StrokeModifier(strokeSize: strokeSize, strokeColor: strokeColor))
    }
}


struct StrokeModifier: ViewModifier {
    private let id = UUID()
    var strokeSize: CGFloat = 1
    var strokeColor: Color = .black
    
    func body(content: Content) -> some View {
        content
            .padding(strokeSize * 2)
            .background(Rectangle()
                .foregroundStyle(strokeColor)
                .mask({
                    outline(content: content)
                }))
    }
    func outline(content: Content) -> some View {
        Canvas { content, size in
            content.addFilter(.alphaThreshold(min: 0.01))
            content.drawLayer{ layer in
                if let text = content.resolveSymbol(id: id) {
                    layer.draw(text, at: .init(x: size.width/2, y: size.height/2))
                }
            }
        } symbols: {
            content.tag(id)
                .blur(radius: strokeSize)
        }
    }
}
