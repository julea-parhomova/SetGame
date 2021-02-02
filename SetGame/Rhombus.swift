//
//  Rhombus.swift
//  SetGame
//
//  Created by Julea Parkhomava on 1/24/21.
//

import SwiftUI

struct Rhombus: Shape {
    var aspectWidthHeight: CGFloat?
    
    func path(in rect: CGRect) -> Path {
        var rhombus = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let side = (rect.width > rect.height) ? rect.height : rect.width
        let width, height: CGFloat
        if let aspect = aspectWidthHeight{
            if aspect < 1 {
                height = side
                width = height * aspect
            }else{
                width = side
                height = width/aspect
            }
        }else{
            width = side
            height = side*3/5
        }
        rhombus.move(to: CGPoint(x: center.x, y: center.y - height/2))
        rhombus.addLine(to: CGPoint(x: center.x + width/2, y: center.y))
        rhombus.addLine(to: CGPoint(x: center.x, y: center.y + height/2))
        rhombus.addLine(to: CGPoint(x: center.x - width/2, y: center.y))
        return rhombus
    }
}
