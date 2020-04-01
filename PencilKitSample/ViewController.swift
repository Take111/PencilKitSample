//
//  ViewController.swift
//  PencilKitSample
//
//  Created by 竹ノ内愛斗 on 2020/04/01.
//  Copyright © 2020 竹ノ内愛斗. All rights reserved.
//

import UIKit
import PencilKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        
        view.addSubview(canvasView)
        view.addSubview(saveButton)
        
        
        if let window = UIApplication.shared.windows.first {
            if let toolPicker = PKToolPicker.shared(for: window) {
                toolPicker.addObserver(canvasView)
                toolPicker.setVisible(true, forFirstResponder: canvasView)
                canvasView.becomeFirstResponder()
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        canvasView.frame = view.bounds
        
        saveButton.frame.size.width = 100
        saveButton.frame.size.height = saveButton.sizeThatFits(saveButton.frame.size).height
        saveButton.frame.origin = CGPoint(x: 50, y: 50)
        
        saveButton.layer.cornerRadius = saveButton.frame.size.height / 2
    }
    
    @objc func saveImage() {
        var drawingImage = UIImage()
        
        drawingImage = canvasView.drawing.image(from: view.frame, scale: 0.5)
        
        UIImageWriteToSavedPhotosAlbum(drawingImage, self, #selector(self.didFinishSavingImage(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func showResultAlert() {
//        let title = "保存が成功しました"
//        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        
//        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func didFinishSavingImage(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeMutableRawPointer) {
         let title = "保存が成功しました"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    lazy var canvasView: PKCanvasView = {
        let v = PKCanvasView()
        v.tool = PKInkingTool(.pen, color: .black, width: 30)
        return v
    }()
    
    lazy var saveButton: UIButton = {
        let v = UIButton()
        v.setTitle("保存", for: .normal)
        v.setTitleColor(.black, for: .normal)
        v.layer.masksToBounds = true
        v.layer.borderColor = UIColor.black.cgColor
        v.layer.borderWidth = CGFloat(1)
        
        v.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
        return v
    }()


}

