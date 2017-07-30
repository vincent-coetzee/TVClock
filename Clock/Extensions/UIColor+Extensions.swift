//
//  UIColor+Extensions.swift
//  Clock
//
//  Created by Vincent Coetzee on 2017/07/26.
//  Copyright © 2017 Vincent Coetzee. All rights reserved.
//

import UIKit

extension UIColor
    {
    func withAlpha(_ alpha:CGFloat) -> UIColor
        {
        var red:CGFloat = 0
        var green:CGFloat = 0
        var blue:CGFloat = 0
        
        getRed(&red,green:&green,blue:&blue,alpha:nil)
        return(UIColor(red:red,green:green,blue:blue,alpha:alpha))
        }
    }
