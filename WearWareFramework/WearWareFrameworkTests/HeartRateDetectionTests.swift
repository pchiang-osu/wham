//
//  HeartRateDetectionTests.swift
//  WearWareFramework
//
//  Created by Rikki Gibson on 12/24/14.
//  Copyright (c) 2014 WearWare. All rights reserved.
//

import UIKit
import XCTest
import WearWareFrameworkiOS

class HeartRateDetectionTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func makeCompletionHandler(#beatsExpected: Int) -> HeartRateCompletionHandler {
        return { detectionTimes in
            println(analyzeDetectionTimes(detectionTimes))
            XCTAssertEqual(detectionTimes.count, beatsExpected,
                "Beats observed should equal beats expected.")
        }
    }
    
    func runTest(named name: String, beatsExpected: Int) {
        let data = getHeartRateData(named: name, forClass: HeartRateDetectionTests.classForCoder())
        let detectorDelegate = WWHeartRateDetectorExampleDelegate(completionHandler:
            makeCompletionHandler(beatsExpected: beatsExpected))
        let detector = WWHeartRateDetector(delegate: detectorDelegate)
        let device = WWECGDeviceSim(data: data, delegate: detector, callbackDelay: 0.0)
        device.start()
    }
    
    func test24Beats() {
        runTest(named: "Heart_Rate", beatsExpected: 24)
    }
    
    func testNoise19Beats() {
        runTest(named: "noise_19_beats", beatsExpected: 19)
    }
    
    func testNoise30Beats() {
        runTest(named: "noise_30_beats", beatsExpected: 30)
    }
}
