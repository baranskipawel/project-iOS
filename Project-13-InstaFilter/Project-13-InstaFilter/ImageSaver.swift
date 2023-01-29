//
//  ImageSaver.swift
//  Project-13-InstaFilter
//
//  Created by Pawel Baranski on 25/01/2023.
//

import UIKit

//class for writing our photos
class ImageSaver: NSObject {
    
    var successHandler : (() -> Void)?
    var errorHandler : ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
