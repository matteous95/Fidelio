//
//  viewAcquisto.swift
//  FidelioAPP
//
//  Created by Matteo on 29/04/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import UIKit
import AVFoundation

class viewAcquisto: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var btnSwitch: UIButton!
    @IBOutlet weak var viewCamera: UIView!
    @IBOutlet weak var viewFooterCamera: UIView!
    @IBOutlet weak var viewHeaderCamera: UIView!
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet weak var lblRegistraAcq: UILabel!
    var frontDevice: AVCaptureDevice?   = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front)
    var defaultDevice: AVCaptureDevice? = AVCaptureDevice.default(for: .video)
    
    lazy var defaultDeviceInput: AVCaptureDeviceInput? = {
        guard let defaultDevice = defaultDevice else { return nil }
        
        return try? AVCaptureDeviceInput(device: defaultDevice)
    }()
    
    lazy var frontDeviceInput: AVCaptureDeviceInput? = {
        if let _frontDevice = self.frontDevice {
            return try? AVCaptureDeviceInput(device: _frontDevice)
        }
        
        return nil
    }()
    
    let captureSession = AVCaptureSession()
    var camera = CameraController()
    var frontCamera: AVCaptureDevice?
    var rearCamera: AVCaptureDevice?
    
    var captureDevice:AVCaptureDevice?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    let codeFrame:UIView = {
        let codeFrame = UIView()
        codeFrame.layer.borderColor = AppColor.colorSelection().cgColor
        codeFrame.layer.borderWidth = 2
        codeFrame.frame = CGRect.zero
        codeFrame.translatesAutoresizingMaskIntoConstraints = false
        return codeFrame
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubview(toFront: btnSwitch)
        view.bringSubview(toFront: viewFooterCamera)
        btnSwitch.setImage(UIImage.init(icon: .fontAwesome(.undo), size: CGSize(width: 35, height: 35), textColor: .white), for: .normal)
        btnSwitch.setTitle("", for: .normal)
        lblRegistraAcq.text = ""
        imgQRCode.image = UIImage.init(icon: .fontAwesome(.qrcode), size: CGSize(width: 48, height: 48), textColor: .white)
        captureDevice = AVCaptureDevice.default(for: .video)
        // Check if captureDevice returns a value and unwrap it
        if let captureDevice = captureDevice {
            
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                captureSession.addInput(input)
                
                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession.addOutput(captureMetadataOutput)
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
                captureMetadataOutput.metadataObjectTypes = [.code128, .qr, .ean13,  .ean8, .code39] //AVMetadataObject.ObjectType
                captureSession.startRunning()
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                videoPreviewLayer?.frame = viewCamera.layer.bounds
                viewCamera.layer.addSublayer(videoPreviewLayer!)
    
                
            } catch {
                print("Error Device Input")
            }
            
         

            
        }
        
        
    }
    
    @IBAction func switchCamera(_ sender: Any) {
        switchDeviceInput()
    }
    
    public func switchDeviceInput() -> AVCaptureDeviceInput? {
        if let _frontDeviceInput = frontDeviceInput {
            captureSession.beginConfiguration()
            
            if let _currentInput = captureSession.inputs.first as? AVCaptureDeviceInput {
                captureSession.removeInput(_currentInput)
                
                let newDeviceInput = (_currentInput.device.position == .front) ? defaultDeviceInput : _frontDeviceInput
                captureSession.addInput(newDeviceInput!)
            }
            
            captureSession.commitConfiguration()
        }
        
        return captureSession.inputs.first as? AVCaptureDeviceInput
    }
    

    
    
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            //print("No Input Detected")
            codeFrame.frame = CGRect.zero
            print("No Data")
            return
        }
        
        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        guard let stringCodeValue = metadataObject.stringValue else { return }
        
        view.addSubview(codeFrame)
        
        guard let barcodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject) else { return }
        codeFrame.frame = barcodeObject.bounds
        print(stringCodeValue)
        
        let customSoundId: SystemSoundID = 1016  // to play apple's built in sound, no need for upper 3 lines
        
        AudioServicesAddSystemSoundCompletion(customSoundId, nil, nil, { (customSoundId, _) -> Void in
            AudioServicesDisposeSystemSoundID(customSoundId)
        }, nil)

        AudioServicesPlaySystemSound(customSoundId)
 
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
