//
//  SheetSizeManager.swift
//  MLBusinessComponents
//
//  Created by Tomi De Lucca on 18/08/2020.
//

import Foundation

class SheetSizeManager {
    var sheetViewSize: CGSize = .zero {
        didSet {
            updateDimensions()
        }
    }
    
    var sheetContentSize: CGSize = .zero {
        didSet {
            updateDimensions()
        }
    }
    
    var current: SheetSize
    
    var currentDimension: CGFloat {
        get {
            return dimension(for: current)
        }
    }
    
    private var possible: [SheetSize] = []
    
    init(sizes: [SheetSize]) {
        self.current = sizes.first ?? .intrinsic
        self.possible = sizes
        updateDimensions()
    }
    
    func floor(height: CGFloat) -> SheetSize {
        return possible.reversed().first { 0...height ~= dimension(for: $0) } ?? min()
    }
    
    func ceil(height: CGFloat) -> SheetSize {
        return possible.first { dimension(for: $0) >= height } ?? max()
    }
    
    func min() -> SheetSize {
        return possible.first { dimension(for: $0) > 0 } ?? .intrinsic
    }
    
    func max() -> SheetSize {
        return possible.last { dimension(for: $0) > 0 } ?? .intrinsic
    }
    
    func dimension(for size: SheetSize) -> CGFloat {
        return calculateDimension(for: size)
    }
    
    private func updateDimensions() {
        possible.sort { self.dimension(for: $0) < self.dimension(for: $1) }
    }
    
    private func calculateDimension(for size: SheetSize) -> CGFloat {
        switch size {
        case .fixed(let height):
            return height
        case .intrinsic:
            return sheetContentSize.height
        case .percent(let percent):
            return sheetViewSize.height * percent
        case .fixedFromTop(let margin):
            return sheetViewSize.height - margin
        case .min(let s1, let s2):
            return min(calculateDimension(for: s1), calculateDimension(for: s2))
        case .max(let s1, let s2):
            return max(calculateDimension(for: s1), calculateDimension(for: s2))
        }
    }
}
