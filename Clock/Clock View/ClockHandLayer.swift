//
//  ClockHandLayer.swift
//  Clock
//
//  Created by Vincent Coetzee on 2017/07/07.
//  Copyright © 2017 Vincent Coetzee. All rights reserved.
//

import Foundation
import UIKit

internal class ClockHandLayer:CAShapeLayer,Dependent
    {
    static let LineWidthRatio:CGFloat = 0.0109649122807018
    
    fileprivate let clock:Clock?
    fileprivate var _handColor:CGColor = UIColor.white.cgColor
    
    var handColor:UIColor
        {
        get
            {
            return(UIColor(cgColor:_handColor))
            }
        set
            {
            _handColor = newValue.cgColor
            self.strokeColor = _handColor
            self.fillColor = _handColor
            }
        }
    
    override init(layer:Any)
        {
        self.clock = nil
        super.init(layer:layer)
        }
    
    init(clock:Clock)
        {
        self.clock = clock
        super.init()
        clock.add(dependent:self)
        self.fillColor = _handColor
        self.strokeColor = _handColor
        self.shadowColor = UIColor.darkGray.cgColor
        self.shadowOffset = CGSize(width:3,height:3)
        self.shadowRadius = 4
        self.shadowOpacity = 1.0
        }
    
    required init?(coder aDecoder: NSCoder)
        {
        fatalError("init(coder:) has not been implemented")
        }
    
    func update(aspect:String,with:Any?,sender:Any?)
        {
        }
    
    func updateTransform()
        {
        }
    
    override func layoutSublayers()
        {
        super.layoutSublayers()
        updateTransform()
        }
    }

internal class HourHandLayer:ClockHandLayer
    {
    override func update(aspect:String,with:Any?,sender:Any?)
        {
        if aspect == "hour" || aspect == "minute"
            {
            updateTransform()
            }
        }
    
    func createPath()
        {
        let clockHand = ClockHand(at:self.bounds.center,layerWidth:self.bounds.width,handType:.hour)
        self.path = clockHand.cgPath
        self.lineWidth = ClockHandLayer.LineWidthRatio * self.bounds.width
        }
    
    override func updateTransform()
        {
        if let hour = clock?.hour,let minute = clock?.minute
            {
            let degrees = (CGFloat(hour % 12) + CGFloat(minute)/60.0)*30.0
            let radians = degrees*CGFloat.pi/180.0
            self.transform = CATransform3DMakeRotation(radians,0,0,1)
            }
        }
    }

internal class MinuteHandLayer:ClockHandLayer
    {
    private static let MinuteHandLength:Double = 0.9
    
    override func update(aspect:String,with:Any?,sender:Any?)
        {
        if aspect == "minute" || aspect == "second"
            {
            updateTransform()
            }
        }
    
    func createPath()
        {
        let clockHand = ClockHand(at:self.bounds.center,layerWidth:self.bounds.width,handType:.minute)
        self.path = clockHand.cgPath
        self.lineWidth = ClockHandLayer.LineWidthRatio * self.bounds.width
        }
    
    override func updateTransform()
        {
        if let minute = clock?.minute,let second = clock?.second
            {
            let degrees = (CGFloat(minute) + CGFloat(second)/60.0)*6.0
            let radians = degrees*CGFloat.pi/180.0
            self.transform = CATransform3DMakeRotation(radians,0,0,1)
            }
        }
    }

internal class SecondHandLayer:ClockHandLayer
    {
    override func update(aspect:String,with:Any?,sender:Any?)
        {
        if aspect == "second"
            {
            updateTransform()
            }
        }
    
    func createPath()
        {
        let extraLength = self.bounds.size.width * 0.087719298245614
        let lineWidth = self.bounds.size.width * 0.00548245614035088
        let center = self.bounds.center + (0,extraLength)
        let path = UIBezierPath()
        path.move(to:center)
        path.addLine(to:center + (0,-center.y))
        self.path = path.cgPath
        self.lineWidth = max(lineWidth,1)
        }
    
    override func updateTransform()
        {
        if let second = clock?.second
            {
            let degrees = CGFloat(second)*6.0
            let radians = degrees*CGFloat.pi/180.0
            self.transform = CATransform3DMakeRotation(radians,0,0,1)
            }
        }
    }
