//
//  SetGameModel.swift
//  SetGame
//
//  Created by Julea Parkhomava on 1/23/21.
//

import Foundation

struct Model {
    private(set) var allCards: Array<Card>
    private(set) var openCards: Array<Card>
    
    private var choosenCardsIndexes = Array<Int>(){
        didSet{
            if choosenCardsIndexes.count == 4 {
                let changeElementsIndexes = choosenCardsIndexes.dropLast().sorted()
                if checkSet() {
                    if changeElementsIndexes.contains(choosenCardsIndexes.last!){
                        choosenCardsIndexes.removeLast()
                    }
                    for index in 0..<3 {
                        openCards[changeElementsIndexes[index]].isMatched = true
                        if(allCards.count > 0){
                            openCards[changeElementsIndexes[index]] = allCards.removeFirst()
                        }else{
                            openCards.remove(at: changeElementsIndexes[index])
                        }
                    }
                }
                choosenCardsIndexes.removeFirst(3)
            }
            for index in openCards.indices{
                openCards[index].isSelect = choosenCardsIndexes.contains(index)
            }
        }
    }
    
    
    init(numberOfCards: Int, contentOfCard: (Int) -> (number: Int, fill: Card.fillElement, color: Card.colorElement, shape: Card.ShapeElement)) {
        var cards = Array<Card>()
        var id = 0
        for index in 0..<numberOfCards {
            let content = contentOfCard(index)
            cards.append(Model.Card(numberOfElements: content.number, colorOfElements: content.color, shapeOfElements: content.shape, fillOfElements: content.fill, id: id))
            id += 1
        }
        cards.shuffle()
        openCards = Array(cards.prefix(12))
        cards.removeFirst(12)
        allCards = cards
        
    }
    
    func checkSet(arrayOfIndexes: [Int]? = nil)->Bool{
        let checkedArray = arrayOfIndexes ?? choosenCardsIndexes
        guard (openCards[checkedArray[0]].colorOfElements == openCards[checkedArray[1]].colorOfElements && openCards[checkedArray[1]].colorOfElements == openCards[checkedArray[2]].colorOfElements) ||
                (openCards[checkedArray[0]].colorOfElements != openCards[checkedArray[1]].colorOfElements && openCards[checkedArray[1]].colorOfElements != openCards[checkedArray[2]].colorOfElements
                    && openCards[checkedArray[0]].colorOfElements != openCards[checkedArray[2]].colorOfElements) else{
            return false
        }
        guard (openCards[checkedArray[0]].shapeOfElements == openCards[checkedArray[1]].shapeOfElements && openCards[checkedArray[1]].shapeOfElements == openCards[checkedArray[2]].shapeOfElements) ||
                (openCards[checkedArray[0]].shapeOfElements != openCards[checkedArray[1]].shapeOfElements && openCards[checkedArray[1]].shapeOfElements != openCards[checkedArray[2]].shapeOfElements
                    && openCards[checkedArray[0]].shapeOfElements != openCards[checkedArray[2]].shapeOfElements) else{
            return false
        }
        guard (openCards[checkedArray[0]].fillOfElements == openCards[checkedArray[1]].fillOfElements && openCards[checkedArray[1]].fillOfElements == openCards[checkedArray[2]].fillOfElements) ||
                (openCards[checkedArray[0]].fillOfElements != openCards[checkedArray[1]].fillOfElements && openCards[checkedArray[1]].fillOfElements != openCards[checkedArray[2]].fillOfElements
                    && openCards[checkedArray[0]].fillOfElements != openCards[checkedArray[2]].fillOfElements) else{
            return false
        }
        guard (openCards[checkedArray[0]].numberOfElements == openCards[checkedArray[1]].numberOfElements && openCards[checkedArray[1]].numberOfElements == openCards[checkedArray[2]].numberOfElements) ||
                (openCards[checkedArray[0]].numberOfElements != openCards[checkedArray[1]].numberOfElements && openCards[checkedArray[1]].numberOfElements != openCards[checkedArray[2]].numberOfElements
                    && openCards[checkedArray[0]].numberOfElements != openCards[checkedArray[2]].numberOfElements) else{
            return false
        }
        return true
    }
    
    mutating func choose(card: Card) {
        if !card.isMatched {
            if let indexChoosenCard = openCards.firstIndexOfElement(item: card){
                if !card.isSelect{
                    choosenCardsIndexes.append(indexChoosenCard)
                }else{
                    if choosenCardsIndexes.count < 3 {
                        openCards[indexChoosenCard].isSelect = false
                        choosenCardsIndexes.removeAll(where: {$0 == indexChoosenCard})
                    }else{
                        choosenCardsIndexes.append(indexChoosenCard)
                    }
                }
            }
        }
    }
    
    mutating func help(){
        var possibleSet = Array<Int>()
        for indexFirst in 0..<(openCards.count - 2){
            if !openCards[indexFirst].isMatched {
                possibleSet.append(indexFirst)
                for indexSecond in (indexFirst+1)..<(openCards.count-1) {
                    if !openCards[indexSecond].isMatched {
                        possibleSet.append(indexSecond)
                        for indexThird in (indexSecond+1)..<openCards.count {
                            if !openCards[indexThird].isMatched {
                                possibleSet.append(indexThird)
                                if(possibleSet.count == 3){
                                    if checkSet(arrayOfIndexes: possibleSet) {
                                        for index in choosenCardsIndexes{
                                            openCards[index].isSelect = false
                                        }
                                        choosenCardsIndexes.removeAll()
                                        for index in possibleSet {
                                            choosenCardsIndexes.append(index)
                                        }
                                        return
                                    }
                                }
                                possibleSet.removeLast()
                            }
                        }
                        possibleSet.removeLast()
                    }
                }
                possibleSet.removeLast()
            }
        }
    }
    
    struct Card: Equatable, Identifiable {
        var numberOfElements: Int
        var colorOfElements: colorElement
        var shapeOfElements: ShapeElement
        var fillOfElements: fillElement
        
        var isSelect: Bool = false
        var isMatched: Bool = false
        
        var id: Int
        
        enum ShapeElement: CaseIterable {
            case rhombus
            case oval
            case snake
        }
        
        enum fillElement: CaseIterable {
            case empty
            case stroke
            case full
        }
        
        enum colorElement: CaseIterable {
            case blue
            case red
            case green
        }
    }
}
