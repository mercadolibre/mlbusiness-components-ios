//
//  MLBusinessCoverCarouselItemView.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 03/11/2020.
//

import UIKit
import MLUI
import WebKit

enum GifState {
    case playing
    case stoped
    case loading
}

public class MLBusinessCoverCarouselItemView: UIView {
    static let coverHeight: CGFloat = 100
    private let mapper: MLBusinessCoverCarouselItemContentModelMapperProtocol
    private let gifImageProvider = MLBusinessURLImageProvider()
    private var model: MLBusinessCoverCarouselItemContentModel?
    private var gifState: GifState = .stoped
    
    
    private lazy var alphaOverlayView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.04)
        view.isHidden = true
        
        return view
    }()
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.font = MLStyleSheetManager.styleSheet.boldSystemFont(ofSize: CGFloat(kMLFontsSizeMedium))
        label.textAlignment = .left
        label.textColor = MLStyleSheetManager.styleSheet.whiteColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var coverImageView: ImagePlaybackView = {
        let imageView = ImagePlaybackView()

        imageView.webview.navigationDelegate = self
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = MLStyleSheetManager.styleSheet.lightGreyColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()
    
//    private lazy var coverImageView: UIImageView = {
//        let imageView = UIImageView()
//
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = MLStyleSheetManager.styleSheet.lightGreyColor
//        imageView.clipsToBounds = true
//        imageView.contentMode = .scaleAspectFill
//
//        return imageView
//    }()
    
        private lazy var thumbnailImageView: UIImageView = {
            let imageView = UIImageView()
    
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = MLStyleSheetManager.styleSheet.lightGreyColor
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
    
            return imageView
        }()
    
    private lazy var rowView: MLBusinessRowView = {
        return MLBusinessRowView()
    }()
    
    var imageProvider: MLBusinessImageProvider {
        didSet {
            rowView.imageProvider = imageProvider
        }
    }
    
    public init(with imageProvider: MLBusinessImageProvider? = nil) {
        self.imageProvider = imageProvider ?? MLBusinessURLImageProvider()
        self.mapper = MLBusinessCoverCarouselItemContentModelMapper()
            
        super.init(frame: .zero)
        
        mainTitleLabel.text = "PRUEBA TEXTO SOBRE ANIMACION"
        
        setupView()
        setupConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(with item: MLBusinessCoverCarouselItemContentModel) {
        clear()
        
        model = item
        setStaticImage()
        
        let rowModel = mapper.map(from: item)
        rowView.update(with: rowModel)
    }
    
    public func setStaticImage() {
        if let cover = self.model?.cover {
            imageProvider.getImage(key: cover) { [weak self] image in
                self?.thumbnailImageView.image = image
                self?.gifState = .stoped
            }
        }
        coverImageView.isHidden = true
        
        setImageWEBview()
    }

    public func setImageWEBview() {
        
        if let cover = self.model?.cover, let url = URL(string: cover){
            
            self.coverImageView.loadImage(from: url)
            print("START LOADING")
        }
        coverImageView.isHidden = true
//
//        if let cover = self.model?.cover, let url = URL(string: cover){
//
//            gifImageProvider.getGIFImage(key: cover) { [weak self] image in
//                            self?.coverImageView.image = image
//                            self?.gifState = .playing
//            }
//
//        }
    }
    
//    public func setGifImage() {
//
//        if let cover = self.model?.cover {
//
//
//
//            gifImageProvider.getGIFImage(key: cover) { [weak self] image in
//                self?.coverImageView.image = image
//                self?.gifState = .playing
//            }
//        }
//    }
    
//    public func changeState() {
//        if gifState == .playing {
//            setStaticImage()
//        } else {
//            setGifImage()
//        }
//    }
    
    public func setHighlighted(_ highlighted: Bool) {
        self.alphaOverlayView.isHidden = !highlighted
    }
    
    public func clear() {
        //coverImageView.removeFromSuperview()
        rowView.prepareForReuse()
    }
    
    static func height(for model: MLBusinessCoverCarouselItemContentModel) -> CGFloat {
        let rowLogoHeight: CGFloat = 96
        
        var rowDescriptionHeight: CGFloat = 86
        // MainSecondaryDescription
        rowDescriptionHeight += model.mainSecondaryDescription?.isEmpty ?? true ? 0 : 24
        // StatusDescription
        rowDescriptionHeight += model.statusDescription?.isEmpty ?? true ? 0 : 24
        
        return coverHeight + max(rowLogoHeight, rowDescriptionHeight)
    }
    
    private func setupView() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        
        addSubview(alphaOverlayView)
        addSubview(coverImageView)
        addSubview(rowView)
        addSubview(mainTitleLabel)
        addSubview(thumbnailImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            alphaOverlayView.topAnchor.constraint(equalTo: topAnchor),
            alphaOverlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            alphaOverlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            alphaOverlayView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: MLBusinessCoverCarouselItemView.coverHeight)
        ])
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: MLBusinessCoverCarouselItemView.coverHeight)
        ])
        
        NSLayoutConstraint.activate([
            rowView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor),
            rowView.bottomAnchor.constraint(equalTo: bottomAnchor),
            rowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rowView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            mainTitleLabel.centerXAnchor.constraint(equalTo: coverImageView.centerXAnchor),
            mainTitleLabel.centerYAnchor.constraint(equalTo: coverImageView.centerYAnchor),
        ])
        
    }
}

extension MLBusinessCoverCarouselItemView: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("FINISH LOADING")
        thumbnailImageView.isHidden = true
        coverImageView.isHidden = false
    }
    
    
}

