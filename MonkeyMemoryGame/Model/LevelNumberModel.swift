//
//  LevelNumberModel.swift
//  MonkeyMemoryGame
//
//  Created by Mert Serkan Aydın on 16.08.2023.
//

import Foundation

class LevelNumberModel {
    
    func getNumbers() -> [LevelNumber] {
        
        //        Array that stores the generated numbers
        var generatedNumbersArray = [LevelNumber]()
        
        for i in 0...27 {
            
            let level = LevelNumber()
            
            if LevelsVC.levelCompletionStatusArray[i] == true || LevelsVC.levelCompletionStatusArray[i - 1] == true {
                //            Create Level numbers
                level.imageName = "1.\(i)"
                generatedNumbersArray.append(level)
            } else {
                //            Create Level numbers
                level.imageName = "1.\(i)Lock"
                generatedNumbersArray.append(level)
            }
            
            
        }
        
        //        return the array
        return generatedNumbersArray
        
    }
}
