//
//  SignInVC.swift
//  Plink
//
//  Created by Kirk Washam on 9/15/16.
//  Copyright © 2016 StudioATX. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnPressed(_ sender: AnyObject) {
        
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { ( result, error) in
            
            if error != nil {
                print("KIRK: Unable To Authenticate with Facebook - \(error)")
            }else if result?.isCancelled == true {
                print("KIRK: User Cancelled Facebook Auth")
            }else {
                print("KIRK: Successfully Authenticated with facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("KIRK: User Unable to Authenticate with Firebase -> \(error)")
            }else {
                print("KIRK: Successfully logged in with Firebase")
            }
        })
    }
    
    
}







