//
//  GameSceneViewController.swift
//  MonkeyMemoryGame
//
//  Created by Mert Serkan Aydın on 9.08.2023.
//

import UIKit

class GameSceneViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var model = NumberModel()
    var numberArray = [Number]()
    var lastPickingNumber = 0
    var itemCell: NumbersOfGameCollectionViewCell?
    
    var timer: Timer?
    var milliseconds: Float = 13 * 1000 // 13 Seconds
    
    var firstFlippedNumberIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        numberArray = model.getNumbers()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //        Create Timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        numberArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        //        Get an CardCollectionViewCell object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumberCell", for: indexPath) as! NumbersOfGameCollectionViewCell

        //        Get the card that the collection view is trying to display
        let number = numberArray[indexPath.row]
        
        //        set that card for the cell
        cell.setNumber(number)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        Get the cell that the user selected
        let cell = collectionView.cellForItem(at: indexPath) as! NumbersOfGameCollectionViewCell
        
        
        //        Get the number that the user selected
        let number = numberArray[indexPath.row]
    
        if number.isFlipped == false {
            
            //        Flip the number
            cell.flip()
            
            //            Set the status of the number
            number.isFlipped = true
            
            //        Game Logic
            if let imageNameToINT = Int(number.imageName) {
                
                if imageNameToINT - lastPickingNumber == 1 {
                    
                    lastPickingNumber = imageNameToINT
                    print("serksn")
                    
                } else {
                    showAlert("GG", "Game Over")
                }
                
            }
            
        }
        
    }
    
    //    MARK - Timer Methods
    @objc func timerElapsed() {
        
        for _ in numberArray {
            
            if milliseconds > 0 {
                

            }
            
            //        When the timer has reached 0
            if milliseconds <= 0 {
                timer?.invalidate()
                timerLabel.isOpaque = true
            }
        }
        
        milliseconds -= 1
        
        //        Convert to seconds
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        //        Set label
        timerLabel.text = "Time Remaining: \(seconds)"
        
    }
    
    func checkGameEnded() {
        
        var isWon = true
        
        for item in numberArray {
            if item.isCorrect == false {
                isWon = false
                break
            }
        }
        
        //        Messaging variables
        var title = ""
        var message = ""
        
        //        If all items correct  user has won, stop the timer
        if isWon == true {
            
            title = "Cong"
            message = "You've Won"
            
        }
        
        //        Show won/lost messaging
        showAlert(title, message)
        
    }
    
//    Create Alert Func
    func showAlert(_ title: String, _ message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(alertAction)
        present(alert, animated: true)
        
    }
    
    
    
}


