//
//  MLBusinessHybridCarouselContainerViewCell.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 29/07/2020.
//

import Foundation

class MLBusinessHybridCarouselContainerViewCell: UICollectionViewCell {
    override var isHighlighted: Bool {
        didSet {
           setHighlighted(isHighlighted)
        }
    }

    private var height: NSLayoutConstraint? = nil
    let itemView = MLBusinessHybridCarouselCardView()
    
    private var currentBackgroundColor: UIColor?

    static var reuseIdentifier: String {
        return "\(String(describing: self))ReuseIdentifier"
    }
    
    var imageProvider: MLBusinessImageProvider? {
        didSet {
            if let imageProvider = imageProvider {
                itemView.imageProvider = imageProvider
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with content: MLBusinessHybridCarouselCardModel) {
        itemView.backgroundColor = .white
        currentBackgroundColor = .white
        itemView.update(with: content)
    }
    
    func update(height: CGFloat) {
        self.height?.constant = height
        self.height?.isActive = true
    }

    private func setup() {
        itemView.backgroundColor = .clear
        
        itemView.layer.borderColor =  "ececec".hexaToUIColor().cgColor
        itemView.layer.borderWidth = 1.0
        itemView.layer.cornerRadius = 6.0
        itemView.layer.applyShadow(alpha: 0.1, x: 0, y: 2, blur: 4)
        
        contentView.addSubview(itemView)
    }

    private func setupConstraints() {
        itemView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: topAnchor),
            itemView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            itemView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
    }
    
    private func setHighlighted(_ highlighted: Bool) {
        itemView.backgroundColor = highlighted ? currentBackgroundColor?.darker() : currentBackgroundColor
    }
}
