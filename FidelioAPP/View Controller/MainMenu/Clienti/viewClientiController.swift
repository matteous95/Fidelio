//
//  viewClientiController.swift
//  FidelioAPP
//
//  Created by Matteo on 28/04/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import UIKit


class viewClientiController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate  {

    let searchController = UISearchController ( searchResultsController : nil )
    private let client = ClientiClient()
    var Clienti : [Cliente]? = []
    var currPageClienti: pageClienti?  //MATTEO: pagination corrente clienti
    var filtroCorrente: String?

    @IBOutlet var tableViewClienti: UITableView!
    @IBOutlet weak var navigatorClienti: UINavigationItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchControll()
        tableViewClienti.rowHeight = 50
        caricaClienti()
    }
    
    func setSearchControll() {
        // Imposta il Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor.white
        searchController.searchBar.barStyle = .black
        searchController.searchBar.placeholder = "Cerca Clienti ..."
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

    
    //FUNZIONI WEB SERVICE ------------------------------------------------------
    func caricaClienti (numPage: Int? = nil, search: String? = nil) {
        //MATTEO: carico i parametri che devo passare al ws
        let paramURL = ParametriUrl(token: LocalStorage.getLocalToken()!, page: numPage, search: search)
        client.getFeed(parametriURL: paramURL, from: .callClienti) { [weak self] result in
            
            switch result {
            case .success(let clientiFeedResult):
                guard let clientiResults = clientiFeedResult else {
                    return
                }
                //MATTEO: quando vengo da una ricerca inizializzo le variabili clienti
                if search != nil {
                    self?.currPageClienti = nil
                    self?.Clienti = []
                }
                print(self?.Clienti?.count as Any)
                self?.currPageClienti = clientiResults
                //MATTEO: dall'array di clienti che ottengo aggiungo ogni elemnto all'array di clienti collegati alla table view
                if  clientiResults.risClienti?.results != nil {
                    for cliente in  (clientiResults.risClienti?.results)! {
                        self?.Clienti?.append(cliente)
                    }
                }
                self?.tableView.reloadData()
        
            case .failure(let error):
                print("the error \(error)")
                print("Accesso negato")
            }
            
        }
    }
    //-------------------------------------------------------------------------
    
   //SEARCH CONTROLL  -------------------------------------------------------

    //MATTEO: se scrollo in alto faccio vedere il search controll se scorro in basso lo nascondo
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if targetContentOffset.pointee.y < scrollView.contentOffset.y {
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
        
    }
    
    //MATTEO: funzione per quando modifico il testo della search
    func updateSearchResults(for searchController: UISearchController) {
        loadFilterTable(filterText: searchController.searchBar.text)
    }
    
    //MATTEO: in base alla text della search chiamo il ws per caricare la table
    func loadFilterTable(filterText: String?) {
        // MATTEO: vedo se il text del search è vuoto
        if filterText == "" || filterText == nil {
            //MATTEO: se è vuoto carico tutti i clienti come se fosse la load
            filtroCorrente = nil
            caricaClienti()
        } else {
            //MATTEO: se è popolato inizio a caricare la tableview con il filtro
            filtroCorrente = filterText
            caricaClienti(search: filtroCorrente)
        }
        
       
    }
   //---------------------------------------------------------------------
    
    
    //TABLE VIEW  -------------------------------------------------------
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Clienti == nil {
            return 0
        }else{
            return (Clienti?.count)!
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //MATTEO: mi carico il modello di cella
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCliente", for: indexPath) as! cellClientiController
        
        if currPageClienti == nil { return cell }
        //MATTEO: controllo se sono arrivato alla fine dello scroll per collegare l'altra pagination
        if (indexPath.row + 1) == ((currPageClienti?.current_page)! * (currPageClienti?.per_page)!) {
            //MATTEO: controllo se sono nell'ultima page
            if currPageClienti?.last_page  != currPageClienti?.current_page {
                caricaClienti(numPage: (currPageClienti?.current_page)! + 1, search: filtroCorrente)
            }
        }

        cell.lblRagSociale.text = (Clienti?[indexPath.row].cognome)! + " " + (Clienti?[indexPath.row].nome)!
        cell.lblEmail.text = (Clienti?[indexPath.row].email)!
        cell.imgIcona.image = UIImage.init(icon: .fontAwesome(.user), size: CGSize(width: 24, height: 24), textColor: AppColor.colorSelection())
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
               performSegue(withIdentifier: "toDettaglioCliente", sender: (Clienti?[indexPath.row].id) )
    }
    
    
    //--------------------------------------------------------------------
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDettaglioCliente"{
            let vc = segue.destination as! viewDettaglioClienteController
            vc.currIDCliente = sender as? Int
        }
    }
   
    

}


