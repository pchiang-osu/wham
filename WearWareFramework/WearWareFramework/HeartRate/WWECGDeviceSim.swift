//
//  WWFakeDevice.swift
//  HeartRate
//
//  Created by Rikki Gibson on 12/19/14.
//  Copyright (c) 2014 Rikki Gibson. All rights reserved.
//

import Foundation

public class WWECGDeviceSim : NSObject {
    let data: [Int]
    let delegate: WWDeviceDelegate
    
    /// The time that should pass between callbacks.
    let callbackDelay: NSTimeInterval
    
    var timer: NSTimer?
    
    public init(data: [Int], delegate: WWDeviceDelegate, callbackDelay: NSTimeInterval) {
        self.data = data
        self.delegate = delegate
        self.callbackDelay = callbackDelay
    }
    
    private var currentIndex = 0
    public func start() {
        if callbackDelay > 0 {
            timer = NSTimer.scheduledTimerWithTimeInterval(callbackDelay, target: self,
                selector: "update", userInfo: nil, repeats: true)
        } else {
            while currentIndex < data.count {
                update()
            }
        }
    }
    
    func update() {
        currentIndex++
        if currentIndex >= data.count {
            timer?.invalidate()
            delegate.onDeviceDisconnected(nil, error: nil)
        } else {
            delegate.device(nil, onDataValueUpdate: WWCommandId.ADCSample,
                value: NSArray(object: data[currentIndex]))
        }
    }
}