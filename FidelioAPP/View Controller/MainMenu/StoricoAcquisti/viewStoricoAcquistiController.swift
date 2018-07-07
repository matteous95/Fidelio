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
     var currPageAcquisti: pageAcquisti?  //MATTEO: pagination corrente acquisti
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 50
        caricaAcquisti()
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //FUNZIONI WEB SERVICE ------------------------------------------------------
    func caricaAcquisti (numPage: Int? = nil) {
        client.getFeed(page: numPage ,from: .callAcquisti) { [weak self] result in
            
            switch result {
            case .success(let acquistiFeedResult):
                guard let acquistiResults = acquistiFeedResult else {
                    return
                }
                self?.currPageAcquisti = acquistiResults
                //MATTEO: dall'array di clienti che ottengo aggiungo ogni elemnto all'array di clienti collegati alla table view
                if  acquistiResults.risAcquisti?.results != nil {
                    for acquisto in  (acquistiResults.risAcquisti?.results)! {
                        self?.Acquisti?.append(acquisto)
                    }
                }
                self?.tableView.reloadData()
                
                //self?.Acquisti = acquistiResults.risAcquisti?.results?.sorted(by: {$0.data_acquisto! > $1.data_acquisto!})
                
                
            case .failure(let error):
                print("the error \(error)")
                print("Accesso negato")
            }
            
        }
    }
    //-------------------------------------------------------------------------



    //TABLE VIEW  -------------------------------------------------------


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Acquisti == nil {
            return 0
        }else{
            return (Acquisti?.count)!
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //MATTEO: controllo se sono arrivato alla fine dello scroll per collegare l'altra pagination
        if (indexPath.row + 1) == ((currPageAcquisti?.current_page)! * (currPageAcquisti?.per_page)!) {
            //MATTEO: controllo se sono nell'ultima page
            if currPageAcquisti?.last_page  != currPageAcquisti?.current_page {
                caricaAcquisti(numPage: (currPageAcquisti?.current_page)! + 1)
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAcquisti", for: indexPath) as! cellStoricoAcquisti
        //MATTEO: se sto filtrando la tabella prendo l'array di clienti dei filtri
        cell.imgIcona.image = UIImage.init(icon: .fontAwesome(.creditCard), size: CGSize(width: 24, height: 24), textColor: AppColor.colorSelection())
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let dataAcquisto = dateFormatterGet.string(from: (Acquisti?[indexPath.row].data_acquisto!)!)
        cell.lblData.text = dataAcquisto
        cell.lblCliente.text = (Acquisti?[indexPath.row].cliente?.cognome)! + " " + (Acquisti?[indexPath.row].cliente?.nome)!
        cell.lblImporto.text =  String(format: "%.2f", (Acquisti?[indexPath.row].importo)!) + " €"
        
        return cell
    }
    

   

}
