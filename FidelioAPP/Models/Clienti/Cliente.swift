//
//  Clienti.swift
//  FidelioAPP
//
//  Created by Matteo on 28/04/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation

//MATTEO: struttura per un singolo cliente
 struct Cliente: Decodable {
    var id: Int?
    var user_id: String?
    
    var nome: String?
    var cognome: String?
    var c_fiscale: String?
    var data_nascita: Date?
    var indirizzo: String?
    var citta: String?
    var provincia: String?
    var cap: String?
    var cellulare: String?
    var email: String?
    
    var created_at: Date?
    var updated_at: Date?
    
    let numKey = 10 // MATTEO: variabile per fare il count del numero delle chiavi della struttura che servono in grafica
    
    func convertToDict () -> [String:String] {
        var dic: [String:String] = ["id": ( self.id != nil ? String(self.id!) : "" )]
        dic["user_id"]  = self.user_id ?? ""
        dic["nome"] = self.nome ?? ""
        dic["cognome"] = self.cognome ?? ""
        dic["c_fiscale"] = self.c_fiscale ?? ""
        if self.data_nascita != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"// Your New Date format as per requirement change it own
            let strDN: String = dateFormatter.string(from: (self.data_nascita!))
            dic["data_nascita"] = strDN
        }else{
            dic["data_nascita"] = ""
        }
        dic["indirizzo"] = self.indirizzo ?? ""
        dic["citta"] = self.citta ?? ""
        dic["provincia"] = self.provincia ?? ""
        dic["cap"] = self.cap ?? ""
        dic["cellulare"] = self.cellulare ?? ""
        dic["email"] = self.email ?? ""
        return dic
    }
        /*var Dict = [
                        "id":self.id ?? nil,
                        "user_id":self.user_id ?? nil,
                        "nome":self.nome ?? nil,
                        "cognome":self.cognome ?? nil,
                        "c_fiscale":self.c_fiscale ?? nil,
                        "data_nascita":self.data_nascita ?? nil,
                        "indirizzo":self.indirizzo ?? nil,
                        "citta":self.citta ?? nil,
                        "provincia":self.provincia ?? nil,
                        "cap":self.cap ?? nil,
                        "cellulare":self.cellulare ?? nil,
                        "email":self.email ?? nil
                    ]
        return Dict*/
    


}


extension Cliente {
    public enum Keys: String, CodingKey {
        case id = "id"
        case user_id = "user_id"
        case nome = "nome"
        case cognome = "cognome"
        case c_fiscale = "c_fiscale"
        case data_nascita = "data_nascita"
        case indirizzo = "indirizzo"
        case citta = "citta"
        case provincia = "provincia"
        case cap = "cap"
        case cellulare = "cellulare"
        case email = "email"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
    
    
    /*
    init(id: Int?, user_id: String?, nome: String?,cognome: String?, c_fiscale: String?, data_nascita: Date?,indirizzo: String?, citta: String?, provincia: String?,cap: String?, cellulare: String?, email: String?, created_at: Date?, updated_at:Date?) throws {
        self.id = id
        self.user_id = user_id
        self.nome = nome
        self.cognome = cognome
        self.c_fiscale = c_fiscale
        self.data_nascita = data_nascita
        self.indirizzo = indirizzo
        self.citta = citta
        self.provincia = provincia
        self.cap = cap
        self.cellulare = cellulare
        self.email = email
        self.email = email
        self.created_at = created_at
        self.updated_at = updated_at
    }
    */
        
   

    
    //MATTEO: init decoding della struttura di un cliente dato un decoder(json)
    init(from decoder: Decoder) throws {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let keyedContainer = try decoder.container(keyedBy: Keys.self)
        id = try?  keyedContainer.decode(Int.self, forKey: .id)
        user_id = try?  keyedContainer.decode(String.self, forKey: .user_id)
        nome = try?  keyedContainer.decode(String.self, forKey: .nome)
        cognome = try?  keyedContainer.decode(String.self, forKey: .cognome)
        c_fiscale = try?  keyedContainer.decode(String.self, forKey: .c_fiscale)
        let dataNascita = dateFormatterGet.date(from: try keyedContainer.decode(String.self, forKey: .data_nascita))
        data_nascita = dataNascita
        indirizzo = try?  keyedContainer.decode(String.self, forKey: .indirizzo)
        citta = try?  keyedContainer.decode(String.self, forKey: .citta)
        provincia = try?  keyedContainer.decode(String.self, forKey: .provincia)
        cap = try?  keyedContainer.decode(String.self, forKey: .cap)
        cellulare = try?  keyedContainer.decode(String.self, forKey: .cellulare)
        email = try?  keyedContainer.decode(String.self, forKey: .email)
        let dataCreate = dateFormatterGet.date(from: try keyedContainer.decode(String.self, forKey: .created_at))
        created_at = dataCreate
        let dataUpdate = dateFormatterGet.date(from: try keyedContainer.decode(String.self, forKey: .updated_at))
        updated_at = dataUpdate
        
        
    }
    
    
}
