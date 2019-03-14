//
//  ViewController.swift
//  MyOkashi
//
//  Created by 小幡 十矛 on 2019/03/14.
//  Copyright © 2019 Tomu Obata. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Search Bar のdelegate通知先を設定
        searchText.delegate = self
        
        searchText.placeholder = "お菓子の名前を入力してください"
        
        tableView.dataSource = self
    }

    @IBOutlet weak var searchText: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // お菓子のリスト(タプル配列)
    var okashiList : [(name: String, maker: String, link : URL, image: URL)] = []
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // キーボードを閉じる
        view.endEditing(true)
    
        if let searchWord = searchBar.text {
            print(searchWord)
            searchOkashi(keyword: searchWord)
        }
    }
    
    struct ItemJson: Codable {
        
        let name: String?
        let maker: String?
        let url: URL?
        let image: URL?
    }
    
    struct ResultJson: Codable {
        let item:[ItemJson]?
    }
    
    func searchOkashi(keyword : String) {
        
        // 検索キーワード
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        // リクエストURLの組み立て
        guard let req_url = URL(string: "http://www.sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=10&order=r") else{
            return
        }
        print(req_url)
    
        // リクエストに必要な情報を生成
        let req = URLRequest(url: req_url)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: req,completionHandler: {
            (data, response, error) in
            session.finishTasksAndInvalidate()
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(ResultJson.self, from: data!)
                
                // print(json)
                if let items = json.item {
                    // お菓子のリストを初期化
                    self.okashiList.removeAll()
                    
                    for item in items {
                        if let name = item.name, let maker = item.maker, let link = item.url, let image = item.image {
                            
                            let okashi = (name,maker, link, image)
                            self.okashiList.append(okashi)
                        }
                    }
                    // TableViewを更新
                    self.tableView.reloadData()
                    
                    if let okashidbg = self.okashiList.first{
                        print("--------------------")
                        print("okashiList[0] = \(okashidbg)")
                    }
                    
                }
            } catch {
                print("エラーが発生しました")
            }
        })
        // ダウンロード開始
        task.resume()
        
    }
    
    // Cellの総数を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return okashiList.count
    }
    
    // Cellに値を設定するメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "okashiCell", for : indexPath)
        
        cell.textLabel?.text = okashiList[indexPath.row].name
        
        if let imageData = try? Data(contentsOf: okashiList[indexPath.row].image) {
            cell.imageView?.image = UIImage(data: imageData)
        }
        return cell
    }
    
    
}

