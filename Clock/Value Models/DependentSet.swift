//
//  DependentSet.swift
//  ValueModels
//
//  Created by Vincent Coetzee on 2017/06/29.
//  Copyright © 2017 MacSemantics. All rights reserved.
//

import Foundation

class DependentSet:Model
    {
    private var dependents:[Int:Dependent] = [:]
    
    func changed(aspect:String,with:Any?,sender:Any?)
        {
        dependents.values.forEach
            {
            dependent in
            dependent.update(aspect:aspect,with:with,sender:sender)
            }
        }
    
    func add(dependent:Dependent)
        {
        dependents[dependent.hash] = dependent
        }
    
    func remove(dependent:Dependent)
        {
        dependents[dependent.hash] = nil
        }
    }
