//
//  Oval.swift
//  SetGame
//
//  Created by Julea Parkhomava on 1/24/21.
//

import SwiftUI

struct Oval: Shape{
    var radiusOfCircle: CGFloat?
    
    func path(in rect: CGRect) -> Path {
        var oval = Path()
        let side = (rect.width > rect.height) ? rect.height : rect.width
        var checkedRadius = radiusOfCircle ?? side / 3
        var lengthOfLine = side - 2 * checkedRadius
        if(checkedRadius*2 > side) || (lengthOfLine < (checkedRadius/5)){
            checkedRadius = side / 3
            lengthOfLine = side - 2 * checkedRadius
        }
        let center = CGPoint(x: rect.midX, y: rect.midY)
        oval.move(to: CGPoint(x:  center.x + lengthOfLine/2, y: center.y - checkedRadius))
        oval.addArc(center: CGPoint(x: center.x + lengthOfLine/2, y: center.y), radius: checkedRadius, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 90), clockwise: false)
        oval.addLine(to: CGPoint(x: center.x - lengthOfLine/2 , y: center.y + checkedRadius))
        oval.addArc(center: CGPoint(x: center.x - lengthOfLine/2, y: center.y), radius: checkedRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 270), clockwise: false)
        return oval
    }
}
