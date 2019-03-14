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
    
    // エフェクト前画像
    var originalImage : UIImage?
    
    @IBAction func effectButtonAction(_ sender: Any) {
        
        // エフェクト前画像をアンラップしてエフェクト用画像として取り出す
        if let image = originalImage {
            
            let filterName = "CIPhotoEffectMono"
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
            
            present(controller, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func closeButtonAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
