//
//  CreateAccountViewController.swift
//  Insta.Gram
//
//  Created by Seow Yung Hoe on 10/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth


class CreateAccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    var dbRef : FIRDatabaseReference!
    var selectedImage : UIImage?
    
    //Outlet
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userUsernameField: UITextField!
    @IBOutlet weak var userEmailField: UITextField!
    
    @IBOutlet weak var userPasswordField: UITextField!
    
    @IBOutlet weak var userDescriptionField: UITextField!
    
    @IBOutlet weak var userSelectPicture: UIButton!{
        didSet{
            userSelectPicture.addTarget(self, action: #selector(displayImagePicker), for: .touchUpInside)
        }
        
    }
    
    //Action
    
    @IBAction func userSignUpPress(_ sender: UIButton) {
            
        createAccount()
    }
    
    func createAccount() {
        
        guard let email = userEmailField.text,
            let password = userPasswordField.text,
            let username = userUsernameField.text,
            let description = userDescriptionField.text else{
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user,error) in
            
            if error != nil{
                print (error! as NSError)
                return
            }
            
            
            //send infromation to database
            let ref = FIRDatabase.database().reference()
            let value = ["username": username, "email": email, "description": description] as [String : Any]
            let uid = FIRAuth.auth()?.currentUser?.uid
            ref.child("users").child(uid!).updateChildValues(value, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print("err")
                    return
                }
                self.handleUser(user: user!)
            })
            
            
            
        })
    }
    
    func handleUser(user: FIRUser) {
        print("User found: \(user.uid)")
        
        uploadImage(image: userImageView.image!)
        
        guard let controller = UIStoryboard(name: "Auth", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as?  LoginViewController else { return }
        navigationController? .pushViewController(controller, animated: true)
    }
 
    var userStorage: FIRStorageReference!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        dbRef = FIRDatabase.database().reference()
        let storage = FIRStorage.storage().reference(forURL: "gs://instagram-6de25.appspot.com")
        userStorage = storage.child("users")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func displayImagePicker(){
        
        let pickerViewController = UIImagePickerController ()
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            pickerViewController.sourceType = .photoLibrary
            
        }
        
        pickerViewController.delegate = self
        
        present(pickerViewController, animated: true, completion: nil)
    }
  
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            setProfileImage(image : image)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func setProfileImage(image : UIImage) {
        userImageView.image = image
    }

    func uploadImage(image: UIImage){
    
        // create the Data from UIImage
        guard let imageData = UIImageJPEGRepresentation(image, 0.0) else { return }
    
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        let uid = FIRAuth.auth()?.currentUser?.uid
        let storageRef = FIRStorage.storage().reference()
        storageRef.child("folder").child("\(uid!).jpeg").put(imageData, metadata: metadata) { (meta, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
            
                if let downloadURL = meta?.downloadURL() {
                    //got image url
                    self.dbRef.child("users").child(uid!).updateChildValues(["profileURL":downloadURL.absoluteString])
                }
            
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    func showErrorAlert(errorMessage: String){
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle:  .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
    }
    
}
