//
//  LevelsCollectionViewCell.swift
//  MonkeyMemoryGame
//
//  Created by Mert Serkan Aydın on 14.08.2023.
//

import UIKit

class LevelsCollectionViewCell: UICollectionViewCell {
    
    var levelNumber: LevelNumber?
    
    //    set identifier to cell
    static let identifier = "LevelsCollectionViewCell"
    
    //    create image view
    private let LevelNumberimageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
        
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        contentView.addSubview(LevelNumberimageView)
        
        //        Contentview bounds equal to view
        contentView.clipsToBounds = true
        
    }
    
    required init(coder: NSCoder) {
        
        fatalError()
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        LevelNumberimageView.frame = contentView.bounds
        
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        LevelNumberimageView.image = nil
        
    }
    
    func setLevelNumber(_ number: LevelNumber) {
        
        //        Keep track of the card that gets passed in
        self.levelNumber = number
        
        LevelNumberimageView.image = UIImage(named: number.imageName)
        
    }
    
}
