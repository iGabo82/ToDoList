//
//  StartVC.swift
//  ToDoList
//
//  Created by Gabriel Lorincz on 30/04/2018.
//  Copyright © 2018 Gabriel Lorincz. All rights reserved.
//

import UIKit

class StartVC: UIViewController, UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
    }

    @IBAction func startButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toCategoryVC", sender: self)
        
    }
    
}
