//
//  GameViewController.swift
//  PeachPicking
//
//  Created by 辜鹏 on 2019/12/16.
//  Copyright © 2019 PengGu. All rights reserved.
//

import UIKit
import AVFoundation
class GameViewController: UIViewController {

    var passedType:String?
    
    var problemText = ""
    var answer = 0
    var dict:[Int:String] = [Int:String]()
    
    var hiddenArr:[Int] = [Int]()
    @IBOutlet weak var problemLb: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var indexArr = [0,1,2,3,4,5]
    var index = 0
    var player1: AVAudioPlayer?
    var player2: AVAudioPlayer?
    var timer = 60
    var clock:Timer?
    var score = 0
    

    @IBOutlet weak var scoreLb: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        initdata()
        hiddenItem()
        showRandomProblem()
        NotificationCenter.default.addObserver(self, selector: #selector(backAction), name: NSNotification.Name(rawValue: "back"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(homeAction), name: NSNotification.Name(rawValue: "home"), object: nil)
        
        gameStart()
        startTimer()
    }
    
    
    func startTimer(){
        clock = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)

    }
    
    @objc func countdown() {
          
          timer = timer - 1
          self.title = String(timer) + "s"
          
          if timer <= 0  {
              
              clock?.invalidate()
              
            var  score_arr:[Int] = UserDefaults.standard.array(forKey:passedType!) as? [Int] ?? []
              score_arr.append(score)
            UserDefaults.standard.set(score_arr, forKey: passedType!)
              
              let  coverVc:GameOverViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameOverViewController") as! GameOverViewController
              
              coverVc.modalPresentationStyle = .overCurrentContext
              coverVc.modalTransitionStyle = .coverVertical
              
              coverVc.score = score
              self.present(coverVc, animated: true, completion: nil)
          }
          
          
      }
    
    
    func gameStart()  {
        let gameVc:GameStarterViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameStarterViewController") as! GameStarterViewController
        
        gameVc.modalPresentationStyle = .overCurrentContext
        gameVc.modalTransitionStyle = .coverVertical
        
        self.present(gameVc, animated: true, completion: nil)
    }
    
    @objc func backAction()  {
        startTimer()
        score = 0
        scoreLb.text = String(score)
        timer = 61
        hiddenArr.removeAll()
        dict.removeAll()
        problemText = ""
        answer = 0
        index = 0
        indexArr = [0,1,2,3,4,5]
        restartProblem()
        collectionView.reloadData()
    }
    
    @objc func homeAction()  {
        
        navigationController?.popToRootViewController(animated: true)
        
        
    }
    
    func restartProblem()  {
        timer = timer + 30
        indexArr = [0,1,2,3,4,5]
        initdata()
        hiddenItem()
        showRandomProblem()
        self.view.layoutIfNeeded()
        self.view.layoutSubviews()
        
    }
    
    
    func showRandomProblem()  {
        
        let a = Int.random(in: 0...5)
        problemLb.text = String(Array(dict.values)[a])
        indexArr.remove(at: a)
        
    }
    
    func refreshRandomProblem()  {
        
        let b = indexArr.randomElement()
        problemLb.text = String(Array(dict.values)[b!])
        
        if let index = indexArr.firstIndex(of: b!) {
            indexArr.remove(at: index)
        }
        self.view.layoutIfNeeded()
        self.view.layoutSubviews()

    }
    
    
    
    
    // hidden  item
    func hiddenItem()  {
       
        // 5 * 4
        
        var a = [0,1,2,3,4]
        a.shuffle()
        var b = [5,6,7,8,9]
        b.shuffle()
        var c = [10,11,12,13,14]
        c.shuffle()
        var d = [15,16,17,18,19]
        d.shuffle()
        
        
        hiddenArr = [a[0],b[0],b[1],c[0],d[0],d[1]]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            
            for (i,item) in self.hiddenArr.enumerated() {
                
                let cell:GameCell = self.collectionView.cellForItem(at: IndexPath(item: item, section: 0)) as! GameCell
                
                cell.peachLb.text = String(Array(self.dict.keys)[i])
                cell.picImgView.image = UIImage(named: "peach")
            }
            
        }
        

        
 
    
    }
    
    
    
    func initdata()  {
        
        for _ in  0...100 {
            switch passedType {
            case "1":
                simple()
            case "2":
                general()
            case "3":
                difficult()
            default:
                print("error ...")
            }
        }
            
    }
    
    
    
    
    // 20 plus or mlus
    func simple()  {
        
        let randomPlusOrSub = Int.random(in: 0...1)
        let a = Int.random(in: 1...9)
        let b = Int.random(in: 1...5)
        let c = Int.random(in: 11...15)

        switch randomPlusOrSub {
        case 0:
            // plus
            problemText =  "\(a) + \(b)"
            answer = a + b
            
            dict[answer] = problemText
        case 1:
            // sub
            problemText =  "\(c) - \(b)"
            answer = c - b
            
            dict[answer] = problemText

        default:
            print(" error ... ")
        }
        
    }
    func general()  {
        
        let randomPlusOrSub = Int.random(in: 0...1)
        let c = Int.random(in: 50...75)
        let a = Int.random(in: 1...25)
        let b = Int.random(in: 1...25)
        
        switch randomPlusOrSub {
        case 0:
            // plus
            problemText =  "\(a) + \(b)"
            answer = a + b
            
            dict[answer] = problemText

        case 1:
            // sub
            problemText =  "\(c) - \(b)"
            answer = c - b
            
            dict[answer] = problemText


        default:
            print(" error ... ")
        }
        
    }
    
    func difficult()  {
        
        let randomPlusOrSub = Int.random(in: 0...1)
        let c = Int.random(in: 75...100)
        let a = Int.random(in: 1...50)
        let b = Int.random(in: 1...50)
        
        switch randomPlusOrSub {
        case 0:
            // plus
            problemText =  "\(a) + \(b)"
            answer = a + b
            
            dict[answer] = problemText


        case 1:
            // sub
            problemText =  "\(c) - \(b)"
            answer = c - b
            
            dict[answer] = problemText

        default:
            print(" error ... ")
        }
        
    }
    
    
    
    
    
    func setupUI() {
          
          
          collectionView.dataSource = self
          collectionView.delegate = self
          
          
          let layout = UICollectionViewFlowLayout()
          
          layout.itemSize = CGSize(width: contentWidth / 5 - 5  , height: contentHeight / 4 - 5 )
          
          layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
          layout.minimumInteritemSpacing  = 0
          layout.minimumLineSpacing = 0
          
          layout.scrollDirection = .vertical
          
          collectionView.collectionViewLayout = layout
          
      }
    
    func playSuccessSound() {
        let url = Bundle.main.url(forResource: "success", withExtension: "mp3")!
        
        do {
            player1 = try AVAudioPlayer(contentsOf: url)
            guard let player = player1 else { return }
            
            player.prepareToPlay()
            player.play()
            
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func playErrorSound() {
        let url = Bundle.main.url(forResource: "error", withExtension: "mp3")!
        
        do {
            player2 = try AVAudioPlayer(contentsOf: url)
            guard let player = player2 else { return }
            
            player.prepareToPlay()
            player.play()
            
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    
    
}

extension GameViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let game:GameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
        
        if hiddenArr.contains(indexPath.row) {
            game.picImgView.image = UIImage(named: "peach")
            
            // answer  add to  hiddenArr
            
            game.contentView.isUserInteractionEnabled = true

        }else {
            game.picImgView.image = nil
            game.peachLb.text = ""
            game.contentView.isUserInteractionEnabled = false

        }
        
        return game
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell:GameCell = collectionView.cellForItem(at: indexPath) as! GameCell
        
        // click show peach item
        if hiddenArr.contains(indexPath.row) {
            
                
            // get the  click dict key
            let rowIndex = hiddenArr.firstIndex(of: indexPath.row)
            let dictKey = Array(dict.keys)[rowIndex!]
            
            if dict[dictKey] == problemLb.text {
                
                print("succes  refresh ...")
                
                playSuccessSound()
                score = score + 1
                scoreLb.text = String(score)
                
                // hide current pic and label
                cell.picImgView.image = nil
                cell.peachLb.text = ""
                index = index + 1
                
                if index == 6 {
                    
                    index = 0
                    
                    // restart the game
                    restartProblem()
                
                }else {
                    refreshRandomProblem()
                }
                
                
                
            }else{
                playErrorSound()
                print("jump the error page ...")
                timer = timer - 5
                
//                clock?.invalidate()
//
//                var  score_arr:[Int] = UserDefaults.standard.array(forKey:passedType!) as? [Int] ?? []
//                score_arr.append(score)
//                UserDefaults.standard.set(score_arr, forKey: passedType!)
//
//
//                let overVc:GameOverViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameOverViewController") as! GameOverViewController
//
//                overVc.modalPresentationStyle = .overCurrentContext
//                overVc.modalTransitionStyle = .coverVertical
//
//                self.present(overVc, animated: true, completion: nil)
                
            }
            
            
            
            
            
        }else{
            
            
            cell.contentView.isUserInteractionEnabled = false

        }
    }
    
    
    
    
    
}
