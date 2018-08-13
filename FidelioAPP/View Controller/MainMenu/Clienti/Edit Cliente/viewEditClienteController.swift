//
//  viewEditClienteController.swift
//  FidelioAPP
//
//  Created by Matteo on 01/08/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import UIKit

class viewEditClienteController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    var IDCliente: Int?
    private let client = ClienteClient()
    private let clientProvince = ProvinceClient()
    var Cliente: Cliente?
    var Province: [Provincia]? = []
    
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        caricaProvince()
        
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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func caricaProvince () {
        clientProvince.getFeed(from: .callProvince) { [weak self] result in
            
            switch result {
            case .success(let provinceFeedResult):
                guard let provinceResults = provinceFeedResult else {
                    return
                }
                self?.Province = provinceResults.results
                print(self?.Province)
                
                
            case .failure(let error):
                print("the error \(error)")
                print("Accesso negato")
            }
            
        }
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
                
                
            case .failure(let error):
                print("the error \(error)")
                print("Accesso negato")
            }
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        /*if Cliente?.numKey == nil {
            return  0
        }else{
            return  (Cliente?.numKey)!
        }*/
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellEditCliente", for: indexPath) as! cellEditClienteController
        
        switch indexPath.row{
        case 0:
            cell.lblDescrizione.text = "Nome:"
            cell.txtValore.placeholder = "Nome"
            cell.txtValore.text = Cliente != nil ? Cliente?.nome! : ""
            
        case 1:
            cell.lblDescrizione.text = "Cognome:"
            cell.txtValore.placeholder = "Cognome"
            cell.txtValore.text = Cliente != nil ? Cliente?.cognome! : ""
            
        case 2:
            cell.lblDescrizione.text = "Cellulare:"
            cell.txtValore.placeholder = "Cellulare"
            cell.txtValore.text  = Cliente != nil ? Cliente?.cellulare! : ""
            
        case 3:
            cell.lblDescrizione.text = "Email:"
            cell.txtValore.placeholder = "Email"
            cell.txtValore.text = Cliente != nil ? Cliente?.email! : ""
            
        case 4:
            cell.lblDescrizione.text = "Codice Fiscale:"
            cell.txtValore.placeholder = "Codice Fiscale"
            cell.txtValore.text = Cliente != nil ? Cliente?.c_fiscale! : ""
            
        case 5:
            cell.lblDescrizione.text = "Data Nascita:"
            cell.txtValore.placeholder = "Data Nascita"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"// Your New Date format as per requirement change it own
            if Cliente != nil {
                let strDN: String = dateFormatter.string(from: (Cliente?.data_nascita!)!)
                cell.txtValore.text = strDN
            }else{
                cell.txtValore.text = ""
            }
        case 6:
            cell.lblDescrizione.text = "Indirizzo:"
            cell.txtValore.placeholder = "Indirizzo"
            cell.txtValore.text = Cliente != nil ? Cliente?.indirizzo! : ""
            
        case 7:
            cell.lblDescrizione.text = "Citta:"
            cell.txtValore.placeholder = "Citta"
            cell.txtValore.text = Cliente != nil ? Cliente?.citta! : ""
            
        case 8:
            cell.lblDescrizione.text = "Provincia:"
            cell.txtValore.placeholder = "Provincia"
            cell.txtValore.text = Cliente != nil ? Cliente?.provincia! : ""
            
        case 9:
            cell.lblDescrizione.text = "Cap:"
            cell.txtValore.placeholder = "Cap"
            cell.txtValore.text = Cliente != nil ? Cliente?.cap! : ""
            
        default:
            cell.lblDescrizione.text = ""
            cell.txtValore.text = ""
            
        }
        
        return cell
    }
    
    @IBAction func pressClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressSave(_ sender: Any) {
    }
    


}
