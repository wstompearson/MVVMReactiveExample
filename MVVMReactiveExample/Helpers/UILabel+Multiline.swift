//
//  UILabel+Multiline.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 25/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import UIKit

extension UILabel {
    static func makeMultiLineLabel() -> UILabel {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }
}
