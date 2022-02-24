//
//  HomePageVCTests.swift
//  MyForcastTests
//
//  Created by Nidhal on 24/2/2022.
//

import XCTest

@testable import MyForcast

class HomePageVCTests: XCTestCase {
    let vcHome = HomePageVC()
    
    func testHomePageVC() {
        vcHome.loadViewIfNeeded()
        
    }
}
