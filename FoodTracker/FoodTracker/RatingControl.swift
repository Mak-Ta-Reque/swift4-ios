//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Md Abdul Kadir on 23.03.18.
//  Copyright © 2018 Md Abdul Kadir. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    //MARK: Properties
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height:44.0){
        didSet{
            setUpButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet{
            setUpButtons()
        }
    }
    
    private var ratingButons = [UIButton]()
    
    var rating = 0 {
        didSet{
            updateButtonSelectionStates()
        }
    }
    
    //MARK: Initialization
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButons.index(of: button) else {
            fatalError("The button ,\(button), is not in the ratingButtons array\(ratingButons)")
        }
        //Calculate the rating of the selectedbutton
        let selectedRating = index + 1
        if selectedRating == rating{
            // If the selected star represent the current rating, then rest the rating to 0
            rating = 0
        }
        else{
            //Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpButtons()
    }
    
    //MARK: Private Method
    private func setUpButtons(){
        //clear any existing buttons
        for button in ratingButons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButons.removeAll()
        
        //Load Button Image
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(  named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        
        
        //Create a Button
        for index in 0..<starCount {
            let button = UIButton()
            
            //Set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            //Set accessibility label
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //Setup the button action
            
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            //Add the button to the stack
            addArrangedSubview(button)
            ratingButons.append(button)
        }
        updateButtonSelectionStates()
    }
    private func updateButtonSelectionStates(){
        for(index, button) in ratingButons.enumerated(){
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
                
            }
            else{
                hintString = nil
            }
            //calculate the value string
            let valueString: String
            switch(rating){
            case 0:
                valueString = "No Rating set"
            case 1:
                valueString = "1 star set"
            case 2:
                valueString = "2 stars set"
            case 3:
                valueString = "3 stars set"
            case 4:
                valueString = "4 stars set"
            default:
                valueString = "\(rating) stard set"
                
            }
            
            //Assign the hint and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
            
            button.isSelected = index < rating
            
        }
    }
}
