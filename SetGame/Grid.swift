//
//  Grid.swift
//  SetGame
//
//  Created by Julea Parkhomava on 1/24/21.
//

import SwiftUI

struct Grid<Item, ItemView>: View where ItemView: View, Item: Identifiable & Equatable {
    private var items: [Item]
    private var itemForView: (Item) -> ItemView
    
    init(_ arrayOfItems: [Item], itemForView: @escaping (Item) -> ItemView) {
        items = arrayOfItems
        self.itemForView = itemForView
    }
    
    var body: some View{
        GeometryReader{geometry in
            let gridMath = MathmeticOfGrid(itemsCount: items.count, size: geometry.size)
            let (width, height) = (gridMath.sizeOfItem.width, gridMath.sizeOfItem.height)
            ForEach(0..<items.count, id: \.self){index in
                itemForView(items[index])
                    .position(gridMath.location(of: index))
                    .frame(width: width, height: height)
            }
        }
    }
}

struct MathmeticOfGrid{
    private var width: CGFloat
    private var height: CGFloat
    private var rowsNumber: Int = 0
    private var columnsNumber: Int = 0
    
    init(itemsCount: Int, size: CGSize) {
        width = size.width
        height = size.height
        guard itemsCount>0, width > 0, height > 0 else{
            return
        }
        var bestRowsandColumns: (Int, Int) = (1, itemsCount)
        let desiredAspectRatio: Double = 1
        let sizeAspectRatio = abs(Double(width/height))
        var smalestDifference: Double?
        for rows in 1...itemsCount {
            let columns = (itemsCount/rows) + ((itemsCount % rows > 0) ? 1 : 0)
            let aspectRatioDifference = abs(desiredAspectRatio - sizeAspectRatio*(Double(rows) / Double(columns)))
            if ((rows - 1)*columns) < itemsCount {
                if smalestDifference == nil || aspectRatioDifference < smalestDifference!{
                    bestRowsandColumns = (rows, columns)
                    smalestDifference = aspectRatioDifference
                }
            }
        }
        (rowsNumber, columnsNumber) = bestRowsandColumns
    }
    
    var sizeOfItem: CGSize {
        CGSize(width: width / CGFloat(columnsNumber),
               height: height / CGFloat(rowsNumber))
    }
    
    
    func location(of index: Int) -> CGPoint{
        CGPoint(x: (CGFloat(index % columnsNumber) + 0.5) * sizeOfItem.width,
                y: (CGFloat(index / columnsNumber) + 0.5) * sizeOfItem.height)
    }
}
