//
//  ViewController.swift
//  MyOkashi
//
//  Created by 小幡 十矛 on 2019/03/14.
//  Copyright © 2019 Tomu Obata. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Search Bar のdelegate通知先を設定
        searchText.delegate = self
        
        searchText.placeholder = "お菓子の名前を入力してください"
    }

    @IBOutlet weak var searchText: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // キーボードを閉じる
        view.endEditing(true)
    
        if let searchWord = searchBar.text {
            print(searchWord)
        }
    }
    
    
}

