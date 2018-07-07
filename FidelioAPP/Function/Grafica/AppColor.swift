//
//  AppColor.swift
//  FidelioAPP
//
//  Created by Matteo on 16/06/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation
import UIKit

public class AppColor {
    //MATTEO: imposto il colore degli header
    static func colorHeader() -> UIColor {
        return colorWithHexString(hex: "#343a40")
    }
    
    static func colorSelection () -> UIColor {
        return colorWithHexString(hex: "#138496")
    }
    
    static func colorDisable () -> UIColor {
        return UIColor.darkGray
    }
    
}


func colorWithHexString (hex:String) -> UIColor {
    
    var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString = (cString as NSString).substring(from: 1)
    }
    
    if (cString.characters.count != 6) {
        return UIColor.gray
    }
    
    let rString = (cString as NSString).substring(to: 2)
    let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
    let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    Scanner(string: rString).scanHexInt32(&r)
    Scanner(string: gString).scanHexInt32(&g)
    Scanner(string: bString).scanHexInt32(&b)
    
    
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
}
