//
//  ViewController.swift
//  SamplePlayer
//
//  Created by Jordan Hipwell on 8/29/19.
//  Copyright © 2019 Jordan Hipwell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Maestro.shared.setUp()
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        Maestro.shared.next()
    }

}

