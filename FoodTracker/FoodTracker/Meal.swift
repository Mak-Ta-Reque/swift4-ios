//
//  Meal.swift
//  FoodTracker
//
//  Created by Md Abdul Kadir on 24.03.18.
//  Copyright © 2018 Md Abdul Kadir. All rights reserved.
//

import UIKit

class Meal {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        // Validate initialization parameters
        guard !name.isEmpty else{
            return nil
        }
        
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        //Initialize parmeters
        self.name = name
        self.photo = photo
        self.rating = rating
        
    }
}
