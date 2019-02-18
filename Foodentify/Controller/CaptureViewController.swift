//
//  Capture View Controller.swift
//  Foodentify
//
//  Created by Wayne Yu on 12/6/18.
//  Copyright © 2018 Wayne Yu. All rights reserved.
//

import Foundation
import UIKit

class CaptureViewController : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var imagePicker: UIImagePickerController!
    let cache = ImageCache.shared
    var imageChosen = false
    
    override func viewDidLoad() {
        print("Loaded Capture VC")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.isBeingPresented || self.isMovingToParent || !imageChosen {
            // Perform an action that will only be done once
            imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Choose Photo", style: .default) { _ in
                self.imagePicker.sourceType = .photoLibrary
                self.present(self.imagePicker, animated: true, completion: nil)
            })
            
            alert.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            })
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageChosen = true
        imagePicker.dismiss(animated: true, completion: {
            print("DISMISSED")
            let newImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage?
            self.cache["food"] = newImage
            self.performSegue(withIdentifier: "toDisplayVC", sender: self)
        })
    }
}
