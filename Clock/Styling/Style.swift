//
//  Style.swift
//  Clock
//
//  Created by Vincent Coetzee on 2017/07/30.
//  Copyright © 2017 Vincent Coetzee. All rights reserved.
//

import UIKit

public class Style
    {
    public var name:String = ""
    public var backgroundColor = UIColor.black
    public var foregroundColor = UIColor.white
    public var font = UIFont.boldSystemFont(ofSize:20)
    public var borderColor = UIColor.white
    public var borderWidth:CGFloat = 2
    public var cornerRadius:CGFloat = 10
    
    public var styleAttributes:[NSAttributedStringKey : Any]
        {
        let someAttributes:[NSAttributedStringKey : Any] = [NSAttributedStringKey.font:font,NSAttributedStringKey.foregroundColor:foregroundColor,NSAttributedStringKey.backgroundColor:self.backgroundColor]
        return(someAttributes)
        }
    init(name:String)
        {
        self.name = name
        }
    
    public func size(of string:String) -> CGSize
        {
        return(string.size(withAttributes: self.styleAttributes))
        }
    }
