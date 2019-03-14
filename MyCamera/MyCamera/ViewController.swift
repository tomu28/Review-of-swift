//
//  ViewController.swift
//  MyCamera
//
//  Created by 小幡 十矛 on 2019/03/14.
//  Copyright © 2019 Tomu Obata. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBOutlet weak var pictureImage: UIImageView!
    
    @IBAction func cameraButtonAction(_ sender: Any) {
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            print("カメラは利用できます")
//            // UIImagePickerControllerのインスタンスを作成
//            let imagePickerController = UIImagePickerController()
//            imagePickerController.sourceType = .camera
//            imagePickerController.delegate = self
//            present(imagePickerController, animated: true, completion: nil)
//        } else {
//            print("カメラは利用できません")
//        }
        
        let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
        
        // カメラが利用可能かチャック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: { (action:UIAlertAction) in
                
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        // フォトライブラリーが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let photoLibraryAction = UIAlertAction(title: "フォトライブラリー", style: .default, handler: { (action: UIAlertAction) in
                
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
                
            })
            alertController.addAction(photoLibraryAction)
        }
        
        
        // キャンセルの選択肢を定義
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = view
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func SNSButtonAction(_ sender: Any) {
        
        if let shareImage = pictureImage.image {
            
            let shareItems = [shareImage]
            let controller = UIActivityViewController(activityItems: shareItems,
                                                         applicationActivities: nil)
            
            // iPadで落ちてしまう対策
            controller.popoverPresentationController?.sourceView = view
            
            present(controller, animated: true, completion: nil)
        }
    }
    
    
    // 撮影が終わった時に呼ばれるdelegateメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
        info: [UIImagePickerController.InfoKey: Any]) {
        
        captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true, completion: {
            self.performSegue(withIdentifier: "showEffectView", sender: nil)
        })
    }
    
    var captureImage : UIImage?
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let nextViewController = segue.destination as? EffectViewController {
            // 画面遷移時に、取得した画像を渡す
            nextViewController.originalImage = captureImage
        }
    }
}

