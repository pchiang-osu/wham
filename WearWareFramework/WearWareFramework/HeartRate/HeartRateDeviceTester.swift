//
//  HeartRateDeviceTester.swift
//  HeartRate
//
//  Created by Rikki Gibson on 12/21/14.
//  Copyright (c) 2014 Rikki Gibson. All rights reserved.
//

import Foundation

func completionHandler(detectionTimes: [NSDate]) -> Void {
    println(analyzeDetectionTimes(detectionTimes))
}

/// Performs a test routine to observe a heartbeat in a WearWare device.
public class HeartRateDeviceTester : NSObject, WWDeviceManagerDelegate {
    let manager = WWDeviceManager()
    
    var device: WWDevice?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.scanForDevices(nil)
    }
    
    public func manager(manager: WWDeviceManager!, onBluetoothStateChange state: CBCentralManagerState) {
        
    }
    
    /// Used to prevent deallocation because WWDevice.delegate is a weak property
    var delegate: WWDeviceDelegate?
    public func manager(manager: WWDeviceManager!, onDeviceFound device: WWDevice!) {
        manager.connectToDevice(device)
        let detectorDelegate = WWHeartRateDetectorExampleDelegate(completionHandler: completionHandler)
        delegate = WWHeartRateDetector(delegate: detectorDelegate)
        device.delegate = delegate
    }
    
    public func manager(manager: WWDeviceManager!, onDeviceConnected device: WWDevice!) {
        let value = NSValue(WWCommandId: WWCommandId.ADCSample)
        let arr = NSArray(object: value)
        device.changeUpdatePeriod(1)
        device.enableData(arr)
    }
}