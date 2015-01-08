//
//  WWHeartRateDetector.swift
//  HeartRate
//
//  Created by Rikki Gibson on 12/19/14.
//  Copyright (c) 2014 Rikki Gibson. All rights reserved.
//

import Foundation
import WearWareFrameworkOSX

protocol WWHeartRateDetectorDelegate {
    func didDetectHeartbeat(detector: WWHeartRateDetector, atTime time: NSDate);
    func detector(detector: WWHeartRateDetector, didReachEndOfData data: [Int]);
}

let DATA_RATE: NSTimeInterval = 0.01

class WWHeartRateDetectorExampleDelegate : NSObject, WWHeartRateDetectorDelegate {
    private var detectionTimes = [NSDate]()
    
    func didDetectHeartbeat(detector: WWHeartRateDetector, atTime time: NSDate) {
        detectionTimes.append(time)
    }
    
    func detector(detector: WWHeartRateDetector, didReachEndOfData data: [Int]) {
        let heartbeatDifferences = detectionTimes.mapAdjacentElements({ $1.timeIntervalSinceDate($0) })
        let variabilities = heartbeatDifferences.mapAdjacentElements({ abs($0 - $1) })
        let averageBPM = heartbeatDifferences.reduce(0, +) / Double(heartbeatDifferences.count)
        let averageVariability = variabilities.reduce(0, +) / Double(variabilities.count)
        let beatsPerMinute = String(format:"%0.1f", 60 / averageBPM)
        println("Intervals: " + ", ".join(heartbeatDifferences.map({ String(format:"%0.2f", $0) })))
        println("Variabilities: " + ", ".join(variabilities.map({ String(format:"%0.2f", $0) })))
        println("Average BPM: \(beatsPerMinute)")
        println("Average variability: \(averageVariability)")
        println("\(detectionTimes.count) beats total.")
    }
}

class WWHeartRateDetector : NSObject, WWDeviceDelegate {
    let MINIMUM_IN_THRESHOLD = 20
    let REFERENCE_TIME = NSDate()
    
    private let delegate: WWHeartRateDetectorDelegate
    private var data = [Int]()
    private var valuesObserved = 0
    private var timer: NSTimer?
    
    /// Minimum value of a valid heartbeat peak.
    var lowerThreshold = 250
    
    /// Maximum value of a valid heartbeat peak.
    var upperThreshold = 750
    
    /// Indicates whether the input value is within the acceptable
    /// range for the peak of a heartbeat.
    func withinPeakThreshold(dataPoint: Int) -> Bool {
        return dataPoint > lowerThreshold && dataPoint < upperThreshold
    }
    
    /// The range of valid slopes.
    var slopeRange = -160.0...(-60.0)
    
    init(delegate: WWHeartRateDetectorDelegate) {
        self.delegate = delegate
    }

    func device(device: WWDevice!, onDataValueUpdate dataId: WWCommandId, value: NSObject!) {
        if dataId == WWCommandId.ADCSample {
            if let value = (value as? NSArray)?.firstObject as? NSNumber {
                valuesObserved++
                if data.count > 100 {
                    data = Array(data[data.endIndex - MINIMUM_IN_THRESHOLD..<data.endIndex])
                }
                data.append(value.integerValue)
                if currentSliceContainsHeartbeat() {
                    let time = NSDate(timeIntervalSinceNow: Double(valuesObserved) * DATA_RATE)
                    delegate.didDetectHeartbeat(self, atTime: time)
                }
            }
        }
    }
    
    func onDeviceDisconnected(device: WWDevice!, error: NSError!) {
        delegate.detector(self, didReachEndOfData: data)
    }
    
    /// Returns a value indicating whether a heartbeat is present at the edge
    /// of the data received.
    private func currentSliceContainsHeartbeat() -> Bool {
        
        if data.count < MINIMUM_IN_THRESHOLD {
            return false
        }
        
        let middle = data[data.endIndex - 2]
        if !withinPeakThreshold(middle) {
            return false
        }
        
        let left = data[data.endIndex - 3]
        let right = data[data.endIndex - 1]
        if !isLocalMinima(left, middle, right) {
            return false
        }
        
        let slope = getSlope(self.data, approachingIndex: self.data.endIndex - 2)
        if !slopeRange.contains(slope) {
            return false
        }
        
        // If a point is below the lower threshold, it's noise.
        let trailingData = data[data.endIndex - MINIMUM_IN_THRESHOLD..<data.endIndex]
        if any(trailingData, { $0 < self.lowerThreshold }) {
            return false
        }
        
        return true
    }
}