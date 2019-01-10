//
//  UIViewController+ErrorPresenting.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 26/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import UIKit

extension UIViewController {
    typealias PopupHandler = ((UIAlertAction) -> Void)?
    
    func presentErrorAlert(title: String, handler: PopupHandler = nil) {
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        present(ac, animated: true)
    }
}
