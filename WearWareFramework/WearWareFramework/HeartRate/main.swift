//
//  main.swift
//  HeartRate
//

import Foundation

//let data = Array(getHeartRateData(named: "noise_30_beats")[450...1500])
//var longData = [Int]()
//for i in 1...1000 {
//    longData += data
//}

// -- Use this to look for thresholds in sample ECG data
//let minima = getMinima(data, limit: 15)
//let slopes = minima.map({ getSlope(data, approachingIndex: $0) })
//let lastPeaks = minima.map({ indexOfLastPeak(data, $0) })
//
//for var i = 0; i < minima.count; i++ {
//    println("Magnitude: \(data[minima[i]]) Slope: \(slopes[i]) Last peak magnitude: \(data[lastPeaks[i]])")
//}

// -- Use this to detect heartbeats from sample data.
//let detector = WWHeartRateDetector(delegate: WWHeartRateDetectorExampleDelegate())
//let device = WWECGDeviceSim(data: data, delegate: detector, callbackDelay: 0.0)
//device.start()

// -- Use this to observe a heartbeat on a device
// let managerDelegate = HeartRateDeviceTest()

// prevent program from exiting
//let date = NSDate(timeIntervalSinceNow: 360.0)
//NSRunLoop.mainRunLoop().runUntilDate(date)