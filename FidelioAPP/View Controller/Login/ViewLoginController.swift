//
//  ViewController.swift
//  FidelioAPP
//
//  Created by Matteo on 26/04/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import UIKit
import NotificationBannerSwift


class ViewLoginController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    private let client = LoginClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressLogin(_ sender: Any) {

        if txtEmail.text == nil || txtEmail.text == "" || txtPassword.text == nil || txtPassword.text == "" {
            let leftView = UIImageView(image: UIImage.init(icon: .fontAwesome(.warning), size: CGSize(width: 24, height: 24), textColor: UIColor.white))
            let banner = NotificationBanner(title: "ATTENZIONE!", subtitle: "Inserire le credenziali !", leftView: leftView, style: .warning)
            banner.show()
            print("Inserire le credenziali prima di effettuare l'accesso!")
            effettuaLogin()
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
                LocalStorage.setLocalToken(token: loginResults.token!)
                self!.performSegue(withIdentifier: "daLogin", sender: nil)
                
                
            case .failure(let error):
                print("the error \(error)")
                print("Accesso negato")
                let leftView = UIImageView(image: UIImage.init(icon: .fontAwesome(.warning), size: CGSize(width: 24, height: 24), textColor: UIColor.white))
                let banner = NotificationBanner(title: "Accesso negato!", subtitle: "the error \(error)", leftView: leftView, style: .danger)
                banner.show()
                print("errore!")
            }
            
        }
    }
}

