//
//  ViewController.swift
//  firebaseProject
//
//  Created by hildy abreu on 11/25/19.
//  Copyright © 2019 hildy abreu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func logInButton(_ sender: UIButton) {
        guard emailTF.hasText, passwordTF.hasText else {
             return
         }
         guard emailTF.text != "", passwordTF.text != "" else {
             return
         }
         guard let email = emailTF.text, let password =  passwordTF.text else {
             return
         }
        FirebaseAuthService.manager.loginUser(email: email, password: password) { (result) in
            switch result {
            case .success:
                guard let feedVC = self.storyboard?.instantiateViewController(identifier: "feedVC") as? FeedViewController else {
                    return
                }
                feedVC.modalPresentationStyle = .fullScreen
                self.present(feedVC, animated: true, completion: nil)
            case .failure:
                self.showAlert(with: "error", and: "Wrong Email or Password, Please try again")
            }
        }
    }
    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
   
    @IBAction func createButton(_ sender: UIButton) {
       guard let signUpVC = storyboard?.instantiateViewController(identifier: "signUpVC") as? SignUpViewController else {
                  return
              }
              present(signUpVC, animated: true, completion: nil)
    }
    
    
    
    
    

}

