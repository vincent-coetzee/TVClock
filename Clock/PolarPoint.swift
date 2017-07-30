//
//  PolarPoint.swift
//  Clock
//
//  Created by Vincent Coetzee on 2017/07/13.
//  Copyright © 2017 Vincent Coetzee. All rights reserved.
//

import Foundation
import UIKit

internal struct PolarPoint
    {
    let r:CGFloat
    let theta:CGFloat
    
    var cgPoint:CGPoint
        {
        return(CGPoint(x:r*cos(theta),y:r*sin(theta)))
        }
    
    init(r:CGFloat,degrees:CGFloat)
        {
        self.r = r
        self.theta = degrees*CGFloat.pi/180.0
        }
    
    init(r:CGFloat,theta:CGFloat)
        {
        self.r = r
        self.theta = theta
        }
    }
