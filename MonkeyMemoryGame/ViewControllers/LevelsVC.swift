//
//  LevelsVC.swift
//  MonkeyMemoryGame
//
//  Created by Mert Serkan Aydın on 14.08.2023.
//

import UIKit

class LevelsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var collecionView: UICollectionView?
    
    let layout = UICollectionViewFlowLayout()  // A layout object that organizes items into a grid
    
    var model = LevelNumberModel()
    static var levelArray = [LevelNumber]()
    static var blackScreen = false
    
    //    For level completion check
    static var levelCompletionStatusArray: [Bool] = [true, false, false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]
    
    static var selectedLevel = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        
        collecionView?.reloadData()
        
        //        Saving user's complete levels
        let levelCompletionStatusDefaults = UserDefaults.standard.object(forKey: "levelCompletionStatusKey")
        
        //        getting saving levels
        if let storedArray = levelCompletionStatusDefaults as? [Bool] {
            LevelsVC.levelCompletionStatusArray = storedArray
        }
        
        print(LevelsVC.levelCompletionStatusArray)
        //        Set the background Color of collectionView and view
        DispatchQueue.main.async {
            
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "viewBackground.png")!)
            self.collecionView?.backgroundColor = UIColor.clear
            self.modalPresentationStyle = .fullScreen
            
        }
        
        LevelsVC.levelArray = model.getNumbers()
        
        //        CollectionView size settings
        
        //        The default size to use for cells.
        layout.itemSize = CGSize(width: (view.frame.size.width / 5) - view.frame.size.width / 30, height: (view.frame.size.height / 12))
        
        //        The minimum spacing to use between lines of items in the grid.
        layout.minimumLineSpacing = view.frame.size.height / 30
        
        //        The minimum spacing to use between items in the same row.
        layout.minimumInteritemSpacing = view.frame.size.width / 30
        
        //        The margins used to lay out content in a section.
        layout.sectionInset = UIEdgeInsets(top: 50, left: 30, bottom: 50, right: 30)
        
        //        Creates a collection view object with the specified frame and layout.
        collecionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collecionView?.delegate = self
        collecionView?.dataSource = self
        
        //        Registers a class for use in creating new collection view cells.
        collecionView?.register(LevelsCollectionViewCell.self, forCellWithReuseIdentifier: LevelsCollectionViewCell.identifier)
        
        guard let collecionView = collecionView else {
            return
        }
        
        collecionView.frame = view.bounds
        view.addSubview(collecionView)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return LevelsVC.levelArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LevelsCollectionViewCell.identifier, for: indexPath) as! LevelsCollectionViewCell
        
        //        Get the number that the collection view is trying to display
        let levelNumber = LevelsVC.levelArray[indexPath.row]
        
        //        set that number for the cell
        cell.setLevelNumber(levelNumber)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        Get the level that the user selected
        let level = LevelsVC.levelArray[indexPath.row]
        
        //        Get user selected index
        LevelsVC.selectedLevel = indexPath.row
        
        let previousLevel = LevelsVC.selectedLevel - 1
        
        // Check if the previous level is completed before allowing selection
        if level.imageName == "1.0" || LevelsVC.levelCompletionStatusArray[previousLevel] == true {
            
            //            Level context
            switch level.imageName {
            case "1.0":
                NumberModel.howManyCard = 4
                GameSceneViewController.numberDisplaySecond = 3 * 1000
                GameSceneViewController.gameDurationSecond = 100 * 1000
                GameSceneViewController.reverseSorting = false
                LevelsVC.blackScreen = false
            case "1.1":
                NumberModel.howManyCard = 6
                GameSceneViewController.numberDisplaySecond = 3 * 1000
                GameSceneViewController.gameDurationSecond = 10 * 1000
                GameSceneViewController.reverseSorting = false
                LevelsVC.blackScreen = false
            case "1.2":
                NumberModel.howManyCard = 7
                GameSceneViewController.numberDisplaySecond = 3 * 1000
                GameSceneViewController.gameDurationSecond = 10 * 1000
                GameSceneViewController.reverseSorting = false
                LevelsVC.blackScreen = false
            case "1.3":
                NumberModel.howManyCard = 8
                GameSceneViewController.numberDisplaySecond = 5 * 1000
                GameSceneViewController.gameDurationSecond = 10 * 1000
                GameSceneViewController.reverseSorting = false
                LevelsVC.blackScreen = false
            case "1.4":
                NumberModel.howManyCard = 7
                GameSceneViewController.numberDisplaySecond = 3 * 1000
                GameSceneViewController.gameDurationSecond = 15 * 1000
                GameSceneViewController.reverseSorting = true
                reverseSortingAlert()
                LevelsVC.blackScreen = false
            case "1.5":
                NumberModel.howManyCard = 8
                GameSceneViewController.numberDisplaySecond = 2 * 1000
                GameSceneViewController.gameDurationSecond = 10 * 1000
                GameSceneViewController.reverseSorting = false
                LevelsVC.blackScreen = false
            case "1.6":
                NumberModel.howManyCard = 8
                GameSceneViewController.numberDisplaySecond = 5 * 1000
                GameSceneViewController.gameDurationSecond = 10 * 1000
                GameSceneViewController.reverseSorting = false
                LevelsVC.blackScreen = false
            case "1.7":
                NumberModel.howManyCard = 8
                GameSceneViewController.numberDisplaySecond = 5 * 1000
                GameSceneViewController.gameDurationSecond = 20 * 1000
                GameSceneViewController.reverseSorting = true
                reverseSortingAlert()
                LevelsVC.blackScreen = false
            case "1.8":
                NumberModel.howManyCard = 9
                GameSceneViewController.numberDisplaySecond = 5 * 1000
                GameSceneViewController.gameDurationSecond = 20 * 1000
                GameSceneViewController.reverseSorting = false
                LevelsVC.blackScreen = false
            case "1.9":
                NumberModel.howManyCard = 10
                GameSceneViewController.numberDisplaySecond = 10 * 1000
                GameSceneViewController.gameDurationSecond = 30 * 1000
                LevelsVC.blackScreen = false
            case "1.10":
                NumberModel.howManyCard = 10
                GameSceneViewController.numberDisplaySecond = 10 * 1000
                GameSceneViewController.gameDurationSecond = 10 * 1000
                GameSceneViewController.reverseSorting = true
                reverseSortingAlert()
                LevelsVC.blackScreen = false
            case "1.11":
                NumberModel.howManyCard = 8
                GameSceneViewController.numberDisplaySecond = 3 * 1000
                GameSceneViewController.gameDurationSecond = 10 * 1000
                GameSceneViewController.reverseSorting = false
                LevelsVC.blackScreen = true
            case "1.12":
                NumberModel.howManyCard = 8
                GameSceneViewController.numberDisplaySecond = 3 * 1000
                GameSceneViewController.gameDurationSecond = 7 * 1000
                GameSceneViewController.reverseSorting = true
                reverseSortingAlert()
                LevelsVC.blackScreen = true
            case "1.13":
                NumberModel.howManyCard = 8
                GameSceneViewController.numberDisplaySecond = 1 * 1000
                GameSceneViewController.gameDurationSecond = 15 * 1000
                GameSceneViewController.reverseSorting = true
                reverseSortingAlert()
                LevelsVC.blackScreen = true
            case "1.14":
                NumberModel.howManyCard = 9
                GameSceneViewController.numberDisplaySecond = 3 * 1000
                GameSceneViewController.gameDurationSecond = 8 * 1000
                GameSceneViewController.reverseSorting = true
                reverseSortingAlert()
                LevelsVC.blackScreen = false
            case "1.15":
                NumberModel.howManyCard = 10
                GameSceneViewController.numberDisplaySecond = 3 * 1000
                GameSceneViewController.gameDurationSecond = 8 * 1000
                GameSceneViewController.reverseSorting = false
                LevelsVC.blackScreen = false
            case "1.16":
                NumberModel.howManyCard = 10
                GameSceneViewController.numberDisplaySecond = 3 * 1000
                GameSceneViewController.gameDurationSecond = 9 * 1000
                GameSceneViewController.reverseSorting = true
                reverseSortingAlert()
                LevelsVC.blackScreen = false
            case "1.17":
                NumberModel.howManyCard = 8
                GameSceneViewController.numberDisplaySecond = 1 * 1000
                GameSceneViewController.gameDurationSecond = 10 * 1000
                GameSceneViewController.reverseSorting = false
                LevelsVC.blackScreen = false
            case "1.18":
                NumberModel.howManyCard = 9
                GameSceneViewController.numberDisplaySecond = 1 * 1000
                GameSceneViewController.gameDurationSecond = 10 * 1000
                GameSceneViewController.reverseSorting = true
                reverseSortingAlert()
                LevelsVC.blackScreen = false
            case "1.19":
                NumberModel.howManyCard = 10
                GameSceneViewController.numberDisplaySecond = 3 * 1000
                GameSceneViewController.gameDurationSecond = 10 * 1000
                GameSceneViewController.reverseSorting = false
                LevelsVC.blackScreen = false
            case "1.20":
                NumberModel.howManyCard = 11
                GameSceneViewController.numberDisplaySecond = 5 * 1000
                GameSceneViewController.gameDurationSecond = 10 * 1000
                GameSceneViewController.reverseSorting = false
                LevelsVC.blackScreen = false
            case "1.21":
                NumberModel.howManyCard = 12
                GameSceneViewController.numberDisplaySecond = 10 * 1000
                GameSceneViewController.gameDurationSecond = 15 * 1000
                GameSceneViewController.reverseSorting = false
                LevelsVC.blackScreen = false
            case "1.22":
                NumberModel.howManyCard = 11
                GameSceneViewController.numberDisplaySecond = 7 * 1000
                GameSceneViewController.gameDurationSecond = 10 * 1000
                GameSceneViewController.reverseSorting = true
                reverseSortingAlert()
                LevelsVC.blackScreen = false
            case "1.23":
                NumberModel.howManyCard = 12
                GameSceneViewController.numberDisplaySecond = 7 * 1000
                GameSceneViewController.gameDurationSecond = 10 * 1000
                GameSceneViewController.reverseSorting = true
                reverseSortingAlert()
                LevelsVC.blackScreen = false
            case "1.24":
                NumberModel.howManyCard = 10
                GameSceneViewController.numberDisplaySecond = 2 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                GameSceneViewController.reverseSorting = false
                LevelsVC.blackScreen = false
            case "1.25":
                NumberModel.howManyCard = 11
                GameSceneViewController.numberDisplaySecond = 3 * 1000
                GameSceneViewController.gameDurationSecond = 8 * 1000
                GameSceneViewController.reverseSorting = false
                LevelsVC.blackScreen = false
            case "1.26":
                NumberModel.howManyCard = 11
                GameSceneViewController.numberDisplaySecond = 5 * 1000
                GameSceneViewController.gameDurationSecond = 15 * 1000
                GameSceneViewController.reverseSorting = false
                LevelsVC.blackScreen = true
            case "1.27":
                NumberModel.howManyCard = 12
                GameSceneViewController.numberDisplaySecond = 7 * 1000
                GameSceneViewController.gameDurationSecond = 15 * 1000
                GameSceneViewController.reverseSorting = true
                reverseSortingAlert()
                LevelsVC.blackScreen = true
                
            default:
                print("serkan")
            }
            
            // Navigate to the selected level's gameplay or details screen
            
            //        When click the level go to GameVC
            
            if GameSceneViewController.reverseSorting == true {
                reverseSortingAlert()
            } else {
                if let vc = storyboard?.instantiateViewController(withIdentifier: "gameVC") as? GameSceneViewController {
                    
                    self.present(vc, animated: true)
                    
                    navigationController?.popViewController(animated: true)
                    
                }
            }
            
        } else {
            
            // Inform the player that the previous level needs to be completed first
            
            //            if previous level not complete
            let alert = UIAlertController(title: "It's not that easy!",
                                          message: "You have to finish level \(LevelsVC.selectedLevel).",
                                          preferredStyle: .alert)
            
            // Add action buttons to it and attach handler functions if you want to
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            // Show the alert by presenting it
            
            self.present(alert, animated: true)
            
        }
        
    }
    
    func reverseSortingAlert() {
        //            reverse sorting level information
        let alert = UIAlertController(title: "It's gonna be harder",
                                      message: "Now you have to rank them in descending order. Like 3 -> 2 -> 1.",
                                      preferredStyle: .alert)
        
        // Add action buttons to it and attach handler functions if you want to
        
        alert.addAction(UIAlertAction(title: "GO ON", style: .default, handler: { performSegue in
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as? GameSceneViewController {
                
                self.present(vc, animated: true)
                
                self.navigationController?.popViewController(animated: true)
                
            }
        }))
        
        // Show the alert by presenting it
        
        self.present(alert, animated: true)
        
    }
    
}
