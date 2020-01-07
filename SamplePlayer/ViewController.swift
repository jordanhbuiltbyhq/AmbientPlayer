//
//  ViewController.swift
//  SamplePlayer
//
//  Created by Jordan Hipwell on 8/29/19.
//  Copyright © 2019 Jordan Hipwell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Maestro.shared.play()
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        Maestro.shared.next()
    }

}

