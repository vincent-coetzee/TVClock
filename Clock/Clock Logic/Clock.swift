//
//  Clock.swift
//  Clock
//
//  Created by Vincent Coetzee on 2017/07/07.
//  Copyright © 2017 Vincent Coetzee. All rights reserved.
//

import Foundation

internal class Clock:Model
    {
    private var dependents:[Int:Dependent] = [:]
    private let timer:DispatchSourceTimer
    private var timeZone:TimeZone
    private let dateFormatter = DateFormatter()
    
    internal var hour:Int = 0
    internal var minute:Int = 0
    internal var second:Int = 0
    
    internal var secondsFromGMT:Int
        {
        get
            {
            return(timeZone.secondsFromGMT())
            }
        set
            {
            timeZone = TimeZone(secondsFromGMT:newValue)!
            dateFormatter.timeZone = timeZone
            }
        }
    
    internal var dateString:String
        {
        return(dateFormatter.string(from:Date()))
        }
    
    init(secondsFromGMT:Int = 0)
        {
        dateFormatter.dateFormat = "EEE dd MMM YYYY"
        timeZone = TimeZone(secondsFromGMT:secondsFromGMT)!
        dateFormatter.timeZone = timeZone
        timer = DispatchSource.makeTimerSource(queue:DispatchQueue.main)
        initTimer()
        updateTime()
        }
    
    deinit
        {
        timer.cancel()
        }
    
    private func initTimer()
        {
        timer.schedule(wallDeadline: .now(),repeating: 1.0)
        timer.setEventHandler
            {
            [weak self] in
            self?.tick()
            }
        timer.resume()
        }
    
    private func updateTime()
        {
        let date = Date()
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: timeZone,from:date)
        hour = components.hour!
        minute = components.minute!
        second = components.second!
        }
    
    private func tick()
        {
        let oldHour = hour
        let oldMinute = minute
        let oldSecond = second
        updateTime()
        if second != oldSecond
            {
            changed(aspect:"second")
            }
        if minute != oldMinute
            {
            changed(aspect:"minute")
            }
        if hour != oldHour
            {
            changed(aspect:"hour")
            }
        }
    
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
