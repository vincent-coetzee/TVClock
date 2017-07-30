//
//  WorldClockCollection.swift
//  Clock
//
//  Created by Vincent Coetzee on 2017/07/26.
//  Copyright © 2017 Vincent Coetzee. All rights reserved.
//

import UIKit

internal class WorldClockCollection
    {
    public var clocks:[(label:String,secondsFromGMT:Int)] = []
    
    class func defaultClocks() -> WorldClockCollection
        {
        let collection = WorldClockCollection()
        collection.clocks.append((label:"London",secondsFromGMT:0))
        collection.clocks.append((label:"San Francisco",secondsFromGMT:-7*60*60))
        collection.clocks.append((label:"Sydney",secondsFromGMT: 10*60*60))
        collection.clocks.append((label:"Hong Kong",secondsFromGMT: 8*60*60))
        collection.clocks.append((label:"Moscow",secondsFromGMT: 3*60*60))
        collection.clocks.append((label:"Denver",secondsFromGMT: -3*60*60))
        collection.clocks.append((label:"Washington",secondsFromGMT: -4*60*60))
        collection.clocks.append((label:"New York",secondsFromGMT: -5*60*60))
        collection.clocks.append((label:"Hanoi",secondsFromGMT: 7*60*60))
        collection.clocks.append((label:"Mumbai",secondsFromGMT: Int(5.5*60*60)))
        collection.clocks.append((label:"Kathmandu",secondsFromGMT: Int(5.5*60*60)))
        collection.clocks.append((label:"Dubai",secondsFromGMT: 4*60*60))
        return(collection)
        }
    }
