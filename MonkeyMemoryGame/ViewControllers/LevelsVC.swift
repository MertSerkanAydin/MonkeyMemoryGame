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
    var levelArray = [LevelNumber]()
    static var blackScreen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        Set the background Color of collectionView and view
        DispatchQueue.main.async {
            
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "viewBackground.png")!)
            self.collecionView?.backgroundColor = UIColor.clear
            self.modalPresentationStyle = .overFullScreen

        }
        
        levelArray = model.getNumbers()
        
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
        
        return levelArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LevelsCollectionViewCell.identifier, for: indexPath) as! LevelsCollectionViewCell
        
        //        Get the number that the collection view is trying to display
        let levelNumber = levelArray[indexPath.row]
        
        //        set that number for the cell
        cell.setLevelNumber(levelNumber)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        Get the cell that the user selected
        let cell = collectionView.cellForItem(at: indexPath) as! LevelsCollectionViewCell
        
        //        Get the level that the user selected
        let level = levelArray[indexPath.row]
        
//        var intLevelImageName = Double(level.imageName)!
//
//        for item in levelArray {
//            if item.imageName == "\(intLevelImageName - 0.1)" {
//                if item.isDone == true {
//                    print("varrrr")
//                }
//            }
////            else {
////                print("yok")
////            }
//        }
//    
        
        //        When click the level go to GameVC
        if level.isAvailable == false && level.isDone == true {
            
//            Level context
            switch level.imageName {
            case "13":
                NumberModel.howManyCard = 3
                GameSceneViewController.numberDisplaySecond = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false
            case "14":
                NumberModel.howManyCard = 4
                GameSceneViewController.numberDisplaySecond = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false
            case "15":
                NumberModel.howManyCard = 5
                GameSceneViewController.numberDisplaySecond = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false
            case "16":
                NumberModel.howManyCard = 6
                GameSceneViewController.numberDisplaySecond = 5 * 1000
                GameSceneViewController.gameDurationSecond = 7 * 1000
                LevelsVC.blackScreen = false
            case "17":
                NumberModel.howManyCard = 7
                GameSceneViewController.numberDisplaySecond = 5 * 1000
                GameSceneViewController.gameDurationSecond = 7 * 1000
                LevelsVC.blackScreen = false
            case "18":
                NumberModel.howManyCard = 8
                GameSceneViewController.numberDisplaySecond = 5 * 1000
                GameSceneViewController.gameDurationSecond = 10 * 1000
                LevelsVC.blackScreen = false
            case "19":
                NumberModel.howManyCard = 9
                GameSceneViewController.numberDisplaySecond = 10 * 1000
                GameSceneViewController.gameDurationSecond = 15 * 1000
                LevelsVC.blackScreen = false
            case "20":
                NumberModel.howManyCard = 10
                GameSceneViewController.numberDisplaySecond = 10 * 1000
                GameSceneViewController.gameDurationSecond = 20 * 1000
                LevelsVC.blackScreen = false
            case "21":
                NumberModel.howManyCard = 5
                GameSceneViewController.numberDisplaySecond = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false
            case "22":
                NumberModel.howManyCard = 6
                GameSceneViewController.numberDisplaySecond = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false
            case "23":
                NumberModel.howManyCard = 7
                GameSceneViewController.numberDisplaySecond = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = true
            case "24":
                NumberModel.howManyCard = 8
                GameSceneViewController.numberDisplaySecond = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = true
            case "25":
                NumberModel.howManyCard = 3
                GameSceneViewController.numberDisplaySecond = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false
            case "26":
                NumberModel.howManyCard = 4
                GameSceneViewController.numberDisplaySecond = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false
            case "27":
                NumberModel.howManyCard = 5
                GameSceneViewController.numberDisplaySecond = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false
            case "28":
                NumberModel.howManyCard = 6
                GameSceneViewController.numberDisplaySecond = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false
            case "29":
                NumberModel.howManyCard = 3
                GameSceneViewController.numberDisplaySecond = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false
            case "30":
                NumberModel.howManyCard = 4
                GameSceneViewController.numberDisplaySecond = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false
            case "31":
                NumberModel.howManyCard = 5
                GameSceneViewController.numberDisplaySecond = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false
            case "32":
                NumberModel.howManyCard = 6
                GameSceneViewController.numberDisplaySecond = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false
            case "33":
                NumberModel.howManyCard = 3
                GameSceneViewController.numberDisplaySecond = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false
            case "34":
                NumberModel.howManyCard = 4
                GameSceneViewController.numberDisplaySecond = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false
            case "35":
                NumberModel.howManyCard = 5
                GameSceneViewController.numberDisplaySecond = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false
            case "36":
                NumberModel.howManyCard = 6
                GameSceneViewController.numberDisplaySecond = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false
            case "37":
                NumberModel.howManyCard = 3
                GameSceneViewController.numberDisplaySecond = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false
            case "38":
                NumberModel.howManyCard = 4
                GameSceneViewController.numberDisplaySecond = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false
            case "39":
                NumberModel.howManyCard = 5
                GameSceneViewController.numberDisplaySecond = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false
            case "40":
                NumberModel.howManyCard = 6
                GameSceneViewController.numberDisplaySecond = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = false

            default:
                print("serkan")
            }
            
            
            if let vc = storyboard?.instantiateViewController(withIdentifier: "gameVC") as? GameSceneViewController {
                
                self.present(vc, animated: true)
                
                navigationController?.popViewController(animated: true)
                
            }
        }
    }
    
}
