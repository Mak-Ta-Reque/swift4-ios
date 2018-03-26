//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Md Abdul Kadir on 20.03.18.
//  Copyright © 2018 Md Abdul Kadir. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    //MARK: Meal class test
    
    
    //Cofirm that the Meal initilizer returns a Meal object when passed vald parameters.
    
    func testMealInitializationSucceeds(){
        //Zero rating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        //Highest positive rating
        
        let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
    }
    
    func testMealInitializationFails(){
        //Negative Rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        //Rating acceeds minimum
        let largeRtingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRtingMeal)
        
        //Empty String
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
    }
}
