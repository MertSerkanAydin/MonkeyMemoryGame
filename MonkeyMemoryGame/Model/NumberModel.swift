//
//  NumberModel.swift
//  MonkeyMemoryGame
//
//  Created by Mert Serkan Aydın on 9.08.2023.
//

import Foundation

class NumberModel {
    
    static var howManyCard = 8
    
    func getNumbers() -> [Number] {
        
        //         Declare an array to store numbers we've already generated
        var generatedRandomNumbersArray = [Int]()
        
        //        oluşturulan kartları depolayan array
        var generatedNumbersArray = [Number]()
        
        while generatedNumbersArray.count < NumberModel.howManyCard {
            
            //            get a random number
            let randomNumber = arc4random_uniform(UInt32(NumberModel.howManyCard)) + 1
            /*
             arc4random_uniform(x) returns a random value between 0 and x-1
             
             Examples:
             
             arc4random_uniform(2) -> returns 0 or 1 randomly
             arc4random_uniform(2) == 0 returns true or false randomly
             arc4random_uniform(6) + 1 returns a number between 1 and 6 (like a dice roll)
             */
            
            //            Ensure that the random number isn't one we already have
            if generatedRandomNumbersArray.contains(Int(randomNumber)) == false {
                print(randomNumber)
                //                Store the number into the generatedNumbersArray
                generatedRandomNumbersArray.append(Int(randomNumber))
                
                //            create the first card object
                let NumberOne = Number()
                NumberOne.imageName = "\(randomNumber)"
                
                generatedNumbersArray.append(NumberOne)
                
            }
            
        }
        
        //        return the array
        return generatedNumbersArray
        
    }
}
