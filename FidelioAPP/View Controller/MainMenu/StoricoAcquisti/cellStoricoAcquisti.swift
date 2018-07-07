//
//  cellStoricoAcquisti.swift
//  FidelioAPP
//
//  Created by Matteo on 23/06/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import UIKit

class cellStoricoAcquisti: UITableViewCell {
    @IBOutlet weak var lblImporto: UILabel!
    @IBOutlet weak var lblCliente: UILabel!
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var imgIcona: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
