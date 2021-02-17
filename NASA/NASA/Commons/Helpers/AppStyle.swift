//
//  AppStyle.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 11/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit
import SVProgressHUD
import JGProgressHUD

class AppLoading : NSObject {

    class func show() {
        SVProgressHUD.setBackgroundColor(.white)
        SVProgressHUD.setForegroundColor(.black)
        SVProgressHUD.show()
    }
    
    class func stop() {
        SVProgressHUD.dismiss()
    }
}
