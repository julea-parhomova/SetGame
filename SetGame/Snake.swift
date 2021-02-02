//
//  Snake.swift
//  SetGame
//
//  Created by Julea Parkhomava on 1/25/21.
//

import SwiftUI

struct Snake: Shape {
    
    func path(in rect: CGRect) -> Path {
        var snake = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let side: CGFloat = (rect.width > rect.height) ? rect.height : rect.width
        snake.move(to: CGPoint(x: center.x + side/2, y: center.y - side/2))
        snake.addQuadCurve(to: CGPoint(x: center.x, y: center.y+side/4), control: CGPoint(x: center.x + 3*side/8, y: center.y + side/2))
        snake.addQuadCurve(to: CGPoint(x: center.x - side/2, y: center.y + side/2), control: CGPoint(x: center.x - 3*side/8, y: center.y - 3*side/8))
        snake.addQuadCurve(to: CGPoint(x: center.x, y: center.y - side/4), control: CGPoint(x: center.x - 3*side/8, y: center.y - side/2))
        snake.addQuadCurve(to: CGPoint(x: center.x + side/2, y: center.y-side/2), control: CGPoint(x: center.x + 3*side/8, y: center.y+3*side/8))
        return snake
    }
}
