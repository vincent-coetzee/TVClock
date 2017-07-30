//
//  ClockHand.swift
//  Clock
//
//  Created by Vincent Coetzee on 2017/07/25.
//  Copyright © 2017 Vincent Coetzee. All rights reserved.
//

import UIKit

struct ClockHand
    {
    enum HandType
        {
        case hour
        case minute
        }
    
    private static let CenterRadiusRatio:CGFloat = 0.0109649122807018
    private static let HourHandLengthRatio:CGFloat = 0.31140350877193
    private static let MinuteHandLengthRatio:CGFloat = 0.478070175438596
    private static let ThinBitRatio:CGFloat = 0.0657894736842105

    private let centerRadius:CGFloat
    private let thinBitLength:CGFloat
    private let totalLength:CGFloat
    private let center:CGPoint
    
    public var cgPath:CGPath
        {
        return(bezierPath().cgPath)
        }
    
    init(at:CGPoint,layerWidth:CGFloat,handType:HandType)
        {
        self.centerRadius = ClockHand.CenterRadiusRatio*layerWidth
        self.thinBitLength = ClockHand.ThinBitRatio*layerWidth
        var length:CGFloat
        if handType == .hour
            {
             length = ClockHand.HourHandLengthRatio*layerWidth
            }
        else
            {
            length = ClockHand.MinuteHandLengthRatio*layerWidth
            }
        self.totalLength = length - thinBitLength
        center = at + (centerRadius,centerRadius)
        }
    
    public func cgPathRotatedBy(degrees:CGFloat) -> CGPath
        {
        let path = bezierPath()
        let transform = CGAffineTransform(rotationAngle:degrees/180.0*CGFloat.pi)
        path.apply(transform)
        return(path.cgPath)
        }
    
    private func bezierPath() -> UIBezierPath
        {
        let path = UIBezierPath()
        var point = center
        point.x -= centerRadius
        point.y -= centerRadius
        path.addArc(withCenter:point,radius:centerRadius,startAngle:CGFloat.pi/2.0,endAngle:3.0*CGFloat.pi/2.0,clockwise:true)
        point.y -= centerRadius + thinBitLength
        path.addLine(to:point)
        point.y -= centerRadius
        path.addArc(withCenter:point,radius:centerRadius,startAngle:CGFloat.pi/2.0,endAngle:CGFloat.pi,clockwise:true)
        let length = totalLength - (3*centerRadius + thinBitLength)
        point.y -= length
        point.x -= centerRadius
        path.addLine(to:point)
        point.x += centerRadius
        path.addArc(withCenter:point,radius:centerRadius,startAngle:CGFloat.pi,endAngle:CGFloat.pi*2.0,clockwise:true)
        point.x += centerRadius
        point.y += length
        path.addLine(to:point)
        point.x -= centerRadius
        path.addArc(withCenter:point,radius:centerRadius,startAngle:0,endAngle:CGFloat.pi/2.0,clockwise:true)
        point.y += (centerRadius + thinBitLength)
        path.move(to:point)
        point.y += centerRadius
        path.addArc(withCenter:point,radius:centerRadius,startAngle:3.0*CGFloat.pi/2.0,endAngle:CGFloat.pi/2.0,clockwise:true)
        return(path)
        }
    }
