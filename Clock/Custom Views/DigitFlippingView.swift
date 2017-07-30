//
//  NumberFlippingView.swift
//  Clock
//
//  Created by Vincent Coetzee on 2017/07/30.
//  Copyright © 2017 Vincent Coetzee. All rights reserved.
//

import UIKit

internal class DigitFlippingView:UIView
    {
    internal enum Digit:Int
        {
        case zero = 0
        case one = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
        case six = 6
        case seven = 7
        case eight = 8
        case nine = 9
    
        public var textDigit:String
            {
            return("\(self.rawValue % 10)")
            }
        
        public func imageDigit(inRect rect:CGRect,withAttributes attributes:[NSAttributedStringKey : Any]) -> UIImage
            {
            let holder = CALayer()
            holder.frame = rect
            let size = self.textDigit.size(withAttributes:attributes)
            let textLayer = CATextLayer()
            holder.addSublayer(textLayer)
            textLayer.alignmentMode = kCAAlignmentCenter
            textLayer.frame = CGRect(x:(rect.size.width - size.width)/2.0,y:(rect.size.height - size.height)/2.0,width:size.width,height:size.height)
            textLayer.string = self.textDigit
            let font = attributes[NSAttributedStringKey.font]! as! UIFont
            textLayer.font = font.fontName as CFTypeRef
            textLayer.fontSize = font.pointSize
            textLayer.backgroundColor = (attributes[NSAttributedStringKey.backgroundColor]! as! UIColor).cgColor
            textLayer.foregroundColor = (attributes[NSAttributedStringKey.foregroundColor]! as! UIColor).cgColor
            let renderer = UIGraphicsImageRenderer(size:rect.size)
            let image = renderer.image
                {
                context in
                return(holder.render(in:context.cgContext))
                }
            return(image)
            }
        }
    
    private var _currentDigit:Digit = .zero
    private var _nextDigit:Digit = .zero
    private var _container = CALayer()
    private var _nextContainer = CALayer()
    
    public var style = Style(name:"default")
    
    public var digit:Digit
        {
        get
            {
            return(_currentDigit)
            }
        set
            {
            _nextDigit = newValue
            startDigitAnimation()
            }
        }
    
    override init(frame:CGRect)
        {
        super.init(frame:frame)
        initStyle()
        initLayers()
        setNeedsLayout()
        }
    
    required init?(coder aDecoder: NSCoder)
        {
        super.init(coder:aDecoder)
        initStyle()
        initLayers()
        setNeedsLayout()
        }
    
    private func initStyle()
        {
        style.foregroundColor = UIColor.orange
        let height = self.bounds.size.height - 10
        style.font = UIFont(name: style.font.fontName,size:height) ?? UIFont.boldSystemFont(ofSize: height)
        self.backgroundColor = style.backgroundColor
        self.layer.cornerRadius = style.cornerRadius
        self.layer.borderWidth = style.borderWidth
        self.layer.borderColor = style.borderColor.cgColor
        }
    
    private func initLayers()
        {
        _container = createTextLayer(for:_currentDigit,color:UIColor.orange)
        self.layer.addSublayer(_container)
        }
    
    override func layoutSubviews()
        {
        super.layoutSubviews()
        _container.frame = self.bounds
        }
    
    private func createTextLayer(for digit:Digit,color:UIColor) -> CALayer
        {
        let holder = CALayer()
        holder.isDoubleSided = false
        holder.frame = self.bounds
        let textLayer = CATextLayer()
        textLayer.isDoubleSided = false
        textLayer.string = digit.textDigit
        textLayer.apply(style:style)
        textLayer.foregroundColor = color.cgColor
        textLayer.frame = self.bounds.rectWithCenteredSize(style.size(of: digit.textDigit))
        holder.addSublayer(textLayer)
        return(holder)
        }
    
    private func startDigitAnimation()
        {
        let duration:CFTimeInterval = 5
        let newContainer = createTextLayer(for:_nextDigit,color:UIColor.red)
        self.layer.addSublayer(newContainer)
        _container.anchorPoint = CGPoint(x:0.5,y:0.5)
        let outAnimation = CABasicAnimation(keyPath: "transform")
        outAnimation.duration = duration
        outAnimation.fromValue = CATransform3DIdentity
        outAnimation.toValue = CATransform3DMakeRotation(CGFloat.pi,1,0,0)
        outAnimation.isRemovedOnCompletion = true
        outAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        outAnimation.fillMode = kCAFillModeBoth
        _container.add(outAnimation,forKey:"transform")
        _container.transform = CATransform3DMakeRotation(CGFloat.pi,1,0,0)
        newContainer.anchorPoint = CGPoint(x:0.5,y:0.5)
        let inAnimation = CABasicAnimation(keyPath:"transform")
        inAnimation.duration = duration
        inAnimation.fromValue = CATransform3DMakeRotation(CGFloat.pi,1,0,0)
        inAnimation.toValue = CATransform3DIdentity
        inAnimation.isRemovedOnCompletion = true
        inAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        inAnimation.fillMode = kCAFillModeBoth
        newContainer.add(inAnimation,forKey:"transform")
        newContainer.transform = CATransform3DIdentity
        inAnimation.delegate = self
        _currentDigit = _nextDigit
        _nextContainer = newContainer
        }
    }

extension DigitFlippingView:CAAnimationDelegate
    {
    func animationDidStop(_ animation:CAAnimation,finished:Bool)
        {
        _container.removeFromSuperlayer()
        _container = _nextContainer
        }
    }
