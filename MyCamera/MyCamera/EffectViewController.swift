//
//  EffectViewController.swift
//  MyCamera
//
//  Created by 小幡 十矛 on 2019/03/14.
//  Copyright © 2019 Tomu Obata. All rights reserved.
//

import UIKit

class EffectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        effectImage.image = originalImage
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var effectImage: UIImageView!
    
    // ファイル名を列挙した配列(Array)
    // 0.モノクロ
    // 1.Chrome
    // 2.Fade
    // 3.Instant
    // 4.Noir
    // 5.Process
    // 6.Tonal
    // 7.Transfer
    // 8.Sepia Tone
    let filterArray = ["CIPhotoEffectMono",
                       "CIPhotoEffectChrome",
                       "CIPhotoEffectFade",
                       "CIPhotoEffectInstant",
                       "CIPhotoEffectNoir",
                       "CIPhotoEffectProcess",
                       "CIPhotoEffectTonal",
                       "CIPhotoEffectTransfer",
                       "CISepiaTone"
    ]
    
    // 選択中のエフェクト添字
    var filterSelectNumber = 0
    
    // エフェクト前画像
    var originalImage : UIImage?
    
    @IBAction func effectButtonAction(_ sender: Any) {
        
        // エフェクト前画像をアンラップしてエフェクト用画像として取り出す
        if let image = originalImage {
            
            // ファイル名を指定
            let filterName = filterArray[filterSelectNumber]
            
            // 次の選択するエフェクト添字に更新
            filterSelectNumber += 1
            // 添字の配列の数と同じか？チャック
            if filterSelectNumber == filterArray.count {
                // 同じ場合は最後まで選択されたので先頭に戻す
                filterSelectNumber = 0
                
            }
            
            
            // 元画像の回転角度を取得
            let rotate = image.imageOrientation
            
            let inputImage = CIImage(image: image)
            
            guard let effectFileter = CIFilter(name: filterName) else {
                return
            }
            effectFileter.setDefaults()
            effectFileter.setValue(inputImage, forKey: kCIInputImageKey)
            
            guard let outputImage = effectFileter.outputImage else {
                return
            }
            
            let ciContext = CIContext(options: nil)
            
            guard let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else {
                return
            }
            
            effectImage.image = UIImage(cgImage: cgImage, scale: 1.0, orientation: rotate)
        }
        
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        
        if let shareImage = effectImage.image {
            
            let shareItems = [shareImage]
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            controller.popoverPresentationController?.sourceView = view
            
            // シェアボタンの情報を取得
            let button = sender as! UIButton
            // シェアボタンの表示位置を設定(シェアボタンの上に表示される)
            controller.popoverPresentationController?.sourceRect = button.frame
            
            present(controller, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func closeButtonAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
