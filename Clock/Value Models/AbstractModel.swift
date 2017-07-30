//
//  AbstractModel.swift
//  ValueModels
//
//  Created by Vincent Coetzee on 2017/06/29.
//  Copyright © 2017 MacSemantics. All rights reserved.
//

import Foundation

class AbstractModel:Model
    {
    internal var dependents = DependentSet()
    
    func changed(aspect:String,with:Any?,sender:Any?)
        {
        dependents.changed(aspect:aspect,with:with,sender:sender)
        }
    
    func add(dependent:Dependent)
        {
        dependents.add(dependent:dependent)
        }
    
    func remove(dependent:Dependent)
        {
        dependents.remove(dependent:dependent)
        }
    }
