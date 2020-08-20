//
//  MLBusinessHybridCarouselCardTypeProvider.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 04/08/2020.
//

import Foundation

class MLBusinessHybridCarouselCardTypeProvider {
    private let collectionView: UICollectionView
    private let registry: MLBusinessHybridCarouselCardViewRegistryProtocol

    init(collectionView: UICollectionView, registry: MLBusinessHybridCarouselCardViewRegistryProtocol) {
        self.collectionView = collectionView
        self.registry = registry
        register()
    }

    func register() {
        for type in registry.types {
            collectionView.register(registry.views(for: type), forCellWithReuseIdentifier: type)
        }
    }

    func view(for type: String, at indexPath: IndexPath) -> MLBusinessHybridCarouselCardTypeCellProtocol? {
        guard registry.types.contains(type.uppercased()) else { return nil }
        return collectionView.dequeueReusableCell(withReuseIdentifier: type, for: indexPath) as? MLBusinessHybridCarouselCardTypeCellProtocol
    }
}
