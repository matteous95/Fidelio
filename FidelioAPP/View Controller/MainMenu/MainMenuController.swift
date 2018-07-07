//
//  MainMenuController.swift
//  FidelioAPP
//
//  Created by Matteo on 26/04/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation
import UIKit
import SwiftIcons

class MainMenuController: UITabBarController {

    @IBOutlet weak var myTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTabBar?.tintColor = AppColor.colorSelection()
        tabBarItem.title = ""
        
        setTabBarItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTabBarItems(){
      let colorSelection = AppColor.colorSelection()
        
        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        myTabBarItem1.image = UIImage.init(icon: .fontAwesome(.users), size: CGSize(width: 32, height: 32), textColor: .darkGray)
        myTabBarItem1.selectedImage = UIImage.init(icon: .fontAwesome(.users), size: CGSize(width: 32, height: 32), textColor: colorSelection)
        myTabBarItem1.title = "Clienti"
        myTabBarItem1.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        myTabBarItem2.image = UIImage.init(icon: .fontAwesome(.qrcode), size: CGSize(width: 32, height: 32), textColor: .darkGray)
        myTabBarItem2.selectedImage = UIImage.init(icon: .fontAwesome(.qrcode), size: CGSize(width: 32, height: 32), textColor: colorSelection)
        myTabBarItem2.title = "Registra Acquisto"
        myTabBarItem2.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        let myTabBarItem3 = (self.tabBar.items?[2])! as UITabBarItem
        myTabBarItem3.image = UIImage.init(icon: .fontAwesome(.shoppingCart), size: CGSize(width: 32, height: 32), textColor: .darkGray)
        myTabBarItem3.selectedImage = UIImage.init(icon: .fontAwesome(.shoppingCart), size: CGSize(width: 32, height: 32), textColor: colorSelection)
        myTabBarItem3.title = "Acquisti"
        myTabBarItem3.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let myTabBarItem4 = (self.tabBar.items?[3])! as UITabBarItem
        myTabBarItem4.image = UIImage.init(icon: .fontAwesome(.cog), size: CGSize(width: 32, height: 32), textColor: .darkGray)
        myTabBarItem4.selectedImage = UIImage.init(icon: .fontAwesome(.cog), size: CGSize(width: 32, height: 32), textColor: colorSelection)
        myTabBarItem4.title = "Impostazioni"
        myTabBarItem4.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
   
}
