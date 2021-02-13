//
//  ViewController.swift
//  NASA
//
//  Created by Matheus Pacheco Fusco on 12/02/21.
//  Copyright © 2021 Matheus Pacheco Fusco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var requestButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func requestButtonClicked(_ sender: Any) {
        APODService().getPictureOfTheDay(success: { result in
            print(result)
        }) { (error) in
            print("erro")
        }
    }
    
}
