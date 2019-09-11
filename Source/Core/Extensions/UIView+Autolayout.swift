//
//  UIView+Autolayout.swift
//  MLBusinessComponents
//
//  Created by Juan sebastian Sanzone on 9/7/19.
//  Copyright © 2019 Juan Sanzone. All rights reserved.
//

import UIKit

internal extension UIView {
    func prepareForAutolayout(_ background: UIColor? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = background == nil ? .white : background
    }
}
