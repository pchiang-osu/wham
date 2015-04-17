//
//  WWHeartRateDetector.swift
//  HeartRate
//
//  Created by Rikki Gibson on 12/19/14.
//  Copyright (c) 2014 Rikki Gibson. All rights reserved.
//

import Foundation

@objc public protocol WWHeartRateDetectorDelegate {
    func didDetectHeartbeat(detector: WWHeartRateDetector, atTime time: NSDate);
    func detector(detector: WWHeartRateDetector, didReachEndOfData data: [Int]);
}

let DATA_RATE: NSTimeInterval = 0.01

public typealias HeartRateCompletionHandler = (detectionTimes: [NSDate]) -> Void
public class WWHeartRateDetectorExampleDelegate : NSObject, WWHeartRateDetectorDelegate {
    private let completionHandler: HeartRateCompletionHandler
    private var detectionTimes = [NSDate]()
    
    public init(completionHandler: HeartRateCompletionHandler) {
        self.completionHandler = completionHandler
    }
    
    public func didDetectHeartbeat(detector: WWHeartRateDetector, atTime time: NSDate) {
        detectionTimes.append(time)
    }
    
    public func detector(detector: WWHeartRateDetector, didReachEndOfData data: [Int]) {
        completionHandler(detectionTimes: detectionTimes)
        
    }
}

public class WWHeartRateDetector : NSObject {
    let MINIMUM_IN_THRESHOLD = 20
    let REFERENCE_TIME = NSDate()
    
    public var delegate: WWHeartRateDetectorDelegate!
    private var data = [Int]()
    private var valuesObserved = 0
    private var timer: NSTimer?
    
    public var detectionTimes = [NSDate]()
    
    public var beatsPerMinute: Double {
        get {
            let relevantTimes = detectionTimes.filter({ $0.timeIntervalSinceNow < 10 })
            let differences = relevantTimes.mapAdjacentElements({ $1.timeIntervalSinceDate($0) })
                .filter({ $0 < 2 && $0 > 0.3 })
            let averageBPM = 1 / (differences.reduce(0, combine: +) / Double(differences.count)) * 60
            return averageBPM
        }
    }
    
    /// Minimum value of a valid heartbeat peak.
    public var lowerThreshold = 250
    
    /// Maximum value of a valid heartbeat peak.
    public var upperThreshold = 750
    
    /// Indicates whether the input value is within the acceptable
    /// range for the peak of a heartbeat.
    public func withinPeakThreshold(dataPoint: Int) -> Bool {
        return dataPoint > lowerThreshold && dataPoint < upperThreshold
    }
    
    /// The range of valid slopes.
    public var slopeRange = -160.0...(-60.0)
    
    let manager = WWCentralDeviceManager.sharedCentralDeviceManager()
    
    @objc public init(delegate: WWHeartRateDetectorDelegate) {
        super.init()
        self.delegate = delegate
        self.registerForWWUpdates()
    }
    
    func registerForWWUpdates() {
        let center = NSNotificationCenter.defaultCenter()
        let queue = NSOperationQueue.mainQueue()
        let updates = [WWDeviceDidUpdate]
        
        
        center.addObserverForWWDeviceUpdates(updates) { (notification: NSNotification!) in
            let deviceData = notification.object as/*!*/ WWDeviceData                   //! taken out for xCode version
            
            if deviceData.dataId == .ADCSample {
                let adcData: NSNumber = deviceData.data as/*!*/ NSNumber                //! taken out for xCode version
                self.valuesObserved++
                if self.data.count > 100 {
                    self.data = Array(self.data[self.data.endIndex - self.MINIMUM_IN_THRESHOLD..<self.data.endIndex])
                }
                self.data.append(adcData.integerValue)
                if self.currentSliceContainsHeartbeat() {
                    // for non-real time testing
                    // let time = NSDate(timeIntervalSinceNow: Double(valuesObserved) * DATA_RATE)
                    let time = NSDate()
                    self.detectionTimes.append(time)
                    self.delegate.didDetectHeartbeat(self, atTime: time)
                }
            }
        }
    }

    
    
//    public override func observeValueForKeyPath(keyPath: String,
//        ofObject object: AnyObject, change: [NSObject : AnyObject],
//        context: UnsafeMutablePointer<Void>) {
//            if keyPath == "ADCData" {
//                let adcData = WWCentralDeviceManager.sharedCentralDeviceManager().ADCData
//                device(nil, onDataValueUpdate: .ADCSample, value: [adcData])
//            } else {
//                super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
//            }
//    }
//    
//    public func device(device: WWDevice!, onDataValueUpdate dataId: WWCommandId, value: NSObject!) {
//        if dataId == WWCommandId.ADCSample {
//            if let value = (value as? NSArray)?.firstObject as? NSNumber {
//                valuesObserved++
//                if data.count > 100 {
//                    data = Array(data[data.endIndex - MINIMUM_IN_THRESHOLD..<data.endIndex])
//                }
//                data.append(value.integerValue)
//                if currentSliceContainsHeartbeat() {
//                    // for non-real time testing
//                    // let time = NSDate(timeIntervalSinceNow: Double(valuesObserved) * DATA_RATE)
//                    let time = NSDate()
//                    self.detectionTimes.append(time)
//                    delegate.didDetectHeartbeat(self, atTime: time)
//                }
//            }
//        }
//    }
    
    public func onDeviceDisconnected(device: WWDevice!, error: NSError!) {
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
        if any(trailingData, predicate: { $0 < self.lowerThreshold }) {
            return false
        }
        
        return true
    }
}