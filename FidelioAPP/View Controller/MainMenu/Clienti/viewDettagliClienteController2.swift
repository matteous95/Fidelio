//
//  viewDettagliClienteController.swift
//  FidelioAPP
//
//  Created by Matteo on 27/05/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import UIKit

class viewDettagliClienteController: UIViewController{

    var IDCliente: Int?
    private let client = ClienteClient()
    var Cliente: Cliente?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(IDCliente)
        caricaCliente()

        // Do any additional setup after loading the view.
    }

    func caricaCliente () {
        if IDCliente == nil {
            return
        }
        let strID = String(IDCliente!)
        client.getFeed(paramID: strID,from: .callCliente) { [weak self] result in
            
            switch result {
            case .success(let clienteFeedResult):
                guard let clienteResults = clienteFeedResult else {
                    return
                }
                print(clienteResults)
                print(clienteResults.cognome)
                self?.Cliente = clienteResults
                //self?.tableView.reloadData()
                
                
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
    
/*
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (Cliente?.numKey)!
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCliente", for: indexPath) as! viewDettaglioClienteCell
        if Cliente == nil {
            cell.lblDescrizione.text = ""
            cell.txtValore.text = ""
            return cell
        }
        switch indexPath.row{
        case 0:
            cell.lblDescrizione.text = "Nome:"
            cell.txtValore.text = Cliente?.nome!
        case 1:
            cell.lblDescrizione.text = "Cognome:"
            cell.txtValore.text = Cliente?.cognome!
        case 2:
            cell.lblDescrizione.text = "Cellulare:"
            cell.txtValore.text = Cliente?.cellulare!
        case 3:
            cell.lblDescrizione.text = "Email:"
            cell.txtValore.text = Cliente?.email!
        case 4:
            cell.lblDescrizione.text = "CF:"
            cell.txtValore.text = Cliente?.c_fiscale!
        case 5:
            cell.lblDescrizione.text = "Data Nascita:"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"// Your New Date format as per requirement change it own
            let strDN: String = dateFormatter.string(from: (Cliente?.data_nascita!)!)
            cell.txtValore.text = strDN
        case 6:
            cell.lblDescrizione.text = "Indirizzo:"
            cell.txtValore.text = Cliente?.indirizzo!
        case 7:
            cell.lblDescrizione.text = "Citta:"
            cell.txtValore.text = Cliente?.citta!
        case 8:
            cell.lblDescrizione.text = "Provincia:"
            cell.txtValore.text = Cliente?.provincia!
        case 9:
            cell.lblDescrizione.text = "Cap:"
            cell.txtValore.text = Cliente?.cap!
        default:
            cell.lblDescrizione.text = ""
            cell.txtValore.text = ""
        }
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(Clienti?[indexPath.row].id as Any)
        //performSegue(withIdentifier: "toDettagliCliente", sender: (Clienti?[indexPath.row].id) )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*if segue.identifier == "toDettagliCliente"{
            let vc = segue.destination as! viewDettagliClienteController
            vc.IDCliente = sender as? Int
        }*/
    }
*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
