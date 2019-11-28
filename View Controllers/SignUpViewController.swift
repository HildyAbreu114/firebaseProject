//
//  SignUpViewController.swift
//  firebaseProject
//
//  Created by hildy abreu on 11/26/19.
//  Copyright © 2019 hildy abreu. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

  
    @IBOutlet weak var emailTF: UITextField!
    
    
    @IBOutlet weak var passwordTF: UITextField!
    
    
    
    @IBAction func createButton(_ sender: UIButton) {
        handleSignup()
    }
    
    
    
    
    @IBAction func existingAccount(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func handleSignup() {
        guard emailTF.hasText, passwordTF.hasText else {
            return
        }
        guard emailTF.text != "", passwordTF.text != "" else {
            return
        }
        guard let email = emailTF.text, let password =  passwordTF.text else {
            return
        }
        FirebaseAuthService.manager.createNewUser(email: email, password: password) { (result) in
            self.handleCreatingAppUser(result: result)
        }
    }
    func handleCreatingAppUser(result:Result<User, Error>){
        switch result {
        case .success(let user):
            FirestoreService.manager.createAppUser(user: AppUser(from: user)) { (newUser) in
                
                guard FirebaseAuthService.manager.currentUser != nil else {
                    return
                }
                guard let feedVC = self.storyboard?.instantiateViewController(identifier: "feedVC") as? FeedViewController else {
                    return
                }
                feedVC.modalPresentationStyle = .fullScreen
                self.present(feedVC, animated: true, completion: nil)
            }
        case .failure(let error):
            print (error)
        
        }
    }
    
    
    
}
