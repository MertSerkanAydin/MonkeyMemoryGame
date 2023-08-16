//
//  LevelNumberModel.swift
//  MonkeyMemoryGame
//
//  Created by Mert Serkan Aydın on 16.08.2023.
//

import Foundation

class LevelNumberModel {
    
    func getNumbers() -> [LevelNumber] {
        
        //        oluşturulan kartları depolayan array
        var generatedNumbersArray = [LevelNumber]()
        
        for i in 1...28 {
            
            //            create the first card object
            let level = LevelNumber()
            level.imageName = "1.\(i)"
            
            generatedNumbersArray.append(level)
                        
        }
        
        //        return the array
        return generatedNumbersArray
        
    }
}
