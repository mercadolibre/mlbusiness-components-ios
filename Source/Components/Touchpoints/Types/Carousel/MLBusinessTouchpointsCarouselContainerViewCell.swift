//
//  MLBusinessTouchpointsCarouselContainerViewCell.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 30/04/2020.
//

import Foundation

class MLBusinessTouchpointsCarouselContainerViewCell: UICollectionViewCell {
    override var isHighlighted: Bool {
        didSet {
           setHighlighted(isHighlighted)
        }
    }

    private var height: NSLayoutConstraint? = nil
    let itemView = MLBusinessTouchpointsCarouselContainerItemView()
    
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

    func update(with content: MLBusinessCarouselItemModel) {
        if let colorString = content.backgroundColor {
            currentBackgroundColor =  colorString.hexaToUIColor()
            backgroundColor = currentBackgroundColor ?? .white
        }
        itemView.update(with: content)
    }
    
    func update(height: CGFloat) {
        self.height?.constant = height
        self.height?.isActive = true
    }

    private func setup() {
        backgroundColor = .clear
        
        layer.borderColor =  "ececec".hexaToUIColor().cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 6.0
        layer.applyShadow(alpha: 0.1, x: 0, y: 2, blur: 4)
        
        contentView.addSubview(itemView)
    }

    private func setupConstraints() {
        itemView.translatesAutoresizingMaskIntoConstraints = false

        let top = UILayoutGuide()
        let bottom = UILayoutGuide()

        contentView.addLayoutGuide(top)
        contentView.addLayoutGuide(bottom)

        NSLayoutConstraint.activate([
            top.heightAnchor.constraint(equalTo: bottom.heightAnchor),
            top.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemView.topAnchor.constraint(equalTo: top.bottomAnchor),
            itemView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            itemView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            itemView.bottomAnchor.constraint(equalTo: bottom.topAnchor),
            bottom.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: 0),
        ])
    }
    
    private func setHighlighted(_ highlighted: Bool) {
        backgroundColor = highlighted ? currentBackgroundColor?.darker() : currentBackgroundColor
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        itemView.clear()
    }
}
