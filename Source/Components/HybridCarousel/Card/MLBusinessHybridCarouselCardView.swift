//
//  MLBusinessHybridCarouselCardView.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 29/07/2020.
//

import Foundation

class MLBusinessHybridCarouselCardView: UIView {
    private let registry = MLBusinessHybridCarouselCardRegistry()
    private var hybridCarouselCardView: MLBusinessHybridCarouselCardBaseView?
    private var hybridCarouselCardData: MLBusinessHybridCarouselCardModel?
    
    var imageProvider: MLBusinessImageProvider? {
        didSet {
            guard let imageProvider = imageProvider else { return }
            hybridCarouselCardView?.imageProvider = imageProvider
        }
    }
    
    public init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(with data: MLBusinessHybridCarouselCardModel) {
        let hybridCarouselCardType = data.cardType
        let hybridCarouselCardContent = data.cardContent
        
        if let viewType = registry.views(for: hybridCarouselCardType) {
            let hybridCarouselCardMapper = registry.mapper(for: hybridCarouselCardType)
            let codableContent = hybridCarouselCardMapper?.map(dictionary: hybridCarouselCardContent)
                        
            if hybridCarouselCardType != hybridCarouselCardData?.cardType || hybridCarouselCardView == nil{
                hybridCarouselCardData = data
                hybridCarouselCardView = viewType.init()
                setupHybridCarouselCardView()
            }
            
            hybridCarouselCardView?.update(with: codableContent)
        }
    }
    
    private func setupHybridCarouselCardView() {
        guard let hybridCarouselCardView = hybridCarouselCardView else { return }
        subviews.forEach{ $0.removeFromSuperview() }
        hybridCarouselCardView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(hybridCarouselCardView)
        
        NSLayoutConstraint.activate([
            hybridCarouselCardView.topAnchor.constraint(equalTo: topAnchor),
            hybridCarouselCardView.leftAnchor.constraint(equalTo: leftAnchor),
            hybridCarouselCardView.rightAnchor.constraint(equalTo: rightAnchor),
            hybridCarouselCardView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
