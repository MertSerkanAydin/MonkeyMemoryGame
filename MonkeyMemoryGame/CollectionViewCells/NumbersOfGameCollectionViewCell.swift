//
//  NumbersOfGameCollectionViewCell.swift
//  MonkeyMemoryGame
//
//  Created by Mert Serkan Aydın on 9.08.2023.
//

import UIKit

class NumbersOfGameCollectionViewCell: UICollectionViewCell {
    
    var number: Number?
    
    //    set identifier to cell
    static let identifier = "NumberCell"
    
    //    create frontImageView view
    private let frontImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
        
    }()
    
    //    Create backImageView
    private let backImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
        
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        contentView.addSubview(backImageView)
        contentView.addSubview(frontImageView)
        
        //        Contentview bounds equal to view
        contentView.clipsToBounds = true
        
    }
    
    required init(coder: NSCoder) {
        
        fatalError()
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        //        Imageviews bounds confined to contentViews
        frontImageView.frame = contentView.bounds
        backImageView.frame = contentView.bounds
        
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        frontImageView.image = nil
        backImageView.image = nil
        
    }
    
    func setNumber(_ number: Number) {
        
        //        Keep track of the card that gets passed in
        self.number = number
        
        // Set the images
        backImageView.image = UIImage(named: "numberBackground")
        
        frontImageView.image = UIImage(named: number.imageName)
        
    }
    
    func flip() {
        
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
    }
    
    func flipBack(delayTime: Double, transitionDuration: Double) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayTime) {
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: transitionDuration, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            
        }
    }
    
    func remove() {
        
        //        Removes both imageviews from being visible
        backImageView.alpha = 0
        
        //        Animate it
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            
            self.frontImageView.alpha = 0
            
        }, completion: nil)
    }
    
}
