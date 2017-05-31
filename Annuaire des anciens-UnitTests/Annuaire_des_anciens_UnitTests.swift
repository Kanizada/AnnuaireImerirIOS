//
//  Annuaire_des_anciens_UnitTests.swift
//  Annuaire des anciens-UnitTests
//
//  Created by Student on 30/05/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import XCTest
@testable import Annuaire_des_anciens

class Annuaire_des_anciens_UnitTests: XCTestCase {
	
	let myJson = "{\"id\":1,\"nom\":\"testnom\",\"prenom\":\"testprenom\",\"email\":\"test@test.com\",\"telephone_mobile\":\"0513513512\",\"telephone_fixe\":\"3058725393\",\"site_web\":\"siteTest.com\",\"adresse\":\"1 rue du Test\",\"code_postal\":\"54646\",\"ville\":\"TESTCITY\"}"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testParsing(){
		
		let myEleve = Eleve.init(myJson)
		
		XCTAssertEqual(myEleve.nom, "testnom")
		XCTAssertEqual(myEleve.prenom, "testprenom")
		XCTAssertEqual(myEleve.email, "test@test.com")
		XCTAssertEqual(myEleve.telephone_mobile, "0513513512")
		XCTAssertEqual(myEleve.telephone_fixe, "058725393")
		XCTAssertEqual(myEleve.site_web, "siteTest.com")
		XCTAssertEqual(myEleve.adresse, "1 rue du Test")
		XCTAssertEqual(myEleve.code_postal, "54646")
		XCTAssertEqual(myEleve.ville, "TESTCITY")
	}
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
