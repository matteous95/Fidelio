//
//  viewDettaglioClienteCell.swift
//  FidelioAPP
//
//  Created by Matteo on 27/05/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import UIKit

class cellDettaglioClienteController: UITableViewCell {
    @IBOutlet weak var lblDescrizione: UILabel!
    @IBOutlet weak var txtValore: UITextField!
    @IBOutlet weak var imgIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
