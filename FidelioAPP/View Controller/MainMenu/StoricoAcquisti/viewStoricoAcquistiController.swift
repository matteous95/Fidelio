//
//  viewRiepilogoAcquisti.swift
//  FidelioAPP
//
//  Created by Matteo on 01/06/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import UIKit
import SwiftIcons

class viewStoricoAcquistiController: UITableViewController {
    private let client = AcquistiClient()
    var Acquisti : [Acquisto]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 50
        //caricaAcquisti()
 
    }
    
    func caricaAcquisti () {
        client.getFeed(from: .callClienteAcquisti) { [weak self] result in
            
            switch result {
            case .success(let acquistiFeedResult):
                guard let acquistiResults = acquistiFeedResult else {
                    return
                }
                print(acquistiResults.results?.count as Any)
                self?.Acquisti = acquistiResults.results?.sorted(by: {$0.data_acquisto! > $1.data_acquisto!})
                print(self?.Acquisti)
                self?.tableView.reloadData()
                
            case .failure(let error):
                print("the error \(error)")
                print("Accesso negato")
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

   

}
