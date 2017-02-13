//
//  EditProfileViewController(Extension).swift
//  Insta.Gram
//
//  Created by Kok Yong on 13/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage

extension EditProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]){
        
        
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            
            print(editedImage)
           // uploadImage(image: editedImage)
            
        }else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            print(originalImage)
            //uploadImage(image: originalImage)
            
        }
        
        dismiss(animated: true, completion: nil)
        
    }

    
    
    
}

