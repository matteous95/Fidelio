//
//  ViewController.swift
//  FidelioAPP
//
//  Created by Matteo on 26/04/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import UIKit



class ViewLoginController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    private let client = LoginClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let strToken = LocalToken.getLocalToken() {
            print(strToken)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressLogin(_ sender: Any) {
        if txtEmail.text == nil || txtEmail.text == "" || txtPassword.text == nil || txtPassword.text == "" {
            print("Inserire le credenziali prima di effettuare l'accesso!")
            effettuaLogin()
            print("1")
        }else{
            effettuaLogin()
        }
        
    }
    
    
    func effettuaLogin () {
        let getParametri: [String: String]? = ["email": "acmesrl@test.com" , "password" : "password"]
        //let getParametri: [String: String]? = ["email": txtEmail.text! , "password" : txtPassword.text!]
        client.getFeed(parametres: getParametri,from: .callLogin) { [weak self] result in
            
            switch result {
            case .success(let loginFeedResult):
                guard let loginResults = loginFeedResult else {
                    return
                }
                print(loginResults.token!)
                LocalToken.setLocalToken(token: loginResults.token!)
                if let strToken = LocalToken.getLocalToken(){
                    print(strToken)
                }
                self!.performSegue(withIdentifier: "daLogin", sender: nil)
                
                
            //print(loginResults.first?.token)
            case .failure(let error):
                print("the error \(error)")
                print("Accesso negato")
            }
            
        }
    }
}

