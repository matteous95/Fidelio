//
//  viewProvinceController.swift
//  FidelioAPP
//
//  Created by Matteo on 26/08/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import UIKit

class viewProvinceController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate  {
    

    
     let searchController = UISearchController(searchResultsController: nil)
    var Province: [Provincia]? = []
    var ProvinceFiltrate: [Provincia]? = []
    
    private let clientProvince = ProvinceClient()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var navigatorProvince: UINavigationItem!
    @IBOutlet weak var searchProvincia: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchProvincia.delegate = self
        caricaProvince()

        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Cerca Province ..."
        navigatorProvince.searchController = searchController
        navigatorProvince.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true

        btnClose.setTitle("", for: .normal)
        btnClose.setImage(UIImage.init(icon: .ionicons(.close) , size: CGSize(width: 32, height: 32), textColor: UIColor.white), for: .normal)
        
        
        self.tableView.rowHeight = 40
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
                print(self?.Province as Any)
                self?.tableView.reloadData()
                
                
            case .failure(let error):
                print("the error \(error)")
                print("Accesso negato")
            }
            
        }
    }

    @IBAction func pressClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source


     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Province == nil {
            return 0
        }else{
            if searchBarIsEmpty() {
                return (Province?.count)!
            }else{
                return ProvinceFiltrate!.count
            }
        }
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //MATTEO: mi carico il modello di cella
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProvincia", for: indexPath) as! cellProvinceController
        if Province == nil { return cell }
        if  searchBarIsEmpty() == false  {
           cell.lblProvincia.text = (Province?[indexPath.row].provincia)!
            //cell.lblProvincia.text = (ProvinceFiltrate?[indexPath.row].provincia)!
        } else {
            cell.lblProvincia.text = (Province?[indexPath.row].provincia)!
        }
        
        return cell
    }
    
    // MARK: - Private instance methods

    
    func updateSearchResults(for searchController: UISearchController) {
        print("Sto per iniziare una ricerca")
    }
    
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchProvincia.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        ProvinceFiltrate = Province?.filter({( selProv : Provincia) -> Bool in
            return (selProv.provincia?.lowercased().contains(searchText.lowercased()))!
        })
        
        tableView.reloadData()
    }


    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        ProvinceFiltrate = Province?.filter({( selProv : Provincia) -> Bool in
            return (selProv.provincia?.lowercased().contains(searchText.lowercased()))!
        })
        print(ProvinceFiltrate as Any)
        tableView.reloadData()
    }
    

}
