//
//  CGRect+Extensions.swift
//  Clock
//
//  Created by Vincent Coetzee on 2017/07/26.
//  Copyright © 2017 Vincent Coetzee. All rights reserved.
//

import UIKit

extension CGRect
    {
    public var center:CGPoint
        {
        return(CGPoint(x:midX,y:midY))
        }
    
    public func rectWithCenteredSize(_ size:CGSize) -> CGRect
        {
        let xPadding = (self.size.width - size.width) / 2.0
        let yPadding = (self.size.height - size.height) / 2.0
        return(CGRect(origin:CGPoint(x:xPadding,y:yPadding),size:size))
        }
    
    public func topHalf(withGap:CGFloat) -> CGRect
        {
        let half = self.height / 2.0 - withGap
        return(CGRect(x:0,y:0,width:self.size.width,height:half))
        }
    
    public func bottomHalf(withGap gap:CGFloat) -> CGRect
        {
        let half = self.height / 2.0
        return(CGRect(x:0,y:half + gap,width:self.size.width,height:half - gap))
        }
    }
