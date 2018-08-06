//
//  AuthViewController.swift
//  FirebaseAuthApp-iOS
//
//  Created by Nobuhiro Takahashi on 2018/08/06.
//  Copyright © 2018年 Nobuhiro Takahashi. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import JGProgressHUD

class AuthViewController: UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        errorLabel.isHidden = true
    }
    
    @IBAction func signUpButtonWasTapped(_ sender: UIButton) {
        signUp()
    }
    
    @IBAction func signInButtonWasTapped(_ sender: UIButton) {
        signIn()
    }
    
    func signIn() {
        if mailTextField.text != nil && passwordTextField.text != nil {
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            
            Auth.auth().signIn(withEmail: mailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                hud.dismiss(afterDelay: 1.0)
                
                if error != nil {
                    print(error ?? "no error")
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = error?.localizedDescription
                }
                
                self.next()
            }
        } else {
            self.errorLabel.isHidden = false
            self.errorLabel.text = "メールアドレス・パスワードを確認してください"
        }
    }
    
    func signUp() {
        if mailTextField.text != nil && passwordTextField.text != nil {
            self.errorLabel.isHidden = true
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            
            Auth.auth().createUser(withEmail: mailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if error != nil {
                    print(error ?? "no error")
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = error?.localizedDescription
                    hud.dismiss(afterDelay: 1.0)
                }
                
                if user != nil {
                    print(user ?? "no user")
                    user!.user.sendEmailVerification(completion: { (error) in
                        hud.dismiss(afterDelay: 1.0)
                        if error != nil {
                            print(error ?? "no error")
                            self.errorLabel.isHidden = false
                            self.errorLabel.text = error?.localizedDescription
                        }
                        
                        self.next()
                    })
                    
                }
            }
        } else {
            self.errorLabel.isHidden = false
            self.errorLabel.text = "メールアドレス・パスワードを確認してください"
        }
    }
    
    func next(animated: Bool = true) {
        self.view.becomeFirstResponder()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
        self.present(vc!, animated: true, completion: nil)
    }
}
