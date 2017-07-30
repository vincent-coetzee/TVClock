//
//  Model.swift
//  ValueModels
//
//  Created by Vincent Coetzee on 2017/06/29.
//  Copyright © 2017 MacSemantics. All rights reserved.
//

import Foundation

protocol Model
    {
    func changed(aspect:String)
    func changed(aspect:String,with:Any?)
    func changed(aspect:String,with:Any?,sender:Any?)
    func add(dependent:Dependent)
    func remove(dependent:Dependent)
    }

extension Model
    {
    func changed(aspect:String,with:Any?)
        {
        changed(aspect:aspect,with:with,sender:self)
        }
    
    func changed(aspect:String)
        {
        changed(aspect:aspect,with:nil)
        }
    }
