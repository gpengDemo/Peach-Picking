//
//  ViewController.swift
//  PeachPicking
//
//  Created by 辜鹏 on 2019/12/9.
//  Copyright © 2019 PengGu. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        playbgSound()
    }
    
    func setupUI()  {
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

    }
    
    func playbgSound() {
        let url = Bundle.main.url(forResource: "bg", withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
            player.numberOfLoops = -1
            
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    
    @IBAction func simpleAction(_ sender: Any) {
        
        let gameVc:GameViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        
        gameVc.passedType = "1"
        navigationController?.pushViewController(gameVc, animated: true)
    }
    
    @IBAction func generalAction(_ sender: Any) {
        
        let gameVc:GameViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        
        gameVc.passedType = "2"
        navigationController?.pushViewController(gameVc, animated: true)
        
    }
    @IBAction func complexAction(_ sender: Any) {
        
        let gameVc:GameViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        
        gameVc.passedType = "3"
        navigationController?.pushViewController(gameVc, animated: true)
        
    }
    

}

