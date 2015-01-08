//
//  HeartRateDeviceTest.swift
//  HeartRate
//
//  Created by Rikki Gibson on 12/21/14.
//  Copyright (c) 2014 Rikki Gibson. All rights reserved.
//

import Foundation
import WearWareFrameworkOSX

/// Performs a test routine to observe a heartbeat in a WearWare device.
class HeartRateDeviceTester : NSObject, WWDeviceManagerDelegate {
    let manager = WWDeviceManager()
    
    var device: WWDevice?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.scanForDevices(nil)
    }
    
    func manager(manager: WWDeviceManager!, onBluetoothStateChange state: CBCentralManagerState) {
        
    }
    
    /// Used to prevent deallocation because WWDevice.delegate is a weak property
    var delegate: WWDeviceDelegate?
    func manager(manager: WWDeviceManager!, onDeviceFound device: WWDevice!) {
        manager.connectToDevice(device)
        delegate = WWHeartRateDetector(delegate: WWHeartRateDetectorExampleDelegate())
        device.delegate = delegate
    }
    
    func manager(manager: WWDeviceManager!, onDeviceConnected device: WWDevice!) {
        let value = NSValue(WWCommandId: WWCommandId.ADCSample)
        let arr = NSArray(object: value)
        device.changeUpdatePeriod(1)
        device.enableData(arr)
    }
}