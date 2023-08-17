//
//  ViewController.swift
//  MonkeyMemoryGame
//
//  Created by Mert Serkan Aydın on 7.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.layer.position.x = self.view.frame.width / 2
        startButton.layer.position.y = self.view.frame.height / 2
        
    }
    
    @IBAction func startButton(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Levels") as? LevelsVC {
            
            self.present(vc, animated: true)
            
            navigationController?.popViewController(animated: true)
            //            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
}
