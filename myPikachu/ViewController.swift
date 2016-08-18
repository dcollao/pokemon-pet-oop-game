//
//  ViewController.swift
//  myPikachu
//
//  Created by Diego  Collao on 16-08-16.
//  Copyright © 2016 Undisclosure. All rights reserved.
//

import UIKit
//Import audio player
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var foodImg: DragImage!
    @IBOutlet weak var heartImg: DragImage!
    @IBOutlet weak var penalty1Img: UIImageView!
    @IBOutlet weak var penalty2Img: UIImageView!
    @IBOutlet weak var penalty3Img: UIImageView!

    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: NSTimer!
    var monsterHappy  = false
    var currentItem: UInt32 = 0
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA

      

        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        
        
        do{
            let resourcePath = NSBundle.mainBundle().pathForResource("background-music", ofType: "mp3")
            let url = NSURL(fileURLWithPath: resourcePath!)
            try musicPlayer = AVAudioPlayer(contentsOfURL: url)
            
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("moltres", ofType: "mp3")!))
            
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxSkull.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxBite.prepareToPlay()
            sfxDeath.prepareToPlay()
            
            
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
        startTimer()
        
    }
    
        func itemDroppedOnCharacter(notif: AnyObject){
            monsterHappy = true
            startTimer()
            
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
            
            if currentItem == 0 {
                sfxHeart.play()
            } else {
                sfxBite.play()
            }
        }
        
        
        func startTimer(){
            if timer != nil {
                timer.invalidate()
            }
            
            timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector:#selector(ViewController.changeGameState),userInfo: nil, repeats: true)
        }
        
        func changeGameState() {
            
            if !monsterHappy{
                penalties += 1
                sfxSkull.play()
                
                if penalties == 1 {
                    penalty1Img.alpha = OPAQUE
                    penalty2Img.alpha = DIM_ALPHA
                } else if penalties == 2 {
                    penalty2Img.alpha = OPAQUE
                    penalty3Img.alpha = DIM_ALPHA
                } else if penalties >= 3{
                    penalty3Img.alpha = OPAQUE
                } else {
                    penalty1Img.alpha = DIM_ALPHA
                    penalty2Img.alpha = DIM_ALPHA
                    penalty3Img.alpha = DIM_ALPHA
                }
                
                if penalties >= MAX_PENALTIES {
                    gameOver()
                }
            }
            
            let rand = arc4random_uniform(2) // 0 or 1
            
            if rand == 0 {
                foodImg.alpha = DIM_ALPHA
                foodImg.userInteractionEnabled = false
                heartImg.alpha = OPAQUE
                heartImg.userInteractionEnabled = true
            } else {
                heartImg.alpha = DIM_ALPHA
                heartImg.userInteractionEnabled = false
                foodImg.alpha = OPAQUE
                foodImg.userInteractionEnabled = true
            }
            
            currentItem = rand
            monsterHappy = false
   
        }
        
        func gameOver(){
            timer.invalidate()
            sfxDeath.play()
            monsterImg.playDeathAnimation()
            
        }
    }
    

