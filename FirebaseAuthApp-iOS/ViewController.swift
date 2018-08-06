//
//  ViewController.swift
//  FirebaseAuthApp-iOS
//
//  Created by Nobuhiro Takahashi on 2018/08/06.
//  Copyright © 2018年 Nobuhiro Takahashi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        indicatorView.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var vc: UIViewController!
        if Auth.auth().currentUser != nil {
            print("Login: \(String(describing: Auth.auth().currentUser?.displayName))")
            
            vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
        } else {
            vc = self.storyboard?.instantiateViewController(withIdentifier: "AuthViewController")
        }
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: {
            self.indicatorView.stopAnimating()
        })
    }

}

