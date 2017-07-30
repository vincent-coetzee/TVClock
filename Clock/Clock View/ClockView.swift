//
//  ClockView.swift
//  Clock
//
//  Created by Vincent Coetzee on 2017/07/07.
//  Copyright © 2017 Vincent Coetzee. All rights reserved.
//

import UIKit
import QuartzCore

internal class ClockView:UIView,Dependent
    {
    private static let SmallTickRatio:CGFloat = 0.0109649122807018
    private static let BigTickRatio:CGFloat = 0.0657894736842105
    private static let TextRatio:CGFloat = 0.05
    private static let MinimumFontSize:CGFloat = 14
    
    var clockBackgroundColor = UIColor.black
    var clockFaceColor = UIColor.orange
    var secondHandColor = UIColor.orange
    
    let clock:Clock
    
    private let secondHand:SecondHandLayer
    private let minuteHand:MinuteHandLayer
    private let hourHand:HourHandLayer
    private let maskLayer = CAShapeLayer()
    private let dateLayer = CATextLayer()
    private let AMPMLayer = CATextLayer()
    
    internal override init(frame:CGRect)
        {
        clock = Clock(secondsFromGMT: TimeZone.current.secondsFromGMT())
        secondHand = SecondHandLayer(clock:clock)
        minuteHand = MinuteHandLayer(clock:clock)
        hourHand = HourHandLayer(clock:clock)
        super.init(frame:frame)
        configureHands()
        configureMask()
        configureStyle()
        }
    
    internal func configureStyle()
        {
        self.backgroundColor = clockBackgroundColor
        secondHand.handColor = secondHandColor
        }
    
    required init?(coder aDecoder: NSCoder)
        {
        clock = Clock(secondsFromGMT: TimeZone.current.secondsFromGMT())
        secondHand = SecondHandLayer(clock:clock)
        minuteHand = MinuteHandLayer(clock:clock)
        hourHand = HourHandLayer(clock:clock)
        super.init(coder:aDecoder)
        configureFace()
        configureHands()
        configureMask()
        configureStyle()
        }
    
    override var intrinsicContentSize:CGSize
        {
        return(CGSize(width:100,height:100))
        }
    
    func update(aspect: String, with: Any?, sender: Any?)
        {
        if aspect == "hour"
            {
            dateLayer.string = clock.dateString
            AMPMLayer.string = clock.hour < 12 ? "AM" : "PM"
            }
        }
    
    private func configureMask()
        {
        let maskPath = UIBezierPath(ovalIn: self.bounds)
        maskLayer.path = maskPath.cgPath
        maskLayer.fillColor = UIColor.black.cgColor
        self.layer.mask = maskLayer
        }
    
    private func configureHands()
        {
        self.layer.addSublayer(minuteHand)
        self.layer.addSublayer(hourHand)
        self.layer.addSublayer(secondHand)
        self.setNeedsLayout()
        }
    
    private func configureFace()
        {
        self.layer.addSublayer(dateLayer)
        self.layer.addSublayer(AMPMLayer)
        let textSize = max(ClockView.TextRatio*self.bounds.size.height,ClockView.MinimumFontSize)
        dateLayer.foregroundColor = clockFaceColor.cgColor
        AMPMLayer.foregroundColor = clockFaceColor.cgColor
        dateLayer.font = UIFont.boldSystemFont(ofSize:textSize).fontName as CFTypeRef
        dateLayer.fontSize = textSize
        AMPMLayer.font = dateLayer.font
        AMPMLayer.fontSize = dateLayer.fontSize
        AMPMLayer.string = clock.hour < 12 ? "AM" : "PM"
        dateLayer.string = clock.dateString
        }
    
    override func layoutSubviews()
        {
        super.layoutSubviews()
        let innerRect = self.bounds.insetBy(dx:20,dy:20)
        secondHand.transform = CATransform3DIdentity
        secondHand.frame = innerRect
        secondHand.createPath()
        secondHand.updateTransform()
        minuteHand.transform = CATransform3DIdentity
        minuteHand.frame = innerRect
        minuteHand.createPath()
        minuteHand.updateTransform()
        hourHand.transform = CATransform3DIdentity
        hourHand.frame = innerRect
        hourHand.createPath()
        hourHand.updateTransform()
        configureMask()
        let textSize = max(ClockView.TextRatio*self.bounds.size.height,ClockView.MinimumFontSize)
        dateLayer.font = UIFont.boldSystemFont(ofSize:textSize).fontName as CFTypeRef
        AMPMLayer.font = dateLayer.font
        }
    
    override func draw(_ rect:CGRect)
        {
        drawClockFace()
        }
    
    internal func drawClockFace()
        {
        let context = UIGraphicsGetCurrentContext()
        let clockFaceRadius = self.bounds.width / 2.0
        context?.setStrokeColor(clockFaceColor.cgColor)
        let center = self.bounds.center
        let lineWidth:CGFloat = ClockView.SmallTickRatio*self.bounds.width
//        context?.strokeLineSegments(between:[CGPoint(x:center.x,y:0),CGPoint(x:center.x,y:self.bounds.size.height)])
//        context?.strokeLineSegments(between:[CGPoint(x:0,y:center.y),CGPoint(x:self.bounds.size.width,y:center.y)])
        for second in 0..<60
            {
            let degree = CGFloat(second)*6.0
            var lineLength:CGFloat
            if second % 5 == 0
                {
                lineLength = ClockView.BigTickRatio*self.bounds.width
                }
            else
                {
                lineLength = ClockView.SmallTickRatio*self.bounds.width
                }
            let startPoint = PolarPoint(r:clockFaceRadius - lineLength,degrees:CGFloat(degree)).cgPoint + center
            let endPoint = PolarPoint(r:clockFaceRadius,degrees:CGFloat(degree)).cgPoint + center
            context?.setLineWidth(lineWidth)
            context?.strokeLineSegments(between:[startPoint,endPoint])
            }
        }
    }
