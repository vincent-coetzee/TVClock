//
//  WorldClockCell.swift
//  Clock
//
//  Created by Vincent Coetzee on 2017/07/26.
//  Copyright © 2017 Vincent Coetzee. All rights reserved.
//

import UIKit

internal class WorldClockCell:UICollectionViewCell
    {
    override public var reuseIdentifier:String?
        {
        return("com.macsemantics.WorldClockCell")
        }
    
    private var labelView:UILabel
    private var clockView:ClockView
    
    var label:String
        {
        get
            {
            return(labelView.text ?? "")
            }
        set
            {
            labelView.text = newValue
            }
        }
    
    var secondsFromGMT:Int
        {
        get
            {
            return(clockView.clock.secondsFromGMT)
            }
        set
            {
            clockView.clock.secondsFromGMT = newValue
            }
        }
    
    func intrinsicSize() -> CGSize
        {
        return(CGSize(width:256,height:256))
        }
    
    override func prepareForReuse()
        {
        labelView.text = ""
        clockView.clock.secondsFromGMT = 0
        }
    
    override init(frame:CGRect)
        {
        labelView = UILabel()
        labelView.font = UIFont.boldSystemFont(ofSize: 24)
        labelView.textColor = UIColor.white
        labelView.textAlignment = .center
        labelView.translatesAutoresizingMaskIntoConstraints = false
        clockView = ClockView(frame:CGRect(x:0,y:0,width:100,height:100))
        clockView.clockFaceColor = UIColor.white
        clockView.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame:frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        initLayout()
        }
    
    private func initLayout()
        {
        self.addSubview(labelView)
        self.addSubview(clockView)
        var constraints = [NSLayoutConstraint]()
        let margins = self.layoutMarginsGuide
        constraints.append(labelView.leadingAnchor.constraint(equalTo: margins.leadingAnchor))
        constraints.append(labelView.trailingAnchor.constraint(equalTo: margins.trailingAnchor))
        constraints.append(labelView.topAnchor.constraint(equalTo: margins.topAnchor))
        constraints.append(clockView.centerXAnchor.constraint(equalTo:margins.centerXAnchor))
        constraints.append(clockView.topAnchor.constraint(equalTo:labelView.bottomAnchor,constant:16))
        constraints.append(clockView.widthAnchor.constraint(equalTo:margins.widthAnchor))
        constraints.append(clockView.heightAnchor.constraint(equalTo:clockView.widthAnchor))
        NSLayoutConstraint.activate(constraints)
        }
    
    required init?(coder aDecoder: NSCoder)
        {
        fatalError("init(coder:) has not been implemented")
        }
    }
