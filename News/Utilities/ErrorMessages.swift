//
//  ErrorMessages.swift
//  News
//
//  Created by Muhammed Faruk Söğüt on 11.01.2022.
//

import Foundation

enum errorMessages : String, Error{
    case url        = "URL error"
    case URLsession = "URL session task error"
    case response   = "Response error"
    case decode     = "Decoding error"
}


