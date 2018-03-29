//
//  ViewController.swift
//  TutorialTwo
//
//  Created by Md Abdul Kadir on 28.03.18.
//  Copyright © 2018 Md Abdul Kadir. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field#s user input through delegate callback.
        nameTextField.delegate = self
    }
    
    //MARK: UITextFieldDeligate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide keyboard
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }
    
    //mark: UIImagePickerDEligate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            fatalError("Expected a dictionary containing an image, but was provided the following : \(info)")
        }
        //Viw the image
        photoImageView.image = selectedImage
        //Dissmiss the picker.
        dismiss(animated: true, completion: nil)
        
        
        
    }
    //MARK: Actions
    @IBAction func selectImageFromPhotoLib(_ sender: UITapGestureRecognizer) {
        
        //Hide the kepad if user were typing something
        nameTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
        
        
        
    }
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text = "Set Default Meal"
    }
    
    
}

