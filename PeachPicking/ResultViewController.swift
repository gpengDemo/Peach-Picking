//
//  ResultViewController.swift
//  PeachPicking
//
//  Created by 辜鹏 on 2019/12/17.
//  Copyright © 2019 PengGu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var  score1:[Int] = UserDefaults.standard.array(forKey: "1") as? [Int] ?? [0,0,0]
    var  score2:[Int] = UserDefaults.standard.array(forKey: "2") as? [Int] ?? [0,0,0]
    var  score3:[Int] = UserDefaults.standard.array(forKey: "3") as? [Int] ?? [0,0,0]

    @IBOutlet weak var s1Lb: UILabel!
    @IBOutlet weak var s2Lb: UILabel!
    @IBOutlet weak var s3Lb: UILabel!

    @IBOutlet weak var g1Lb: UILabel!
    @IBOutlet weak var g2Lb: UILabel!
    @IBOutlet weak var g3Lb: UILabel!
    
    @IBOutlet weak var d1Lb: UILabel!
    @IBOutlet weak var d2Lb: UILabel!
    @IBOutlet weak var d3Lb: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        show()
    }
    
    func show()  {
        
        var a = score1.sorted(by: >)
        var b = score2.sorted(by: >)
        var c = score3.sorted(by: >)
        
        s1Lb.text = String(a[0])
        s2Lb.text = String(0)
        s3Lb.text = String(0)
        
        g1Lb.text = String(b[0])
        g2Lb.text = String(0)
        g3Lb.text = String(0)
        
        d1Lb.text = String(c[0])
        d2Lb.text = String(0)
        d3Lb.text = String(0)

    }
    

 
}
