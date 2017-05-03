//
//  DiappetesTests.swift
//  DiappetesTests
//
//  Created by Gustavo Méndez on 27/04/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import XCTest

@testable import Diappetes
class DiappetesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testAlimentos(){
    let caso = 0
    let calorias = 2
    let cantidad = 4
    
    
    let resultado = PruebasAlimento()
    //
    XCTAssertEqual(resultado.agregarAlimento(x: caso, cal: Double(calorias), cant: Double(cantidad)),8)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
