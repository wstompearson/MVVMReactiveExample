//
//  UIViewController+ErrorPresenting.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 26/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import UIKit

protocol ErrorPresenter {
    func presentErrorAlert(_ error: Error)
}

extension ErrorPresenter where Self: UIViewController {
    func presentErrorAlert(_ error: Error) {
        let errorMessage: String

        if let description = (error as? LocalizedError)?.errorDescription {
            errorMessage = description
        } else {
            errorMessage = "\(error)"
        }

        let ac = UIAlertController(title: "Whoops", message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }
}
