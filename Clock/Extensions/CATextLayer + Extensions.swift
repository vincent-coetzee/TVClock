//
//  CATextLayer + Extensions.swift
//  Clock
//
//  Created by Vincent Coetzee on 2017/07/30.
//  Copyright © 2017 Vincent Coetzee. All rights reserved.
//

import UIKit

extension CATextLayer
    {
    public func apply(style:Style)
        {
        self.backgroundColor = style.backgroundColor.cgColor
        self.foregroundColor = style.foregroundColor.cgColor
        self.font = style.font as CFTypeRef
        self.fontSize = style.font.pointSize
        }
    }
