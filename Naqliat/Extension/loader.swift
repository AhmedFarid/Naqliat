//
//  loader.swift
//  Naqliat
//
//  Created by Ahmed farid on 7/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension NVActivityIndicatorViewable where Self: UIViewController {
    func loaderHelper() {
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: #colorLiteral(red: 0, green: 0, blue: 0.5019607843, alpha: 1), textColor: #colorLiteral(red: 0, green: 0, blue: 0.5019607843, alpha: 1))
    }
    
}
