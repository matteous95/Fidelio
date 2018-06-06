//
//  viewClientiController.swift
//  FidelioAPP
//
//  Created by Matteo on 28/04/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import UIKit


class viewClientiController: UITableViewController  {
    let searchController = UISearchController ( searchResultsController : nil )
    private let client = ClientiClient()
    var Clienti : [Cliente]? = []
    var filteredClienti = [Cliente] ()

    @IBOutlet var tableViewClienti: UITableView!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Cerca Cliente"
        navigationItem.searchController = searchController

        tableViewClienti.rowHeight = 50
        caricaClienti()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
 
    //FUNZIONI WEB SERVICE ------------------------------------------------------
    func caricaClienti () {
        client.getFeed(from: .callClienti) { [weak self] result in
            
            switch result {
            case .success(let clientiFeedResult):
                guard let clientiResults = clientiFeedResult else {
                    return
                }
                print(clientiResults.results?.count as Any)
                self?.Clienti = clientiResults.results?.sorted(by: {$0.cognome! < $1.cognome!})
                print(self?.Clienti)
                self?.tableView.reloadData()
        
            case .failure(let error):
                print("the error \(error)")
                print("Accesso negato")
            }
            
        }
    }
    //-------------------------------------------------------------------------
    


   
    //SERACH CONTROLLER  -------------------------------------------------
    func  searchBarIsEmpty () -> Bool {
        // Restituisce true se il testo è vuoto o nil
        return searchController.searchBar.text? .isEmpty ?? true
    }
    
    func  filterContentForSearchText ( _ searchText: String, scope: String = "All" ) {
        filteredClienti = Clienti!.filter ({(cliente: Cliente ) -> Bool  in
            return (cliente.cognome?.lowercased ().contains (searchText.lowercased ()))!
        })
        
        tableView.reloadData ()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    //--------------------------------------------------------------------
    

    
    
    //TABLE VIEW  -------------------------------------------------------
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredClienti.count
        }
        return (Clienti?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCliente", for: indexPath) as! cellClientiController
        //MATTEO: se sto filtrando la tabella prendo l'array di clienti dei filtri
        if isFiltering() {
            cell.lblRagSociale.text = (filteredClienti[indexPath.row].cognome)! + " " + (filteredClienti[indexPath.row].nome)!
            cell.lblEmail.text = (filteredClienti[indexPath.row].email)!
        } else {
            cell.lblRagSociale.text = (Clienti?[indexPath.row].cognome)! + " " + (Clienti?[indexPath.row].nome)!
            cell.lblEmail.text = (Clienti?[indexPath.row].email)!
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(Clienti?[indexPath.row].id as Any)
        if isFiltering() {
               performSegue(withIdentifier: "toDettaglioCliente", sender: (filteredClienti[indexPath.row].id) )
        } else {
               performSegue(withIdentifier: "toDettaglioCliente", sender: (Clienti?[indexPath.row].id) )
        }

    }
    //--------------------------------------------------------------------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDettaglioCliente"{
            let vc = segue.destination as! viewDettaglioClienteController
            vc.currIDCliente = sender as? Int
            print(vc.currIDCliente as Any)
        }
    }
   
    

}

extension  viewClientiController : UISearchResultsUpdating  {
    // MARK: - UISearchResultsUpdating Delegato
    func  updateSearchResults ( for searchController: UISearchController) {
        filterContentForSearchText (searchController.searchBar.text!)
    }
}
