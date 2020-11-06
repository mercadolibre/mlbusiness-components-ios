//
//  MLBusinessCoverCarouselContainerViewCell.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 04/11/2020.
//

import Foundation

class MLBusinessCoverCarouselContainerViewCell: UICollectionViewCell {
    private let itemView = MLBusinessCoverCarouselContainerItemView()

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
    
    override var isHighlighted: Bool {
        didSet {
           setHighlighted(isHighlighted)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemView.clear()
    }
    
    func update(with content: MLBusinessCoverCarouselContainerItemModel) {
        itemView.update(with: content)
    }

    private func setup() {
        layer.borderColor = UIColor(white: 155.0/255.0, alpha: 0.1).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 6.0
        layer.applyShadow(alpha: 0.1, x: 0, y: 2, blur: 4)
        
        contentView.addSubview(itemView)
    }

    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            itemView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            itemView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func setHighlighted(_ highlighted: Bool) {
        itemView.setHighlighted(highlighted)
    }
}
