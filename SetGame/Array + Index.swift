//
//  Array + Index.swift
//  SetGame
//
//  Created by Julea Parkhomava on 1/24/21.
//

import Foundation

extension Array where Element: Equatable{
    func firstIndexOfElement(item: Element) -> Int? {
        for index in self.indices {
            if(self[index] == item){
                return index
            }
        }
        return nil
    }
}

