//
//  ValueHolder.swift
//  ValueModels
//
//  Created by Vincent Coetzee on 2017/06/29.
//  Copyright © 2017 MacSemantics. All rights reserved.
//

import Foundation

class ValueHolder<T>:AbstractModel
    {
    var value:T?
        {
        didSet
            {
            changed(aspect:"value")
            }
        }
    
    init(value:T)
        {
        self.value = value
        }
    }
