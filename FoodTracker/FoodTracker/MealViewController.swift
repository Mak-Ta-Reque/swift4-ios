//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Md Abdul Kadir on 20.03.18.
//  Copyright © 2018 Md Abdul Kadir. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Handle the text field's input through delegate callback.
        nameTextField.delegate = self
    }
    
    //Mark: UITextFieldDeligate
    
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
    
}

