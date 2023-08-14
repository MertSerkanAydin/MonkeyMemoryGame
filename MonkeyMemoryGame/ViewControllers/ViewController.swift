//
//  ViewController.swift
//  MonkeyMemoryGame
//
//  Created by Mert Serkan Aydın on 7.08.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startButton(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "gameVC") as? GameSceneViewController {

            self.present(vc, animated: true)
            
            navigationController?.popViewController(animated: true)
//            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
}

