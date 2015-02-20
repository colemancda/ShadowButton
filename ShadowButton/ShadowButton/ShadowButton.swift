//
//  ShadowButton.swift
//  ShadowButton
//
//  Created by Alsey Coleman Miller on 2/19/15.
//  Copyright (c) 2015 ColemanCDA. All rights reserved.
//

import Foundation
import UXKit
import QuartzCore
import CoreGraphics

@IBDesignable public class ShadowButton: UXButton {
    
    // MARK: - Properties
    
    @IBInspectable public var cornerRadius: CGFloat = 8 {
        
        didSet {
            
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable public var shadowColor: UXColor = UXColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1.000) {
        
        didSet {
            
            self.setNeedsDisplay()
        }
    }
    
    
    @IBInspectable public var buttonColor: UXColor = UXColor(red: 0.282, green: 0.282, blue: 0.282, alpha: 1.000) {
        
        didSet {
            
            self.setNeedsDisplay()
        }
    }
    
    // MARK: - Methods
    
    public override func drawRect(rect: CGRect) {
        
        self.drawShadowButton(frame: self.bounds, cornerRadius: self.cornerRadius)
    }
    
    private func drawShadowButton(#frame: CGRect, cornerRadius: CGFloat) {
        
        //// General Declarations
        let context = UXGraphicsGetCurrentContext()
        
        //// Shadow Declarations
        let shadowButtonShadow = shadowColor
        let shadowButtonShadowOffset = CGSizeMake(0.1, 3.1)
        let shadowButtonShadowBlurRadius: CGFloat = 0
        
        //// Rectangle Drawing
        let rectanglePath = UXBezierPath(roundedRect: CGRectMake(0, 0, frame.size.width, frame.size.height - shadowButtonShadowOffset.height), cornerRadius: cornerRadius)
        CGContextSaveGState(context)
        CGContextSetShadowWithColor(context, shadowButtonShadowOffset, shadowButtonShadowBlurRadius, (shadowButtonShadow as UXColor).CGColor)
        buttonColor.setFill()
        rectanglePath.fill()
        CGContextRestoreGState(context)
    }

}
