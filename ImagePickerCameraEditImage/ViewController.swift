//
//  ViewController.swift
//  ImagePickerCameraEditImage
//
//  Created by wealthyjalloh on 14/07/2016.
//  Copyright © 2016 CWJ. All rights reserved.
//

import UIKit
import MediaPlayer
import MobileCoreServices

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var cutImage: UIImageView!
    @IBOutlet weak var myImage: UIImageView!
    
    
    
    @IBAction func useCamera(sender: UIButton) {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.sourceType = .Camera
        
        // select cam only 
        imgPicker.mediaTypes = [kUTTypeImage as String]
        imgPicker.showsCameraControls = true
        imgPicker.allowsEditing = true
        self.presentViewController(imgPicker, animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imgEdited = info[UIImagePickerControllerEditedImage] as! UIImage
        let imgData = UIImagePNGRepresentation(img)! as NSData
        
        // save in photo album 
        UIImageWriteToSavedPhotosAlbum(img, self, "image:didFinishSavingWithError:contextInfo:", nil)
        
        
        // save in documents 
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last
        
        let filePath = (documentsPath! as NSString).stringByAppendingPathComponent("pic.png")
        imgData.writeToFile(filePath, atomically: true)
        
        myImage.image = img
        cutImage.image = imgEdited
        
        self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    // didFinishSavingWithError function 
    func image(image: UIImage, didFinishSavingWithError error:NSErrorPointer, contextInfo: UnsafePointer<()>) {
        if (error != nil) {
            print("error image \(error.debugDescription)")
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}

