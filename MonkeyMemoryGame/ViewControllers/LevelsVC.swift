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
        print("sk")
    }
    
}
