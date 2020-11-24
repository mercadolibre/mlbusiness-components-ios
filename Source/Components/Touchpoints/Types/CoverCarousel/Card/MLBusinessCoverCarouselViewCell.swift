//
//  MLBusinessCoverCarouselViewCell.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 04/11/2020.
//

import Foundation

class MLBusinessCoverCarouselViewCell: UICollectionViewCell {
    private let pressableAnimator = ShrinkPressableAnimator()
    private let cornerRadius: CGFloat = 6
    
    private lazy var itemView: MLBusinessCoverCarouselItemView = {
        let itemView = MLBusinessCoverCarouselItemView()
        
        itemView.layer.cornerRadius = cornerRadius
        
        return itemView
    }()
    
    private lazy var mainContentView: PressableView = {
        let view = PressableView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

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
    
    var animatesWhenPressed: Bool {
        didSet {
            mainContentView.pressableAnimator = animatesWhenPressed ? pressableAnimator : nil
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
           setHighlighted(isHighlighted)
        }
    }

    override init(frame: CGRect) {
        animatesWhenPressed = true
        
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
    
    func update(with content: MLBusinessCoverCarouselItemContentModel) {
        itemView.update(with: content)
    }

    private func setup() {
        mainContentView.layer.borderColor = UIColor(white: 155.0/255.0, alpha: 0.1).cgColor
        mainContentView.layer.borderWidth = 1.0
        mainContentView.layer.cornerRadius = cornerRadius
        mainContentView.layer.applyShadow(alpha: 0.1, x: 0, y: 2, blur: 4)
        
        contentView.addSubview(mainContentView)
        mainContentView.addSubview(itemView)
    }

    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainContentView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            mainContentView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            mainContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: mainContentView.topAnchor),
            itemView.leftAnchor.constraint(equalTo: mainContentView.leftAnchor),
            itemView.rightAnchor.constraint(equalTo: mainContentView.rightAnchor),
            itemView.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor),
        ])
    }
    
    private func setHighlighted(_ highlighted: Bool) {
        itemView.setHighlighted(highlighted)
    }
}
