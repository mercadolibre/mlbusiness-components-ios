//
//  UIViewController-SheetViewController.swift
//  MLBusinessComponents
//
//  Created by Tomi De Lucca on 18/08/2020.
//

import Foundation

public extension UIViewController {
    var sheetViewController: SheetViewController? {
        var parent = self.parent
        while let currentParent = parent {
            if let sheetViewController = currentParent as? SheetViewController {
                return sheetViewController
            } else {
                parent = currentParent.parent
            }
        }
        return nil
    }
}
