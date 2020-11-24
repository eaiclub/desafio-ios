//
//  ImageSaver.swift
//  NasaList
//
//  Created by Felipe Bastos on 24/11/20.
//

import UIKit

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error == nil {
            Util.showMessage("Image saved in Photo Album", type: .success)
        }else{
            Util.showMessage("You need to permit the app to access your Photo Album", type: .error)
        }
    }
}
