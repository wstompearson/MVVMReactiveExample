//
//  UIView+Subviews.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 26/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import UIKit

extension UIView {
    func addAutoconstrainedSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
