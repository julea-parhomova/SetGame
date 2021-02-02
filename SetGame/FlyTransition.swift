//
//  FlyTransition.swift
//  SetGame
//
//  Created by Julea Parkhomava on 1/28/21.
//

import SwiftUI

extension AnyTransition{
    static var flyCards: AnyTransition{
        .offset(randomPosition())
    }
    
    static private func randomPosition() -> CGSize{
        var x, y: CGFloat
        y = CGFloat.random(in: -UIScreen.main.bounds.height...UIScreen.main.bounds.height)
       switch y {
        case -UIScreen.main.bounds.height, UIScreen.main.bounds.height:
            x = CGFloat.random(in: -UIScreen.main.bounds.width...UIScreen.main.bounds.width)
        default:
            x = (Int.random(in: 1...2) == 1) ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width
        }
        return CGSize(width: x, height: y)
    }
}
