//
//  MLBusinessHybridCarouselCardTypeCell.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 04/08/2020.
//

import Foundation

protocol MLBusinessHybridCarouselCardTypeCellProtocol: UICollectionViewCell {
    func update(with content: Codable?)
    func update(height: CGFloat)
    var imageProvider: MLBusinessImageProvider? { get set }
}

class MLBusinessHybridCarouselCardTypeViewCell<View: MLBusinessHybridCarouselCardTypeView<Model>, Model>: UICollectionViewCell, MLBusinessHybridCarouselCardTypeCellProtocol {
    let view = View()
    
    override var isHighlighted: Bool {
        didSet {
           setHighlighted(isHighlighted)
        }
    }
    
    private var currentBackgroundColor: UIColor?

    private var height: NSLayoutConstraint? = nil
    
    var imageProvider: MLBusinessImageProvider? {
        didSet {
            if let imageProvider = imageProvider {
                view.imageProvider = imageProvider
            }
        }
    }
    
    static var reuseIdentifier: String {
        return "\(String(describing: self))ReuseIdentifier"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .clear
        view.layer.borderColor =  "ececec".hexaToUIColor().cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 6.0
        view.layer.applyShadow(alpha: 0.1, x: 0, y: 2, blur: 4)
        
        contentView.addSubview(view)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    func update(with content: Codable?) {
        guard let content = content as? Model else { return }
        view.backgroundColor = .white
        currentBackgroundColor = .white
        view.update(with: content)
    }
    
    func update(height: CGFloat) {
        self.height?.constant = height
        self.height?.isActive = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        view.prepareForReuse()
    }
    
    private func setHighlighted(_ highlighted: Bool) {
        view.backgroundColor = highlighted ? currentBackgroundColor?.darker() : currentBackgroundColor
    }
}
