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
    var numberDisplayTimer: Timer?
    var darkModeTimer: Timer?
    var gameDurationTimer: Timer?
    static var milliseconds: Float? // Game start second
    static var gameDurationSecond: Float?   //Game duration Second
    var darkModeSecond = 5
    var millisecondForLevel: Float?   // Second for the each level
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberArray = model.getNumbers()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        Set the timer label
        timerLabel.text = "\((GameSceneViewController.milliseconds ?? 0) / 1000)"
        
//        Adding delay to number display time when level is open
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            //        Create Number Display Timer
            self.numberDisplayTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.numberDisplayTimerElapsed), userInfo: nil, repeats: true)
            
        }
        
        //        Set the second for current level
        millisecondForLevel = GameSceneViewController.milliseconds
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
            
            //       MARK - Game Logic
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
    
    //    MARK - Numbers Display Timer Methods
    @objc func numberDisplayTimerElapsed() {
        
        for i in numberArray {
            
            //            Turn all numbers
            if GameSceneViewController.milliseconds ?? 5 > 0 && i.isFlipped == false {
                
                i.isFlipped = true
                
            }
        }
        
        //        When the Display Timer has reached 0
        for i in numberArray {
            
            //            Turn off all numbers
            if GameSceneViewController.milliseconds ?? 5 <= 0 && i.isFlipped == true {
                
                for item in cellArray {
                    
//                    Numbers flipBack
                    item.flipBack(delayTime: 0.5, transitionDuration: 0.3)
                    i.isFlipped = false
                    
                }
                
//                Stop the Display Timer
                numberDisplayTimer?.invalidate()
                timerLabel.isHidden = true
                
            }
        }
        
        //        For dark mode Levels
        if GameSceneViewController.milliseconds ?? 5 <= 0 && LevelsVC.blackScreen == true {
            
            collectionView.isHidden = true
            
            //        Create Dark Mode Timer
            darkModeTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(darkModeTimerElapsed), userInfo: nil, repeats: true)
            
        }
        
        //        When display time is over
        else if GameSceneViewController.milliseconds ?? 5 <= 0 {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                //        Create Game Duration Timer
                self.gameDurationTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.gameDurationTimerElapsed), userInfo: nil, repeats: true)
            }
            
        }
        
        //        Time reducing
        if GameSceneViewController.milliseconds != nil {
            
            //            Reducing time if millisecond is not nil
            GameSceneViewController.milliseconds! -= 1
            
        } else {
            
            //            If millisecond is nil for any reason default time is 5
            GameSceneViewController.milliseconds = 5 * 1000
            GameSceneViewController.milliseconds! -= 1
            
        }
        
        //        Convert to seconds
        let seconds = String(format: "%.2f", (GameSceneViewController.milliseconds ?? 5)/1000)
        
        //        Set label
        timerLabel.text = "\(seconds)"
        
    }
    
    //    MARK - Dark Mode Timer Methods
    @objc func darkModeTimerElapsed() {
        
        LevelsVC.blackScreen = false
        timerLabel.isHidden = false
        
        if darkModeSecond <= 0 {
            
            collectionView.isHidden = false

            for item in cellArray {
                
                //                    Numbers flipBack
                item.flipBack(delayTime: 0.0001, transitionDuration: 0)
            }
            
            timerLabel.isHidden = true
            
//            Adding delay to Game Duration Timer
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                
                //        Create Game Duration Timer
                self.gameDurationTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.gameDurationTimerElapsed), userInfo: nil, repeats: true)
                
            }

            darkModeTimer?.invalidate()
            
        } else {
            
            //        Set label
            timerLabel.text = "\(darkModeSecond)"
            
            darkModeSecond -= 1
            
        }
        
    }
    
    //    MARK - Game Duration Timer Methods
    @objc func gameDurationTimerElapsed() {
        
        timerLabel.isHidden = false
        
        //        When Times up
        if GameSceneViewController.gameDurationSecond! <= 0 {
            
//            Stop the timer
            gameDurationTimer?.invalidate()
            
//            Alert when Time's up
            showAlert("Times Up!!!", "You didn't finish on the time")
            
        }
        
        //            Reducing time if millisecond is not nil
        if GameSceneViewController.gameDurationSecond != nil {
            
            GameSceneViewController.gameDurationSecond! -= 1
            
        }
        
        //        Convert to seconds
        let seconds = String(format: "%.2f", (GameSceneViewController.gameDurationSecond ?? 5)/1000)
        
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
        GameSceneViewController.milliseconds = millisecondForLevel
        timerLabel.isHidden = false
        collectionView.reloadData()
        numberDisplayTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(numberDisplayTimerElapsed), userInfo: nil, repeats: true)
        
    }
    
}
