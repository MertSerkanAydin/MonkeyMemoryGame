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
            self.view.backgroundColor = UIColor.systemTeal
            self.collecionView?.backgroundColor = UIColor.systemTeal
            
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
        
        //        When click the level go to GameVC
        if level.isAvailable == true && level.isClicked == false {
            
//            Level context
            switch level.imageName {
            case "1.1":
                NumberModel.howManyCard = 3
                GameSceneViewController.milliseconds = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
            case "1.2":
                NumberModel.howManyCard = 4
                GameSceneViewController.milliseconds = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
            case "1.3":
                NumberModel.howManyCard = 5
                GameSceneViewController.milliseconds = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
            case "1.4":
                NumberModel.howManyCard = 6
                GameSceneViewController.milliseconds = 5 * 1000
                GameSceneViewController.gameDurationSecond = 7 * 1000
            case "1.5":
                NumberModel.howManyCard = 7
                GameSceneViewController.milliseconds = 5 * 1000
                GameSceneViewController.gameDurationSecond = 7 * 1000
            case "1.6":
                NumberModel.howManyCard = 8
                GameSceneViewController.milliseconds = 5 * 1000
                GameSceneViewController.gameDurationSecond = 10 * 1000
            case "1.7":
                NumberModel.howManyCard = 9
                GameSceneViewController.milliseconds = 10 * 1000
                GameSceneViewController.gameDurationSecond = 15 * 1000
            case "1.8":
                NumberModel.howManyCard = 10
                GameSceneViewController.milliseconds = 10 * 1000
                GameSceneViewController.gameDurationSecond = 20 * 1000
            case "1.9":
                NumberModel.howManyCard = 5
                GameSceneViewController.milliseconds = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = true
            case "1.10":
                NumberModel.howManyCard = 6
                GameSceneViewController.milliseconds = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = true
            case "1.11":
                NumberModel.howManyCard = 7
                GameSceneViewController.milliseconds = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = true
            case "1.12":
                NumberModel.howManyCard = 8
                GameSceneViewController.milliseconds = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
                LevelsVC.blackScreen = true
            case "1.13":
                NumberModel.howManyCard = 3
                GameSceneViewController.milliseconds = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
            case "1.14":
                NumberModel.howManyCard = 4
                GameSceneViewController.milliseconds = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
            case "1.15":
                NumberModel.howManyCard = 5
                GameSceneViewController.milliseconds = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
            case "1.16":
                NumberModel.howManyCard = 6
                GameSceneViewController.milliseconds = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
            case "1.17":
                NumberModel.howManyCard = 3
                GameSceneViewController.milliseconds = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
            case "1.18":
                NumberModel.howManyCard = 4
                GameSceneViewController.milliseconds = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
            case "1.19":
                NumberModel.howManyCard = 5
                GameSceneViewController.milliseconds = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
            case "1.20":
                NumberModel.howManyCard = 6
                GameSceneViewController.milliseconds = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
            case "1.21":
                NumberModel.howManyCard = 3
                GameSceneViewController.milliseconds = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
            case "1.22":
                NumberModel.howManyCard = 4
                GameSceneViewController.milliseconds = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
            case "1.23":
                NumberModel.howManyCard = 5
                GameSceneViewController.milliseconds = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
            case "1.24":
                NumberModel.howManyCard = 6
                GameSceneViewController.milliseconds = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
            case "1.25":
                NumberModel.howManyCard = 3
                GameSceneViewController.milliseconds = 5 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
            case "1.26":
                NumberModel.howManyCard = 4
                GameSceneViewController.milliseconds = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
            case "1.27":
                NumberModel.howManyCard = 5
                GameSceneViewController.milliseconds = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000
            case "1.28":
                NumberModel.howManyCard = 6
                GameSceneViewController.milliseconds = 10 * 1000
                GameSceneViewController.gameDurationSecond = 5 * 1000

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
