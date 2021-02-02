//
//  fillModifier.swift
//  SetGame
//
//  Created by Julea Parkhomava on 1/26/21.
//

import SwiftUI

struct differentFill: ViewModifier{
    enum fillElement: CaseIterable {
        case empty
        case stroke
        case full
    }
    
    private var fillType: fillElement
    private var borderWidth: CGFloat
    private var contentSize: CGSize
    private var colorOfElement: Color
    private var squareLength: CGFloat
    
    init(fillType: fillElement, borderWidth: CGFloat?, contentSize: CGSize, colorOfElement: Color) {
        self.fillType = fillType
        self.contentSize = contentSize
        self.borderWidth = borderWidth ?? (min(contentSize.width, contentSize.height) / 6)
        self.colorOfElement = colorOfElement
        squareLength = min(contentSize.width, contentSize.height)
    }
    
    func body(content: Content) -> some View{
        ZStack{
            switch fillType{
            case .full:
                content
                    .foregroundColor(colorOfElement)
            case .empty:
                content.foregroundColor(colorOfElement)
                content
                    .padding(borderWidth)
                    .foregroundColor(.white)
            case .stroke:
                content.foregroundColor(colorOfElement)
                content
                    .padding(borderWidth)
                    .foregroundColor(.white)
                content
                    .padding(borderWidth)
                    .foregroundColor(colorOfElement.opacity(0.4))
            }
        }
    }
    
}
