//
//  ViewController.swift
//  SwiftShip
//
//  Created by Aaron Sapp on 10/07/2016.
//  Copyright (c) 2016 Aaron Sapp. All rights reserved.
//

import UIKit
import SwiftShip

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let shipService = SwiftShip(userIdUSPS: "prodsolclient")
        shipService.getUSPSRate(fromZip: 43023, toZip: 43551, pounds: 12, ounces: 0.3, container: .mdFlatRateBox, size: .regular) { rate, error in
            if error != "" {
                print("Error: \(error)")
            } else {
                print("Rate: \(rate)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

