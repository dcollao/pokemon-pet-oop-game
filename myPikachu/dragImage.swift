//
//  dragImage.swift
//  myPikachu
//
//  Created by Diego  Collao on 17-08-16.
//  Copyright © 2016 Undisclosure. All rights reserved.
//

import Foundation
import UIKit

//My own dragImage :P!
class DragImage: UIImageView {
    
    var originalPosition: CGPoint!
    var dropTarget: UIView?
    
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            originalPosition = self.center
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //i'm grabbing a object
        if let touch = touches.first {
            //tracking the touch
            let position = touch.locationInView(self.superview)
            self.center = CGPointMake(position.x, position.y)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first, let target = dropTarget{
            
            let position = touch.locationInView(self.superview)
            
            if CGRectContainsPoint(target.frame, position){
                
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "onTargetDropped", object: nil))
            }
        }
        
        self.center = originalPosition
        
    }
}