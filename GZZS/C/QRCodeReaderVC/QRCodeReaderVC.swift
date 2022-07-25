//
//  QRCodeReaderVC.swift
//  GZZS
//
//  Created by LiuHao on 2017/9/14.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class QRCodeReaderVC: BaseViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,QRCodeReaderViewDelegate {
    
    var readview = QRCodeReaderView()
    var isFirst = Bool()
    var isPush = Bool()
    var detector = CIDetector()
    var callBack = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle(title: "扫描")
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = COLOR_WHITE
        let rightBtn = UIBarButtonItem.init(title: "相册", style: UIBarButtonItemStyle.done, target: self, action: #selector(alumbBtnEvent))
        self.navigationItem.rightBarButtonItem = rightBtn
        
        let leftBtn = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.done, target: self, action: #selector(backButtonEvent))
        self.navigationItem.leftBarButtonItem = leftBtn
//
        isFirst = true
        isPush = false
        self.InitScan()
    }
    
    func InitScan() {
        if readview.isEqual("") {
            readview.removeFromSuperview()
        }
        readview = QRCodeReaderView.init(frame: CGRect.init(x: 0, y: 0, width: WIDTH, height: HEIGHT+24))
        readview.is_AnmotionFinished = true
        readview.backgroundColor = UIColor.clear
        readview.delegate = self
        readview.alpha = 0
        self.view.addSubview(readview)
        
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            self.readview.alpha = 1
        }, completion: {(_ finished: Bool) -> Void in
        })

    }
//
    func alumbBtnEvent() {
        self.detector = CIDetector.init(ofType: CIDetectorTypeQRCode, context: nil, options: ([CIDetectorAccuracy:CIDetectorAccuracyHigh]))!
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            
        }
        
        isPush = true
        let mediaUI = UIImagePickerController.init()
        mediaUI.sourceType = UIImagePickerControllerSourceType.photoLibrary
        mediaUI.mediaTypes = UIImagePickerController.availableMediaTypes(for: UIImagePickerControllerSourceType.savedPhotosAlbum)!
        mediaUI.allowsEditing = false
        mediaUI.delegate = self
        present(mediaUI, animated: true, completion: {() -> Void in
            UIApplication.shared.setStatusBarStyle(.default, animated: true)
        })
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let image : UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        readview.is_Anmotion = true
//        let features : NSArray = detector.features(in:CGImage(image.cgImage)) as NSArray
        
        let image = info[UIImagePickerControllerOriginalImage]
        let imageData = UIImagePNGRepresentation(image as! UIImage)
        let ciImage = CIImage(data: imageData!)
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyLow])
        let array : Array = (detector?.features(in: ciImage!))!
//        let result : CIQRCodeFeature = array!.first as! CIQRCodeFeature

        if array.count >= 1 {
            picker.dismiss(animated: true, completion: {
                UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
                let feature = array[0] as? CIQRCodeFeature ?? CIQRCodeFeature()
                let scannedResult : String? = feature.messageString
//
//                var soundID = SystemSoundID()
//                let strSoundFile : String? = Bundle.main.path(forResource: "noticeMusic", ofType: "wav")
//                AudioServicesCreateSystemSoundID((URL.init(fileURLWithPath: strSoundFile!) as? CFURL)!, &soundID)
//                AudioServicesPlaySystemSound(soundID)
                self.accordingQcode(str: scannedResult!)
            })
        }else{
            let alert = UIAlertView.init(title: "提示", message: "该图片没有包含一个二维码！", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            
            picker.dismiss(animated: true, completion: { 
                UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
                self.readview.is_Anmotion = false
                self.readview.start()
            })
        }
    }
//
    func readerScanResult(_ result: String!) {
        readview.is_Anmotion = true
        readview.stop()
        self.perform(#selector(reStartScan), with: nil, afterDelay: 1.5)
        
        dismiss(animated: true, completion: {() -> Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.callBack), object: result, userInfo: nil)
        })

        print(result)
    }
//
    func reStartScan() {
        readview.is_Anmotion = false
        if readview.is_AnmotionFinished {
            readview.loopDrawLine()
        }
        readview.start()
    }
//
    override func viewWillAppear(_ animated: Bool) {
        if isFirst || isPush {
            if !readview.isEqual("") {
                self.reStartScan()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if !readview .isEqual("") {
            readview.stop()
            readview.is_Anmotion = true
        }
    }

    func accordingQcode(str:String) {
        dismiss(animated: true, completion: {() -> Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.callBack), object: nil, userInfo: nil)
        })
    }

    func backButtonEvent() {
        dismiss(animated: true, completion: {() -> Void in
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
