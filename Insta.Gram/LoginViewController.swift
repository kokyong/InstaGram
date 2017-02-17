//
//  ViewController.swift
//  Insta.Gram
//
//  Created by Kok Yong on 10/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit
import FirebaseAuth



class LoginViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    
    @IBOutlet weak var userButton: UIButton!{
        didSet {
            userButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        }
    }
    @IBAction func createAnAccountButton(_ sender: UIButton) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "CreateAccountViewController") as? CreateAccountViewController else {return}
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    /// Login Function
    func login() {
        
        FIRAuth.auth()?.signIn(withEmail: userEmail.text!, password: userPassword.text!, completion: { (user,error) in
            
            if error != nil {
                print(error! as NSError)

                return
            }
            
            guard let controller = UIStoryboard(name: "NewsFeed", bundle: Bundle.main).instantiateViewController(withIdentifier: "TimelineViewController") as?  TimelineViewController else { return }
            self.navigationController? .pushViewController(controller, animated: true)
      
        })
        func webViewDidStartLoad(_ webView: UIWebView) {
            self.activityLoader.startAnimating()
        }
        func webViewDidFinishLoad(_ webView: UIWebView) {
            self.activityLoader.stopAnimating()
            
        }

    }
    
    

    
}






   
