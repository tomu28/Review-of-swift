//
//  ViewController.swift
//  MyTimer
//
//  Created by 小幡 十矛 on 2019/03/14.
//  Copyright © 2019 Tomu Obata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer : Timer?
    var count = 0
    let settingKey = "timer_value"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let settings = UserDefaults.standard
        settings.register(defaults: [settingKey: 10])
    }

    @IBOutlet weak var countDownLabel: UILabel!
    
    @IBAction func settingButtonAction(_ sender: Any) {
        
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                // タイマー停止
                nowTimer.invalidate()
            }
        }
        // 画面遷移
        performSegue(withIdentifier: "goSetting", sender: nil)
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                return
            }
        }
        
        // 1秒間隔でタイマーをスタート
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(self.timerInterrupt(_:)),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    
    @IBAction func stopButtonAction(_ sender: Any) {
        
        // timer をアンラップしてnowTimer に代入
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                nowTimer.invalidate()
            }
        }
    }
    
    
    func displayUpdate() -> Int{
        
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: settingKey)
        let remainCount = timerValue - count
        
        countDownLabel.text = "残り\(remainCount)秒"
        
        return remainCount
    }
    
    @objc func timerInterrupt(_ timer:Timer) {
        
        count += 1
        if displayUpdate() <= 0 {
            count = 0
            timer.invalidate()
        }
    }
    
    // 画面切り替えのタイミングでの処理
    override func viewDidAppear(_ animated: Bool) {
        
        count = 0
        _ = displayUpdate()
    }
    
}

