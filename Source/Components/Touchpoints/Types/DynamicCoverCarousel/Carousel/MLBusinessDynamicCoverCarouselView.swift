//
//  MLBusinessDynamicCoverCarouselView.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 03/11/2022.
//

import Foundation

public protocol MLBusinessDynamicCoverCarouselViewDelegate: class {
    func coverCarouselView(_: MLBusinessDynamicCoverCarouselView, didSelect item: MLBusinessDynamicCoverCarouselItemModel, at index: Int)
    func coverCarouselView(_: MLBusinessDynamicCoverCarouselView, didFinishScrolling visibleItems: [MLBusinessDynamicCoverCarouselItemModel]?)
}

public class MLBusinessDynamicCoverCarouselView: UIView {
    private var collectionViewHeightConstraint: NSLayoutConstraint?
    private var model: MLBusinessDynamicCoverCarouselModel?
    private var items: [MLBusinessDynamicCoverCarouselItemModel] { return model?.items ?? [] }
    weak var delegate: MLBusinessDynamicCoverCarouselViewDelegate?
    
    public init() {
        super.init(frame: .zero)
        self.backgroundColor = .blue
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
