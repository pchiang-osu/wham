//
//  analysis.swift
//  HeartRate
//
//  A collection of functions used to read in heart rate test data
//  and analyze its properties.
//
//  Created by Rikki Gibson on 12/19/14.
//  Copyright (c) 2014 Rikki Gibson. All rights reserved.
//

import Foundation

/// Reads in a heart rate CSV and spits out an array of integers
/// representing the magnitude of each ECG sample.
public func getHeartRateData(named name: String, #forClass: AnyClass) -> [Int] {
    var result = [Int]()
    
    var error: NSError?
    
    let path = NSBundle(forClass: forClass).pathForResource(name, ofType: "csv")!
    let file = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: &error)!
    if (error != nil) {
        println(error?.description)
    } else {
        let scanner = NSScanner(string: file)
        let delimiter = NSCharacterSet(charactersInString: "\r")
        
        var str: NSString?
        while !scanner.atEnd {
            scanner.scanUpToCharactersFromSet(delimiter, intoString: &str)
            if let str = str {
                let range = str.rangeOfString(",")
                let targetIndex = range.location + 1
                let intValue = str.substringFromIndex(targetIndex).toInt()!
                result.append(intValue)
            }
        }
    }
    
    return result
}

/// Returns a value indicating whether the middle is less than the left and right.
public func isLocalMinima(left: Int, middle: Int, right: Int) -> Bool {
    return middle < left && middle <= right
}

/// Returns a value indicating whether the middle is less than the left and right.
public func isLocalMaxima(left: Int, middle: Int, right: Int) -> Bool {
    return middle > left && middle >= right
}

/// Returns the nearest peak preceding the given index in the given dataset.
/// If the index is out of range, returns the last peak in the dataset.
public func indexOfLastPeak(data: [Int], index: Int) -> Int {
    for var i = min(index, data.count); i > 3; i-- {
        let left = data[i - 3];
        let middle = data[i - 2];
        let right = data[i - 1];
        if isLocalMaxima(left, middle, right) {
            return i - 2;
        }
    }
    return 0
}

/// Returns a limited set of array indexes corresponding to the lowest minima in data.
public func getMinima(data: [Int], #limit: Int) -> [Int] {
    // This is an array of indexes of elements in data that contain local extrema
    var minima = [Int]()
    for var i = 1; i < data.count - 1; i++ {
        if isLocalMinima(data[i-1], data[i], data[i+1]) {
            minima.append(i)
        }
    }
    minima.sort({ data[$0] < data[$1] })
    return Array(minima[0..<limit])
}

/// Returns the decreasing slope obtained by averaging the differences between
/// data points until a flat or positive slope is encountered between 2 points.
public func getSlope(data: [Int], approachingIndex index: Int) -> Double {
    let NUMBER_OF_SAMPLES = 3
    var sum = 0
    for var i = 0; i < NUMBER_OF_SAMPLES; i++ {
        let currentIndex = index - i
        let difference = data[currentIndex] - data[currentIndex - 1]
        sum += difference
    }
    
    let average = Double(sum) / Double(NUMBER_OF_SAMPLES)
    return average
}

/// Returns a string containing analytics about a set of heartbeat detection times.
public func analyzeDetectionTimes(detectionTimes: [NSDate]) -> String {
    let heartbeatDifferences = detectionTimes.mapAdjacentElements({ $1.timeIntervalSinceDate($0) })
    let variabilities = heartbeatDifferences.mapAdjacentElements({ abs($0 - $1) })
    let averageBPM = heartbeatDifferences.reduce(0, +) / Double(heartbeatDifferences.count)
    let averageVariability = variabilities.reduce(0, +) / Double(variabilities.count)
    let beatsPerMinute = String(format:"%0.1f", 60 / averageBPM)
    
    let result = "Intervals: " + ", ".join(heartbeatDifferences.map({ String(format:"%0.2f", $0) })) +
        "\nVariabilities: " + ", ".join(variabilities.map({ String(format:"%0.2f", $0) })) +
        "\nAverage BPM: \(beatsPerMinute)" +
        "\nAverage variability: \(averageVariability)" +
        "\n\(detectionTimes.count) beats total."
    return result
}