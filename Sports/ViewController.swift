//
//  ViewController.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/11/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {

    let networkSevice: FetchSports = NetworkSevice()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        networkSevice.getSports { (items, error) in
            DispatchQueue.main.async {
                print(items?.sports?.first?.strSport)
            }
        }
    }

    

}

