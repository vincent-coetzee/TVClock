//
//  CGPoint+Extensions.swift
//  Clock
//
//  Created by Vincent Coetzee on 2017/07/13.
//  Copyright © 2017 Vincent Coetzee. All rights reserved.
//

import UIKit

extension CGPoint
    {
    static func +(lhs:CGPoint,rhs:(CGFloat,CGFloat)) -> CGPoint
        {
        return(CGPoint(x:lhs.x+rhs.0,y:lhs.y+rhs.1))
        }
    
    static func +(lhs:CGPoint,rhs:CGPoint) -> CGPoint
        {
        return(CGPoint(x:lhs.x+rhs.x,y:lhs.y+rhs.y))
        }
    }
