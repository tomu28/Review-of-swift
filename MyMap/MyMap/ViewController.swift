//
//  ViewController.swift
//  MyMap
//
//  Created by 小幡 十矛 on 2019/03/14.
//  Copyright © 2019 Tomu Obata. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        inputText.delegate = self
    }

    
    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var dispMap: MKMapView!
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        if let searchKey = textField.text {
            print(searchKey)
        }
        return true
    }
    
    
}

