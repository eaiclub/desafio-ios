//
//  Enum.swift
//  NasaList
//
//  Created by Felipe Bastos on 19/11/20.
//

import Foundation

//------------------------------------------------------------
//    Requests
//------------------------------------------------------------

enum RequestType {
    case get
    case post
    case put
    case patch
    case login
    case recoverPassword
}

//------------------------------------------------------------
//    Util - Messages
//------------------------------------------------------------

enum MessageType {
    case success
    case warning
    case error
}
