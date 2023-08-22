//
//  GameSceneViewController.swift
//  MonkeyMemoryGame
//
//  Created by Mert Serkan Aydın on 9.08.2023.
//

import UIKit

class GameSceneViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var collecionView: UICollectionView?
    
    let layout = UICollectionViewFlowLayout()  // A layout object that organizes items into a grid
    
    var model = NumberModel()
    var numberArray = [Number]()
    var lastPickingNumber = 0
    var lastPickingNumberReverseSorting = NumberModel.howManyCard + 1
    var cellArray = [NumbersOfGameCollectionViewCell]()
    
    var numberDisplayTimer: Timer?
    var darkModeTimer: Timer?
    var gameDurationTimer: Timer?
    
    static var numberDisplaySecond: Float? // Game start second
    static var gameDurationSecond: Float?   //Game duration Second
    var darkModeSecond = 5
    var gameDurationSecondForLevel: Float?
    var millisecondForLevel: Float?   // Second for the each level
    
    var timerLabel = UILabel()
    var titleLabel = UILabel()
    
    var playAgainButton = UIButton()
    var backToMenuButton = UIButton()
    
    var gameOverImageView = UIImageView()
    var wellDoneImageView = UIImageView()
    var darkModeMessageImageView = UIImageView()
    
    var canTouchToCollectionView = true
    static var reverseSorting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        Set the background Color of collectionView and view
        DispatchQueue.main.async {
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "viewBackground.png")!)
            self.collecionView?.backgroundColor = UIColor.clear
            self.modalPresentationStyle = .fullScreen
            
        }
        
//        Set the navigationBar
        
        self.navigationItem.title = "Level \(LevelsVC.selectedLevel + 1)"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menuButton"), style: .plain, target: self, action: #selector(backToMenu))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "retryButton"), style: .plain, target: self, action: #selector(playAgain))
        
        
        //        Set the Timer Label
        timerLabel = UILabel(frame: CGRect(x: 0, y: (view.frame.size.height) - 50, width: view.frame.width, height: 50))
        timerLabel.text = "welcome"
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: UIFont.Weight.bold)  // For the label shaking
        timerLabel.layer.borderColor = UIColor.gray.cgColor
        timerLabel.layer.borderWidth = 3.0
        view.addSubview(timerLabel)
        
        numberArray = model.getNumbers()
        
        //        CollectionView size settings
        
        let viewW = self.view.frame.size.width
        let viewH = self.view.frame.size.height
        let timerLabelH = self.timerLabel.frame.size.height
        //        The default size to use for cells.
        
        if NumberModel.howManyCard <= 8 {
            
            layout.itemSize = CGSize(width: (viewW / 3) - viewW / 20, height: (viewH / 8.4))
            
            //        The minimum spacing to use between lines of items in the grid.
            layout.minimumLineSpacing = viewH / 20
            
            //        The minimum spacing to use between items in the same row.
            layout.minimumInteritemSpacing = viewW / 24
            
            //        The margins used to lay out content in a section.
            layout.sectionInset = UIEdgeInsets(top: viewH / 6, left: viewW / 8, bottom: timerLabelH - 20, right: viewW / 8)
            
            //        Creates a collection view object with the specified frame and layout.
            collecionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            
        } else if NumberModel.howManyCard > 8 && NumberModel.howManyCard <= 10 {
            
            layout.itemSize = CGSize(width: (viewW / 3.6) - viewW / 24, height: (viewH / 8.4))
            
            //        The minimum spacing to use between lines of items in the grid.
            layout.minimumLineSpacing = viewH / 27
            
            //        The minimum spacing to use between items in the same row.
            layout.minimumInteritemSpacing = viewW / 10
            
            //        The margins used to lay out content in a section.
            layout.sectionInset = UIEdgeInsets(top: viewH / 8, left: viewW / 7, bottom: timerLabelH - 20, right: viewW / 7)
            
            //        Creates a collection view object with the specified frame and layout.
            collecionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            
        } else if NumberModel.howManyCard > 10 && NumberModel.howManyCard <= 12 {
            
            layout.itemSize = CGSize(width: (viewW / 4.32) - viewW / 28.8, height: (viewH / 10.08))
            
            //        The minimum spacing to use between lines of items in the grid.
            layout.minimumLineSpacing = viewH / 27
            
            //        The minimum spacing to use between items in the same row.
            layout.minimumInteritemSpacing = viewW / 5
            
            //        The margins used to lay out content in a section.
            layout.sectionInset = UIEdgeInsets(top: viewH / 9, left: viewW / 5, bottom: timerLabelH - 20, right: viewW / 5)
            
            //        Creates a collection view object with the specified frame and layout.
            collecionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            
        }
        
        
        
        //        Unwrap collectionView
        guard let collecionView = collecionView else {return}
        
        collecionView.isScrollEnabled = false
        collecionView.delegate = self
        collecionView.dataSource = self
        
        //        Set the timer label
        timerLabel.text = "\((GameSceneViewController.numberDisplaySecond ?? 0) / 1000)"
        
        //        Adding delay to number display time when level is open
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            //        Create Number Display Timer
            self.numberDisplayTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.numberDisplayTimerElapsed), userInfo: nil, repeats: true)
            
        }
        
        collecionView.register(NumbersOfGameCollectionViewCell.self, forCellWithReuseIdentifier: NumbersOfGameCollectionViewCell.identifier)
        
        collecionView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - timerLabel.frame.height)
        view.addSubview(collecionView)
        
        //        Set the seconds for current level
        millisecondForLevel = GameSceneViewController.numberDisplaySecond
        gameDurationSecondForLevel = GameSceneViewController.gameDurationSecond
        
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
        
        if canTouchToCollectionView == true {
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
                    
                    //                Reverse sorting
                    
                    if GameSceneViewController.reverseSorting == true {
                        
                        if lastPickingNumberReverseSorting - imageNameToINT == 1 {
                            
                            lastPickingNumberReverseSorting = imageNameToINT
                            number.isCorrect = true
                            
                            //                    Game Win Check
                            if lastPickingNumberReverseSorting == 1 { // When level finished
                                
                                //                       Set the CollectionView untouchable
                                canTouchToCollectionView = false
                                
                                //                            Chenge level status to true
                                LevelsVC.levelCompletionStatusArray[LevelsVC.selectedLevel] = true
                                
                                //                            Saving completion
                                UserDefaults.standard.set(LevelsVC.levelCompletionStatusArray, forKey: "levelCompletionStatusKey")
                                
                                showAlert("W")
                                gameDurationTimer?.invalidate()
                                
                            }
                        } else {
                              // When the wrong number is flipped by user
                                
                                //                       Set the CollectionView untouchable
                                canTouchToCollectionView = false
                                
                                showAlert("L")
                                gameDurationTimer?.invalidate()
                                
                                //            Flip all card
                                
                                for array in cellArray {
                                    array.flip()
                                }
                            
                        }
                    } else {
                        
                        if imageNameToINT - lastPickingNumber == 1 {
                            
                            lastPickingNumber = imageNameToINT
                            number.isCorrect = true
                            
                            //                    Game Win Check
                            if imageNameToINT == numberArray.count { // When level finished
                                
                                //                       Set the CollectionView untouchable
                                canTouchToCollectionView = false
                                
                                //                            Chenge level status to true
                                LevelsVC.levelCompletionStatusArray[LevelsVC.selectedLevel] = true
                                
                                //                            Saving completion
                                UserDefaults.standard.set(LevelsVC.levelCompletionStatusArray, forKey: "levelCompletionStatusKey")
                                
                                showAlert("W")
                                gameDurationTimer?.invalidate()
                                
                            }
                            
                        } else {  // When the wrong number is flipped by user
                            
                            //                       Set the CollectionView untouchable
                            canTouchToCollectionView = false
                            
                            showAlert("L")
                            gameDurationTimer?.invalidate()
                            
                            //            Flip all card
                            
                            for array in cellArray {
                                array.flip()
                            }
                            
                        }
                        
                    }
                }
            }
            
        }
    }
    
    //    MARK - Numbers Display Timer Methods
    @objc func numberDisplayTimerElapsed() {
        
        canTouchToCollectionView = false
        
        for i in numberArray {
            
            //            Turn all numbers
            if GameSceneViewController.numberDisplaySecond ?? 5 > 0 && i.isFlipped == false {
                
                i.isFlipped = true
                
            }
        }
        
        //        When the Display Timer has reached 0
        for i in numberArray {
            
            //            Turn off all numbers
            if GameSceneViewController.numberDisplaySecond ?? 5 <= 0 && i.isFlipped == true {
                
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
        if GameSceneViewController.numberDisplaySecond ?? 5 <= 0 && LevelsVC.blackScreen == true {
            
            canTouchToCollectionView = false
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                
                
                self.collecionView!.isHidden = true
                
                //        Set the darkMode Message imageView
                self.darkModeMessageImageView.contentMode = UIView.ContentMode.scaleAspectFit
                self.darkModeMessageImageView.frame.size.width = self.view.frame.size.width / 1.3
                self.darkModeMessageImageView.frame.size.height = self.view.frame.size.height / 2
                
                self.darkModeMessageImageView = UIImageView(frame: CGRect(x: (self.view.frame.size.width / 2) - (self.darkModeMessageImageView.frame.size.width / 2),
                                                                          y: (self.view.frame.size.height / 2) - (self.darkModeMessageImageView.frame.size.height / 2),
                                                                          width: self.view.frame.size.width / 1.3,
                                                                          height: self.view.frame.size.height / 2 ))
                self.darkModeMessageImageView.image = UIImage(named: "darkModeMessage.png")
                
                self.darkModeMessageImageView.alpha = 0
                
                self.view.addSubview(self.darkModeMessageImageView)
                
                self.canTouchToCollectionView = true
                
                UIView.animate(withDuration: 1) {
                    self.darkModeMessageImageView.alpha = 1
                }
                
            }

            
            
            //        Create Dark Mode Timer
            darkModeTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(darkModeTimerElapsed), userInfo: nil, repeats: true)
            
        }
        
        //        When display time is over
        else if GameSceneViewController.numberDisplaySecond ?? 5 <= 0 {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                //        Create Game Duration Timer
                self.gameDurationTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.gameDurationTimerElapsed), userInfo: nil, repeats: true)
            }
            
        }
        
        //        Time reducing
        if GameSceneViewController.numberDisplaySecond != nil {
            
            //            Reducing time if millisecond is not nil
            GameSceneViewController.numberDisplaySecond! -= 1
            
        } else {
            
            //            If millisecond is nil for any reason default time is 5
            GameSceneViewController.numberDisplaySecond = 5 * 1000
            GameSceneViewController.numberDisplaySecond! -= 1
            
        }
        
        //        Convert to seconds
        let seconds = String(format: "%.2f", (GameSceneViewController.numberDisplaySecond ?? 5)/1000)
        
        //        Set label
        timerLabel.text = "\(seconds)"
        
    }
    
    //    MARK - Dark Mode Timer Methods
    @objc func darkModeTimerElapsed() {
        
        timerLabel.isHidden = false
        
        //        When the dark mode finish
        if darkModeSecond <= 0 {
            
            darkModeMessageImageView.removeFromSuperview()
            
            collecionView!.isHidden = false
            
            for item in cellArray {
                
                //                    Numbers flipBack because when collectionViewisHidden goes true all cards flipped
                item.flipBack(delayTime: 0.0001, transitionDuration: 0)
            }
            
            //        Create Game Duration Timer
            self.gameDurationTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.gameDurationTimerElapsed), userInfo: nil, repeats: true)
            
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
        
        
        //        Convert to seconds
        let seconds = String(format: "%.2f", (GameSceneViewController.gameDurationSecond ?? 5)/1000)
        
        //        Set label
        timerLabel.text = "Time Remaining: \(seconds)"
        
        canTouchToCollectionView = true
        
        //        When Times up
        if GameSceneViewController.gameDurationSecond! <= 0 {
            
            //            Stop the timer
            gameDurationTimer?.invalidate()
            
            timerLabel.text = "Time Remaining: 0.00"
            
            //            Alert when Time's up
            showAlert("Times Up!")
            
            //            Flip all card
            for array in cellArray {
                array.flip()
            }
            
        }
        
        //            Reducing time if millisecond is not nil
        if GameSceneViewController.gameDurationSecond != nil {
            
            GameSceneViewController.gameDurationSecond! -= 1
            
        }
        
    }
    
    //    Alert Method
    func showAlert(_ message: String) {
        
        //        Get width and heights
        guard let playAgainButtonimageW = UIImage(named: "retryButton")?.size.width else {return}
        guard let playAgainButtonimageH = UIImage(named: "retryButton")?.size.height else {return}
        guard let menuButtonImageW = UIImage(named: "menuButton")?.size.width else {return}
        guard let menuButtonImageH = UIImage(named: "menuButton")?.size.height else {return}
        guard let collecionViewW = collecionView?.frame.size.width else {return}
        guard let collecionViewH = collecionView?.frame.size.height else {return}
        
        //        We set the number of collectionView alpha
        let collectionViewAlphaTo: CGFloat = 0.3
        
        //        Set Play Again Button
        playAgainButton = UIButton(frame: CGRect(x: (collecionViewW / 2) - (playAgainButtonimageW / 2),
                                                 y: (collecionViewH / 2) - (playAgainButtonimageH),
                                                 width: playAgainButtonimageW,
                                                 height: playAgainButtonimageH))
        playAgainButton.addTarget(self, action: #selector(playAgain), for: .touchUpInside)
        playAgainButton.setImage(UIImage(named: "retryButton"), for: .normal)
        playAgainButton.layer.masksToBounds = true
        playAgainButton.layer.cornerRadius = 20
        view.addSubview(playAgainButton)
        
        //        Set Back To Menu Button
        backToMenuButton = UIButton(frame: CGRect(x: (collecionViewW / 2) - (menuButtonImageW / 2),
                                                  y: (collecionViewH / 2) + (menuButtonImageH),
                                                  width: menuButtonImageW,
                                                  height: menuButtonImageH))
        backToMenuButton.addTarget(self, action: #selector(backToMenu), for: .touchUpInside)
        backToMenuButton.setImage(UIImage(named: "menuButton"), for: UIControl.State.normal)
        backToMenuButton.layer.masksToBounds = true
        backToMenuButton.layer.cornerRadius = 20
        view.addSubview(backToMenuButton)
        
        
        if message == "L" {
            
            //        Set the Game Over imageView
            gameOverImageView.contentMode = UIView.ContentMode.scaleAspectFit
            gameOverImageView.frame.size.width = view.frame.size.width / 1.2
            gameOverImageView.frame.size.height = view.frame.size.height / 8
            
            gameOverImageView = UIImageView(frame: CGRect(x: (view.frame.size.width / 2) - (gameOverImageView.frame.size.width / 2),
                                                          y: (collecionViewH / 3.5) - (gameOverImageView.frame.size.height / 2),
                                                          width: view.frame.size.width / 1.2,
                                                          height: view.frame.size.height / 8 ))
            gameOverImageView.image = UIImage(named: "gameOver.png")
            
            view.addSubview(gameOverImageView)
            
        } else if message == "W" {
            
            //        Set the Well Done imageView
            wellDoneImageView.contentMode = UIView.ContentMode.scaleAspectFit
            wellDoneImageView.frame.size.width = view.frame.size.width / 1.2
            wellDoneImageView.frame.size.height = view.frame.size.height / 8
            
            wellDoneImageView = UIImageView(frame: CGRect(x: (view.frame.size.width / 2) - (wellDoneImageView.frame.size.width / 2),
                                                          y: (collecionViewH / 3.5) - (wellDoneImageView.frame.size.height / 2),
                                                          width: view.frame.size.width / 1.2,
                                                          height: view.frame.size.height / 8 ))
            wellDoneImageView.image = UIImage(named: "wellDone.png")
            
            view.addSubview(wellDoneImageView)
            
        }
        
        //        Set collectionView alpha equal to collectionViewAlphaTo in 0.25 seconds
        UIView.animate(withDuration: 0.25) {
            self.collecionView?.alpha = collectionViewAlphaTo
        }
    }
    
    //    Play again Method
    @objc func playAgain() {
        
        lastPickingNumber = 0
        lastPickingNumberReverseSorting = NumberModel.howManyCard + 1
        numberArray = [Number]()
        cellArray = [NumbersOfGameCollectionViewCell]()
        numberArray = model.getNumbers()
        GameSceneViewController.numberDisplaySecond = millisecondForLevel
        GameSceneViewController.gameDurationSecond = gameDurationSecondForLevel
        timerLabel.isHidden = false
        collecionView!.reloadData()
        darkModeSecond = 5
        numberDisplayTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(numberDisplayTimerElapsed), userInfo: nil, repeats: true)
        gameDurationTimer?.invalidate()
        collecionView?.alpha = 1
        playAgainButton.removeFromSuperview()
        backToMenuButton.removeFromSuperview()
        titleLabel.removeFromSuperview()
        gameOverImageView.removeFromSuperview()
        wellDoneImageView.removeFromSuperview()
        canTouchToCollectionView = true
        
    }
    
    // Going to Menu Func
    @objc func backToMenu() {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Levels") as? LevelsVC {
            
            self.present(vc, animated: true)
            
            navigationController?.popViewController(animated: true)
            
        }
        
    }
    
}
