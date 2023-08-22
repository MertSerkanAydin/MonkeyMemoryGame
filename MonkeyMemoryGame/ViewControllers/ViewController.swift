//
//  ViewController.swift
//  MonkeyMemoryGame
//
//  Created by Mert Serkan Aydın on 7.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "viewBackground.png")!)
        //        self.view.backgroundColor = UIColor.black
        
        let startButtonW = self.view.frame.width / 2
        let startButtonH = self.view.frame.height / 6
        
        //        Set startButton
        startButton = UIButton(frame: CGRect(x: (self.view.frame.width / 2) - (startButtonW / 2),
                                             y: (self.view.frame.height / 2) - (startButtonH / 2),
                                             width: startButtonW,
                                             height: startButtonH))
        startButton.addTarget(self, action: #selector(goToLevelMenu), for: .touchUpInside)
        startButton.setImage(UIImage(named: "playButton"), for: .normal)
        startButton.layer.masksToBounds = true
        startButton.layer.cornerRadius = 35
        view.addSubview(startButton)
        
    }
    
    @objc func goToLevelMenu() {
        
        //        Going LevelsVC
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Levels") as? LevelsVC {
            
            self.present(vc, animated: true)
            
            navigationController?.popViewController(animated: true)
            
        }
        
    }
    
}
