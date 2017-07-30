//
//  Dependent.swift
//  ValueModels
//
//  Created by Vincent Coetzee on 2017/06/29.
//  Copyright © 2017 MacSemantics. All rights reserved.
//

import Foundation

protocol Dependent
	{
    var hash:Int { get }
    func update(aspect:String,with:Any?,sender:Any?)
	}

extension Dependent
    {
    func update(aspect:String,with:Any?)
        {
        update(aspect:aspect,with:with,sender:self)
        }
    
    func update(aspect:String)
        {
        update(aspect:aspect,with:nil)
        }
    }
