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
    private var _topHalf = CALayer()
    private var _bottomHalf = CALayer()
    private var _font = UIFont.boldSystemFont(ofSize:20)
    private var _borderColor = UIColor.white
    private var _textColor = UIColor.white
    private var _fontSize:CGFloat = 20
    private var _transformLayer = CATransformLayer()
    private var _borderWidth:CGFloat = 5
    private var _cornerRadius:CGFloat = 10
    private var _container = CALayer()
    private var _nextLayers:(CALayer,CALayer,CALayer)?
    
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
    
    public var font:UIFont
        {
        get
            {
            return(_font)
            }
        set
            {
            _font = newValue
            updateBitmaps()
            }
        }
    
    public var fontSize:CGFloat
        {
        get
            {
            return(_fontSize)
            }
        set
            {
            _fontSize = newValue
            updateBitmaps()
            }
        }
    
    public var borderWidth:CGFloat
        {
        get
            {
            return(_borderWidth)
            }
        set
            {
            _borderWidth = newValue
            updateColors()
            }
        }
    
    override init(frame:CGRect)
        {
        super.init(frame:frame)
        backgroundColor = UIColor.black
        initLayers()
        setNeedsLayout()
        }
    
    required init?(coder aDecoder: NSCoder)
        {
        super.init(coder:aDecoder)
        backgroundColor = UIColor.black
        initLayers()
        setNeedsLayout()
        backgroundColor = UIColor.black
        }
    
    private func initLayers()
        {
        _container.isDoubleSided = false
        _container.addSublayer(_topHalf)
        _container.addSublayer(_bottomHalf)
        self.layer.addSublayer(_container)
        self.layer.cornerRadius = _cornerRadius
        guessFontSize()
        updateColors()
        updateBitmaps()
        }
    
    private func updateBitmaps()
        {
        let attributes:[NSAttributedStringKey : Any] = [NSAttributedStringKey.font:_font,NSAttributedStringKey.foregroundColor:_textColor,NSAttributedStringKey.backgroundColor:self.backgroundColor!]
        let image = _currentDigit.imageDigit(inRect:self.bounds,withAttributes:attributes)
        _topHalf.contents = image.cgImage
        _bottomHalf.contents = image.cgImage
        }
    
    private func guessFontSize()
        {
        let height = self.bounds.size.height - 10
        _font = UIFont(name: _font.fontName,size:height) ?? UIFont.boldSystemFont(ofSize: height)
        }
    
    private func updateColors()
        {
        self.layer.borderWidth = _borderWidth
        self.layer.borderColor = _borderColor.cgColor
        }
    
    override func layoutSubviews()
        {
        super.layoutSubviews()
        _container.frame = self.bounds
        _topHalf.frame = _container.bounds
        _bottomHalf.frame = _container.bounds
        let topMask = CAShapeLayer()
        topMask.frame = self.bounds
        topMask.path = UIBezierPath(rect:self.bounds.topHalf(withGap:1)).cgPath
        topMask.fillColor = UIColor.black.cgColor
        _topHalf.mask = topMask
        let bottomMask = CAShapeLayer()
        bottomMask.path = UIBezierPath(rect:self.bounds.bottomHalf(withGap:1)).cgPath
        bottomMask.fillColor = UIColor.black.cgColor
        _bottomHalf.mask = bottomMask
        }
    
    private func createIncomingLayers() -> (CALayer,CALayer,CALayer)
        {
        let attributes:[NSAttributedStringKey : Any] = [NSAttributedStringKey.font:_font,NSAttributedStringKey.foregroundColor:_textColor,NSAttributedStringKey.backgroundColor:self.backgroundColor!]
        let image = _nextDigit.imageDigit(inRect:self.bounds,withAttributes:attributes)
        let nextContainer = CALayer()
        nextContainer.transform = CATransform3DMakeRotation(CGFloat.pi,1,0,0)
        nextContainer.isDoubleSided = false
        nextContainer.frame = self.bounds
        let nextTop = CALayer()
        nextContainer.addSublayer(nextTop)
        nextTop.frame = nextContainer.bounds
        let nextBottom = CALayer()
        nextBottom.frame = nextContainer.bounds
        nextContainer.addSublayer(nextBottom)
        nextTop.contents = image.cgImage
        nextBottom.contents = image.cgImage
        let topMask = CAShapeLayer()
        topMask.frame = self.bounds
        topMask.path = UIBezierPath(rect:self.bounds.topHalf(withGap:1)).cgPath
        topMask.fillColor = UIColor.black.cgColor
        nextTop.mask = topMask
        let bottomMask = CAShapeLayer()
        bottomMask.path = UIBezierPath(rect:self.bounds.bottomHalf(withGap:1)).cgPath
        bottomMask.fillColor = UIColor.black.cgColor
        nextBottom.mask = bottomMask
        return(nextContainer,nextTop,nextBottom)
        }
    
    private func startDigitAnimation()
        {
        let duration:CFTimeInterval = 20
        let (newContainer,newTop,newBottom) = createIncomingLayers()
        self.layer.addSublayer(newContainer)
        let outTransform = newContainer.transform
        let inTransform = _container.transform
        let outAnimation = CABasicAnimation(keyPath: "transform")
        outAnimation.duration = duration
        outAnimation.fromValue = inTransform
        outAnimation.toValue = outTransform
        outAnimation.isRemovedOnCompletion = true
        outAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        outAnimation.fillMode = kCAFillModeBoth
        _container.add(outAnimation,forKey:"transform")
        let inAnimation = CABasicAnimation(keyPath:"transform")
        inAnimation.duration = duration
        inAnimation.fromValue = outTransform
        inAnimation.toValue = inTransform
        inAnimation.isRemovedOnCompletion = true
        inAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        inAnimation.fillMode = kCAFillModeBoth
        newContainer.add(inAnimation,forKey:"transform")
        newContainer.transform = inTransform
        inAnimation.delegate = self
        _currentDigit = _nextDigit
        _nextLayers = (newContainer,newTop,newBottom)
        }
    }

extension DigitFlippingView:CAAnimationDelegate
    {
    func animationDidStop(_ animation:CAAnimation,finished:Bool)
        {
        _container.removeFromSuperlayer()
        (_container,_topHalf,_bottomHalf) = _nextLayers!
        _nextLayers = nil
        }
    }
