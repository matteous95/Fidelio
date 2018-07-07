//
//  viewClienteAcquistiController.swift
//  FidelioAPP
//
//  Created by Matteo on 02/06/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import UIKit
import SwiftIcons

class viewClienteAcquistiController: UITableViewController {
    private let client = ClienteAcquistiClient()
    var Acquisti : [Acquisto]? = []
    var IDCliente: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 50
        caricaAcquistiCliente()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func caricaAcquistiCliente () {
        let strID = [String(IDCliente!)]
        client.getFeed(paramID: strID, from: .callClienteAcquisti) { [weak self] result in
            
            switch result {
            case .success(let acquistiFeedResult):
                guard let acquistiResults = acquistiFeedResult else {
                    return
                }
                self?.Acquisti = acquistiResults.results?.sorted(by: {$0.data_acquisto! > $1.data_acquisto!})
                self?.tableView.reloadData()
                
            case .failure(let error):
                print("the error \(error)")
                print("Accesso negato")
            }
            
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if Acquisti == nil {
                return 0
            }else{
                return (Acquisti?.count)!
            }
        }

       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellAcquistiCli", for: indexPath) as! cellClienteAcquistiController
            if Acquisti == nil {
                return cell
            }
        
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "dd-MM-yyyy HH:mm:ss"
            let dataAcquisto = dateFormatterGet.string(from: (Acquisti?[indexPath.row].data_acquisto!)!)
            cell.lblData.text = dataAcquisto
            cell.imgIcon.image = UIImage.init(icon: .fontAwesome(.creditCard), size: CGSize(width: 24, height: 24), textColor: AppColor.colorSelection())
        
            cell.lblImporto.text =  String(format: "%.2f", (Acquisti?[indexPath.row].importo)!) + " €"

            return cell
        }
        
   


}
