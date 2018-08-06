//
//  HomeViewController.swift
//  FirebaseAuthApp-iOS
//
//  Created by Nobuhiro Takahashi on 2018/08/06.
//  Copyright © 2018年 Nobuhiro Takahashi. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController {
    
    
    
    @IBAction func signOutButtonWasTapped(_ sender: UIButton) {
        signOut()
        dismiss(animated: true, completion: nil)
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
