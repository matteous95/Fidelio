//
//  cellEditClienteController.swift
//  FidelioAPP
//
//  Created by Matteo on 01/08/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import UIKit

class cellEditClienteController: UITableViewCell {

    @IBOutlet weak var lblDescrizione: UILabel!
    @IBOutlet weak var txtValore: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
