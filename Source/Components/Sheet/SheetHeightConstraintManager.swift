//
//  SheetHeightConstraintManager.swift
//  MLBusinessComponents
//
//  Created by Tomi De Lucca on 23/08/2020.
//

import Foundation

protocol SheetHeightManager {
    func getHeight() -> CGFloat
    func setHeight(_ height: CGFloat)
}

protocol SheetHeightConstraintManagerDelegate: class {
    func sheetHeightDidChange(_ height: CGFloat)
}

class SheetHeightConstraintManager: SheetHeightManager {
    weak var delegate: SheetHeightConstraintManagerDelegate?
    
    private var contentControllerViewHeightConstraint: NSLayoutConstraint
    
    init(constraint: NSLayoutConstraint, delegate: SheetHeightConstraintManagerDelegate) {
        self.contentControllerViewHeightConstraint = constraint
        self.delegate = delegate
    }
    
    func getHeight() -> CGFloat {
        return contentControllerViewHeightConstraint.constant
    }
    
    func setHeight(_ height: CGFloat) {
        contentControllerViewHeightConstraint.constant = height
        delegate?.sheetHeightDidChange(height)
    }
    
    func setActive(_ active: Bool) {
        contentControllerViewHeightConstraint.isActive = active
    }
}
