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
    
    @IBOutlet weak var txtNome: UILabel!
    @IBOutlet weak var txtCognome: UILabel!
    @IBOutlet weak var txtCell: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var txtCodFiscale: UILabel!
    @IBOutlet weak var txtDDN: UILabel!
    @IBOutlet weak var txtProvincia: UILabel!
    @IBOutlet weak var txtIndirizzo: UILabel!
    @IBOutlet weak var txtCitta: UILabel!
    @IBOutlet weak var txtCAP: UILabel!
    
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet weak var imgNominativi: UIImageView!
    @IBOutlet weak var imgContatti: UIImageView!
    @IBOutlet weak var imgAnagrafica: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgNominativi.image = UIImage.init(icon: .fontAwesome(.user), size: CGSize(width: 24, height: 24), textColor: AppColor.colorSelection())
        imgContatti.image = UIImage.init(icon: .fontAwesome(.envelope), size: CGSize(width: 24, height: 24), textColor: AppColor.colorSelection())
        imgAnagrafica.image = UIImage.init(icon: .fontAwesome(.addressCard), size: CGSize(width: 24, height: 24), textColor: AppColor.colorSelection())
        
        caricaOggetti(isNull: true)
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
                self?.caricaOggetti(isNull: false)
                
            case .failure(let error):
                print("the error \(error)")
                print("Accesso negato")
            }
            
        }
    }
    
    func caricaOggetti (isNull: Bool) {
        if isNull {
            txtNome.text = "-"
            txtCognome.text = "-"
            txtCell.text = "-"
            txtEmail.text = "-"
            txtCodFiscale.text = "-"
            txtDDN.text = "-"
            txtProvincia.text = "-"
            txtIndirizzo.text = "-"
            txtCitta.text = "-"
            txtCAP.text = "-"
        }else{
            if Cliente != nil {
                txtNome.text = Cliente?.nome!
                txtCognome.text = Cliente?.cognome!
                txtCell.text = Cliente?.cellulare!
                txtEmail.text = Cliente?.email!
                txtCodFiscale.text = Cliente?.c_fiscale!
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"// Your New Date format as per requirement change it own
                let strDN: String = dateFormatter.string(from: (Cliente?.data_nascita!)!)
                txtDDN.text = strDN
                txtProvincia.text = Cliente?.provincia!
                txtIndirizzo.text = Cliente?.indirizzo!
                txtCitta.text = Cliente?.citta!
                txtCAP.text = Cliente?.cap!
            }
        }
        
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
            let vc = segue.destination as! viewModificaClienteController
            vc.IDCliente = sender as? Int
        }
    }
    
}
