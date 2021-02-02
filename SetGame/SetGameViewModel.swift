//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Julea Parkhomava on 1/23/21.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published private var model = Model(numberOfCards: 81){
        index in
        (number: index % 3 == 0 ? 3 : ((index % 3 == 1) ? 2 : 1),
         fill: index % 9 < 3 ? Model.Card.fillElement.full : (index % 9 < 6 ? Model.Card.fillElement.stroke : Model.Card.fillElement.empty),
         color: index % 27 < 9 ? Model.Card.colorElement.red : (index % 27 < 18 ? Model.Card.colorElement.blue : Model.Card.colorElement.green),
         shape: index < 27 ? Model.Card.ShapeElement.rhombus : (index < 54 ? Model.Card.ShapeElement.snake : Model.Card.ShapeElement.oval))
    }
    
    //MARK: - Get Access
    var cards:Array<Model.Card>{
        model.openCards
    }
    
    var deck: Array<Model.Card>{
        model.allCards
    }
    
    //MARK: - Intents
    func choose(card: Model.Card) {
        model.choose(card: card)
    }
    
    func help(){
        model.help()
    }
    
    func newGame(){
        model = Model(numberOfCards: 81){
            index in
            (number: index % 3 == 0 ? 3 : ((index % 3 == 1) ? 2 : 1),
             fill: index % 9 < 3 ? Model.Card.fillElement.full : (index % 9 < 6 ? Model.Card.fillElement.stroke : Model.Card.fillElement.empty),
             color: index % 27 < 9 ? Model.Card.colorElement.red : (index % 27 < 18 ? Model.Card.colorElement.blue : Model.Card.colorElement.green),
             shape: index < 27 ? Model.Card.ShapeElement.rhombus : (index < 54 ? Model.Card.ShapeElement.snake : Model.Card.ShapeElement.oval))
        }
    }
}
