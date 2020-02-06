//
//  GameOverViewController.swift
//  PeachPicking
//
//  Created by 辜鹏 on 2019/12/16.
//  Copyright © 2019 PengGu. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
 
    @IBOutlet weak var scoreLb: UILabel!
    var score:Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLb.text = "\(score!)"
    }
    

    @IBAction func againAction(_ sender: Any) {
        self.dismiss(animated: true) {
            
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "back")))
                        
        }
    }
    

    @IBAction func homeAction(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "home")))
                        
        }
    }
}
