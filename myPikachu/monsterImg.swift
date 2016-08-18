//
//  monsterImg.swift
//  myPikachu
//
//  Created by Diego  Collao on 17-08-16.
//  Copyright © 2016 Undisclosure. All rights reserved.
//

import Foundation
import UIKit

class MonsterImg: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation()
    }
    
    func playIdleAnimation(){
        self.image = UIImage(named: "live0.png")
        
        self.animationImages = nil
        
        var imageArray = [UIImage]()
        
        for x in 0...118{
            let img = UIImage(named: "live\(x).png")
            imageArray.append(img!)
        }
        
        self.animationImages = imageArray
        self.animationDuration = 3
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func playDeathAnimation() {
        
        self.image = UIImage(named:"death096.png")
        
        self.animationImages = nil
        
        var imageArray = [UIImage]()
        
        for x in 0...118{
            let img = UIImage(named: "death\(x).png")
            imageArray.append(img!)
        }
        
        self.animationImages = imageArray
        self.animationDuration = 3
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    

}