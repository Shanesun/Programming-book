//
//  LeetCodeTests.swift
//  LeetCodeTests
//
//  Created by Shane on 2018/9/30.
//  Copyright © 2018 Shane. All rights reserved.
//

import XCTest
@testable import LeetCode

class LeetCodeTests: XCTestCase {
    var leetCode = LeetCode()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testrotate() {
//        var arr = [1,2,3,4,5,6,7]
//        leetCode.rotate(&arr, 3)
        
        var arr = [1,2,3,4,5,6]
        leetCode.rotate(&arr, 2)
    }
    
    func testgetRow() {
       let t = leetCode.getRow(5)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
