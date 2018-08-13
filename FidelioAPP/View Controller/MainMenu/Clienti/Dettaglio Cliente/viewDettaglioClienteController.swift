//
//  viewDettaglioClienteController.swift
//  FidelioAPP
//
//  Created by Matteo on 29/05/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import UIKit
import SwiftIcons

class viewDettaglioClienteController: UITableViewController {
    var currIDCliente: Int?
    private let client = ClienteClient()
    var Cliente: Cliente?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        caricaCliente()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func caricaCliente () {
        if currIDCliente == nil {
            return
        }
        let strID = [String(currIDCliente!)]
        client.getFeed(paramID: strID,from: .callCliente) { [weak self] result in
            
            switch result {
            case .success(let clienteFeedResult):
                guard let clienteResults = clienteFeedResult else {
                    return
                }
                self?.Cliente = clienteResults
                self?.tableView.reloadData()
                
                
            case .failure(let error):
                print("the error \(error)")
                print("Accesso negato")
            }
            
        }
    }

    // MARK: - Table view data source
   override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        }else{
            return 50
        }
    
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if Cliente?.numKey == nil {
            return  0
        }else{
            return  (Cliente?.numKey)! + 1 //MATTEO: +1 perchè aggiungo la cella del qr code
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCliente", for: indexPath) as! cellDettaglioClienteController
        if Cliente == nil {
            return cell
        }
        cell.txtValore.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 50)
        switch indexPath.row{
        case 0:
                let cellQRC = tableView.dequeueReusableCell(withIdentifier: "cellQRCode", for: indexPath) as! cellQRCodeClienteController
                return cellQRC
            
        case 1:
                cell.imgIcon.image = UIImage.init(icon: .fontAwesome(.user), size: CGSize(width: 24, height: 24), textColor: AppColor.colorSelection())
                cell.lblDescrizione.text = "Nome:"
                cell.txtValore.text = Cliente?.nome!
        case 2:

                cell.lblDescrizione.text = "Cognome:"
                cell.txtValore.text = Cliente?.cognome!

        case 3:

                cell.imgIcon.image = UIImage.init(icon: .fontAwesome(.phone), size: CGSize(width: 24, height: 24), textColor: AppColor.colorSelection())
                cell.lblDescrizione.text = "Cellulare:"
                cell.txtValore.text = Cliente?.cellulare!

        case 4:

                cell.imgIcon.image = UIImage.init(icon: .fontAwesome(.envelope), size: CGSize(width: 24, height: 24), textColor: AppColor.colorSelection())
                cell.lblDescrizione.text = "Email:"
                cell.txtValore.text = Cliente?.email!

        case 5:

                cell.imgIcon.image = UIImage.init(icon: .fontAwesome(.addressCard), size: CGSize(width: 24, height: 24), textColor: AppColor.colorSelection())
                cell.lblDescrizione.text = "CF:"
                cell.txtValore.text = Cliente?.c_fiscale!

        case 6:

                cell.lblDescrizione.text = "Data Nascita:"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"// Your New Date format as per requirement change it own
                let strDN: String = dateFormatter.string(from: (Cliente?.data_nascita!)!)
                cell.txtValore.text = strDN

        case 7:

                cell.lblDescrizione.text = "Indirizzo:"
                cell.txtValore.text = Cliente?.indirizzo!

        case 8:

                cell.lblDescrizione.text = "Citta:"
                cell.txtValore.text = Cliente?.citta!

        case 9:

                cell.lblDescrizione.text = "Provincia:"
                cell.txtValore.text = Cliente?.provincia!

        case 10:

                cell.lblDescrizione.text = "Cap:"
                cell.txtValore.text = Cliente?.cap!

        default:

                cell.lblDescrizione.text = ""
                cell.txtValore.text = ""

        }
        
        return cell
    }
    

    @IBAction func pressBtnModifica(_ sender: Any) {
        performSegue(withIdentifier: "toEditCliente", sender: currIDCliente )
    }
    
    
    @IBAction func pressBtnAcquisti(_ sender: Any) {
        performSegue(withIdentifier: "toAcquistiCliente", sender: currIDCliente )
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAcquistiCliente"{
             let vc = segue.destination as! viewClienteAcquistiController
             vc.IDCliente = sender as? Int
         }
        
        if segue.identifier == "toEditCliente"{
            let vc = segue.destination as! viewEditClienteController
            vc.IDCliente = sender as? Int
        }
    }
    
}
