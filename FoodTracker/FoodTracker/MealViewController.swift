//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Md Abdul Kadir on 20.03.18.
//  Copyright © 2018 Md Abdul Kadir. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by "Meal Table View Controller " in "prepare(for:sender:)" or constructed as part of adding new meal
    */
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Handle the text field's input through delegate callback.
        nameTextField.delegate = self
        
        // Setup views for editing an existing Meal.
        if let meal = meal{
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        //Disable save button
        updateSaveButtonsState()
    }
    
    //Mark: UITextFieldDeligate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable the save buttuon while editing
        saveButton.isEnabled = false
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        updateSaveButtonsState()
        navigationItem.title = textField.text
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide Keyboard
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
       
    }
    
    //MARK: UIImagePickerControllerDeligate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //The info dictionary may contain multiple representations of the image.
        guard  let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but it was providing the following: \(info)")
        }
        //Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        //Dismiss Picker
        dismiss(animated: true, completion: nil )
    }
    
    //MARK: Navigation
    @IBAction func cancell(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode{
            dismiss(animated: true, completion: nil)
        }
        else if let ownigNavigationController = navigationController{
            ownigNavigationController.popViewController(animated: true)
        }
        else{
            fatalError("The meealViewcONTROLLER IS NOT INSIGHT A NAVIGATION controller")
        }
       
    }
    
    //This method letts you configure a view controller before it#s presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        //Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button == saveButton else {
            os_log("The save button was not pressed", log: OSLog.default, type: .debug)
            return
        }
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        //Set thwe meal to passed to mealTableViewController
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    //MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //Hide keyboard.
        nameTextField.resignFirstResponder()
        
        //UIImagePickerController is a view controller that lets a user pick media from their photolibrary
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        //Make sure ViewController is notified when when the user pick an image
        imagePickerController.delegate = self
        present(imagePickerController,animated: true, completion: nil)
    }
    
    //MARK: Private methods
    private func updateSaveButtonsState() {
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

