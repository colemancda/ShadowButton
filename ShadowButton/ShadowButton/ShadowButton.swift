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
            
            self.setImage()
        }
    }
    
    @IBInspectable public var shadowColor: UXColor = UXColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1.000) {
        
        didSet {
            
            self.setImage()
        }
    }
    
    @IBInspectable public var buttonColor: UXColor = UXColor(red: 0.282, green: 0.282, blue: 0.282, alpha: 1.000) {
        
        didSet {
            
            self.setImage()
        }
    }
    
    @IBInspectable public var shadowSize: CGFloat = 3 {
        
        didSet {
            
            self.setImage()
        }
    }
    
    // MARK: - Class Methods
    
    public class func drawShadowButton(#frame: CGRect, cornerRadius: CGFloat, buttonColor: UXColor, shadowColor: UXColor, shadowSize: CGFloat) {
        
        //// General Declarations
        let context = UXGraphicsGetCurrentContext()
        
        //// Shadow Declarations
        let shadowButtonShadow = shadowColor
        let shadowButtonShadowOffset = CGSizeMake(0.1, shadowSize + 0.1)
        let shadowButtonShadowBlurRadius: CGFloat = 0
        
        //// Rectangle Drawing
        let rectanglePath = UXBezierPath(roundedRect: CGRectMake(0, 0, frame.size.width, frame.size.height - shadowButtonShadowOffset.height), cornerRadius: cornerRadius)
        CGContextSaveGState(context)
        CGContextSetShadowWithColor(context, shadowButtonShadowOffset, shadowButtonShadowBlurRadius, (shadowButtonShadow as UXColor).CGColor)
        buttonColor.setFill()
        rectanglePath.fill()
        CGContextRestoreGState(context)
    }
    
    public class func imageOfShadowButton(#frame: CGRect, cornerRadius: CGFloat, buttonColor: UXColor, shadowColor: UXColor, shadowSize: CGFloat) -> UXImage {
        
        #if os(iOS)
        
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        
        self.drawShadowButton(frame: frame, cornerRadius: cornerRadius, buttonColor: buttonColor, shadowColor: shadowColor, shadowSize: shadowSize)
        
        let imageOfShadowButton = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return imageOfShadowButton
            
        #elseif os(OSX)
        
        return NSImage(size: frame.size, flipped: false, drawingHandler: { (NSRect) -> Bool in
            
            self.drawShadowButton(frame: frame, cornerRadius: cornerRadius, buttonColor: buttonColor, shadowColor: shadowColor, shadowSize: shadowSize)
            
            return true
        })
            
        #endif
    }
    
    // MARK: - Initialization
    
    public required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.setImage()
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.setImage()
    }
    
    // MARK: - Private Methods
    
    private func setImage() {
        
        let image = self.dynamicType.imageOfShadowButton(frame: self.bounds, cornerRadius: self.cornerRadius, buttonColor: self.buttonColor, shadowColor: self.shadowColor, shadowSize: self.shadowSize)
        
        #if os(iOS)
            self.setBackgroundImage(image, forState: UIControlState.Normal)
        #elseif os(OSX)
            self.image = image
        #endif
    }
}
