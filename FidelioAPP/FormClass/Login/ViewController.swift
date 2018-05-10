//
//  ViewController.swift
//  FidelioAPP
//
//  Created by Matteo on 26/04/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "daLogin", sender: nil)
    }
    
}

