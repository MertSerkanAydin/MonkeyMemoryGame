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
    var cellArray = [NumbersOfGameCollectionViewCell]()
    var timer: Timer?
    var milliseconds: Float = 3 * 1000 // 13 Seconds
    
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
        
        //        Get an NumbersOfGameCollectionViewCell object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumberCell", for: indexPath) as! NumbersOfGameCollectionViewCell
        
        //        Get the number that the collection view is trying to display
        let number = numberArray[indexPath.row]
        
        //        set that number for the cell
        cell.setNumber(number)
        
        //        Added the created cells inside the CellArray
        cellArray.append(cell)
        
        cell.flip()
        
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
                    number.isCorrect = true
                    
                    //                    Game Win Check
                    if imageNameToINT == numberArray.count {
                        showAlert("cong", "won")
                    }
                    
                } else {
                    showAlert("GG", "Game Over")
                }
                
            }
            
        }
        
    }
    
    //    MARK - Timer Methods
    @objc func timerElapsed() {
        
        for i in numberArray {
            
            if milliseconds > 0 && i.isFlipped == false {
                
                i.isFlipped = true
                
            }
        }
        
        //        When the timer has reached 0
        for i in numberArray {
            
            if milliseconds <= 0 && i.isFlipped == true {
                
                for item in cellArray {
                    
                    item.flipBack()
                    i.isFlipped = false
                    
                }
                
                timer?.invalidate()
                timerLabel.isHidden = true
                
            }
        }
        
        milliseconds -= 1
        
        //        Convert to seconds
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        //        Set label
        timerLabel.text = "Time Remaining: \(seconds)"
        
    }
    
    //    Create Alert Func
    func showAlert(_ title: String, _ message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default)
        let alertAction2 = UIAlertAction(title: "Play Again", style: .default) { playAgain in
            
            self.playAgain()
            
        }
        alert.addAction(alertAction)
        alert.addAction(alertAction2)
        
        present(alert, animated: true)
        
    }
    
    func playAgain() {
        
        lastPickingNumber = 0
        numberArray = [Number]()
        cellArray = [NumbersOfGameCollectionViewCell]()
        numberArray = model.getNumbers()
        milliseconds = 3 * 1000
        timerLabel.isHidden = false
        collectionView.reloadData()
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        
    }
    
}
