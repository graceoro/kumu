//
//  EditProfileVC.swift
//  kumu
//
//  Created by Grace O'Rourke on 12/12/19.
//  Copyright © 2019 Grace O'Rourke. All rights reserved.
//

import UIKit
import Photos

class EditProfileVC: UIViewController , UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var yearTF: UITextField!
    @IBOutlet weak var majorTF: UITextField!
    @IBOutlet weak var minor: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var pic: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoAuthorization()
        
        saveButton.isEnabled = false;
        
        nameTF.delegate = self
        majorTF.delegate = self
        minor.delegate = self
        yearTF.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    // Textfield Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // textField has its current value
        // the new value is created from the range and string
        if let text = nameTF.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            enableSaveButton(name: updatedText, year: yearTF.text ?? "", major: majorTF.text ?? "")
        }
        
        if let text = yearTF.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            enableSaveButton(name: nameTF.text ?? "", year: updatedText, major: majorTF.text ?? "")
        }
        
        if let text = majorTF.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            enableSaveButton(name: nameTF.text ?? "", year: yearTF.text ?? "", major: updatedText)
        }
        
        return true
    }
    
    // Helper Functions
    func enableSaveButton(name: String, year: String, major: String) {
        //        print("textview: \(textViewChanged) and textfield: \(textFieldChanged)")
        //        saveButton.isEnabled = textViewChanged && textFieldChanged
        saveButton.isEnabled = name.count > 0 && year.count > 0 && major.count > 0
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        
        if nameTF.isFirstResponder {
            nameTF.resignFirstResponder()
        }
        else if yearTF.isFirstResponder {
            yearTF.resignFirstResponder()
        }
        else if majorTF.isFirstResponder {
            majorTF.resignFirstResponder()
        }
        else {
            minor.resignFirstResponder()
        }
        
    }
    @IBAction func changePicPressed(_ sender: UIButton) {
//        photoAuthorization()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a Source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
            else {
                 print("Camera not available")
            }
            
        
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    private func loadImage() -> UIImage? {
        // 1
        let manager = PHImageManager.default()
        // 2
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions())
        // 1
        var image: UIImage? = nil
        // 2
        manager.requestImage(for: fetchResult.object(at: 0), targetSize: CGSize(width: 647, height: 375), contentMode: .aspectFill, options: requestOptions()) { img, err  in
            // 3
            guard let img = img else { return }
            image = img
        }
        return image
    }
    
    private func fetchOptions() -> PHFetchOptions {
        // 1
        let fetchOptions = PHFetchOptions()
        // 2
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        return fetchOptions
    }
    
    private func requestOptions() -> PHImageRequestOptions {
        let requestOptions = PHImageRequestOptions()
        // 2
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        return requestOptions
    }
    
    private func photoAuthorization() {
        
        // 1
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            // 2
            pic.image = loadImage()
        case .restricted, .denied:
            print("Photo Auth restricted or denied")
        case .notDetermined:
            // 3
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    // 4
                    DispatchQueue.main.async {
                        self.pic.image = self.loadImage()
                    }
                case .restricted, .denied:
                    print("Photo Auth restricted or denied")
                case .notDetermined: break
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        pic.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
