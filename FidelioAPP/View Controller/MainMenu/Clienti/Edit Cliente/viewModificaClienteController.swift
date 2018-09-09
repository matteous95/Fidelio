//
//  viewModificaClienteController.swift
//  FidelioAPP
//
//  Created by Matteo on 13/08/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import UIKit

class viewModificaClienteController: UITableViewController {
    var IDCliente: Int?
    private let client = ClienteClient()
    private let clientUpdateCliente = ClienteUpdateClient()
    var Cliente: Cliente?
    
    
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var txtProvincia: UITextField!
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtCognome: UITextField!
    @IBOutlet weak var txtCellulare: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtCF: UITextField!
    @IBOutlet weak var txtDDN: UITextField!
    @IBOutlet weak var txtIndirizzo: UITextField!
    @IBOutlet weak var txtCitta: UITextField!
    @IBOutlet weak var txtCAP: UITextField!
    @IBOutlet weak var imgSearchProvincia: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgSearchProvincia.image = UIImage.init(icon: .fontAwesome(.search), size: CGSize(width: 16, height: 16), textColor: UIColor.lightGray)
        
        btnClose.setTitle("", for: .normal)
        btnClose.setImage(UIImage.init(icon: .ionicons(.close) , size: CGSize(width: 32, height: 32), textColor: AppColor.colorSelection()), for: .normal)
        tableView.rowHeight = 70
        //MATTEO: se currIDCliente è nil vuol dire che stio creando un nuovo cliente
        if self.IDCliente == nil {
            navigationTitle.title = "Nuovo Cliente"
        }else{
            navigationTitle.title = "Modifica Cliente"
            caricaCliente()
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func caricaCliente () {
        if IDCliente == nil {
            return
        }
        let strID = [String(IDCliente!)]
        client.getFeed(paramID: strID,from: .callCliente) { [weak self] result in
            
            switch result {
            case .success(let clienteFeedResult):
                guard let clienteResults = clienteFeedResult else {
                    return
                }
                self?.Cliente = clienteResults
                self?.tableView.reloadData()
                self?.caricaOggetti()
                
            case .failure(let error):
                print("the error \(error)")
                print("Accesso negato")
            }
            
        }
    }
    
    func updateCliente(clienteUpdate: Cliente?) {
        clientUpdateCliente.getFeed(clienteModificato: clienteUpdate ,from: .callClienti) { [weak self] result in
            
            switch result {
            case .success(let clienteFeedResult):
                guard let clienteResults = clienteFeedResult else {
                    return
                }
                self?.Cliente = clienteResults
                self?.tableView.reloadData()
                self?.caricaOggetti()
                
            case .failure(let error):
                print("the error \(error)")
                print("Accesso negato")
            }
            
        }
    }
    
    func caricaOggetti () {
        if Cliente != nil {
            txtNome.text = Cliente?.nome!
            txtCognome.text = Cliente?.cognome!
            txtCellulare.text = Cliente?.cellulare!
            txtEmail.text = Cliente?.email!
            txtCF.text = Cliente?.c_fiscale!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"// Your New Date format as per requirement change it own
            let strDN: String = dateFormatter.string(from: (Cliente?.data_nascita!)!)
            txtDDN.text = strDN
            txtIndirizzo.text = Cliente?.indirizzo!
            txtCitta.text = Cliente?.citta!
            txtProvincia.text = Cliente?.provincia
            txtCAP.text = Cliente?.cap!
        }
        
    }
    
    
    @IBAction func pressClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressSave(_ sender: Any) {
        updateCliente(clienteUpdate: getUpdateCliente())
    }
    
    
    func getUpdateCliente() -> Cliente {
        var ClienteUpdate = Cliente
        ClienteUpdate?.id = self.Cliente?.id
        ClienteUpdate?.user_id = self.Cliente?.user_id
        ClienteUpdate?.nome = txtNome.text
        ClienteUpdate?.cognome = txtCognome.text
        ClienteUpdate?.c_fiscale = txtCF.text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"// Your New Date format as per requirement change it own
        let strDN: Date = dateFormatter.date(from: txtDDN.text!)!
        ClienteUpdate?.data_nascita = strDN
        ClienteUpdate?.indirizzo = txtIndirizzo.text
        ClienteUpdate?.citta = txtCitta.text
        ClienteUpdate?.provincia = txtProvincia.text
        ClienteUpdate?.cap = txtCAP.text
        ClienteUpdate?.cellulare = txtCellulare.text
        ClienteUpdate?.email = txtEmail.text
        print(ClienteUpdate as Any)
    
        return ClienteUpdate!
    }
    
}
