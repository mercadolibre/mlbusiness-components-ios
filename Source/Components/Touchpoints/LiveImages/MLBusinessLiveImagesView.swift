//
//  MLBusinessLiveImagesView.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 15/12/2022.
//

import Foundation
import WebKit

enum MLBusinessLiveImagesState {
    case playing
    case stoped
}

protocol MLBusinessLiveImagesHelper {
    func playAnimation()
    func stopAnimation()
}

class MLBusinessLiveImagesView: UIView {
    
    var imageProvider: MLBusinessImageProvider {
        didSet {
            viewModel.imageProvider = imageProvider
        }
    }
    var liveImageState: MLBusinessLiveImagesState = .stoped
    var viewModel = MLBusinessLiveImagesViewModel()
    
    public init(with imageProvider: MLBusinessImageProvider? = nil) {
        self.imageProvider = imageProvider ?? MLBusinessURLImageProvider()
        super.init(frame: .zero)
        viewModel.delegate = self
        setup()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        isUserInteractionEnabled = false
        addSubview(thumbnailImage)
        addSubview(liveImage)
        
        liveImage.isHidden = viewModel.shouldHideAnimation(state: liveImageState)
        thumbnailImage.isHidden =  viewModel.shouldHideThumbnail(state: liveImageState)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            liveImage.leftAnchor.constraint(equalTo: leftAnchor),
            liveImage.rightAnchor.constraint(equalTo: rightAnchor),
            liveImage.topAnchor.constraint(equalTo: topAnchor),
            liveImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            thumbnailImage.leftAnchor.constraint(equalTo: leftAnchor),
            thumbnailImage.rightAnchor.constraint(equalTo: rightAnchor),
            thumbnailImage.topAnchor.constraint(equalTo: topAnchor),
            thumbnailImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private lazy var thumbnailImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var liveImage: MLBusinessLiveImagesWebView = {
        let view = MLBusinessLiveImagesWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.liveImageDelegate = self
        return view
    }()
    
    func update(coverMedia: MLBusinessLiveImagesModel?, cover: String?){
        viewModel.update(coverMedia: coverMedia, cover: cover)
    }
    

}

extension MLBusinessLiveImagesView: MLBusinessLiveImagesHelper {
    
    func playAnimation() {
        
        changeState(to: .playing)
    }
    
    func stopAnimation() {
        changeState(to: .stoped)
    }
    
}

extension MLBusinessLiveImagesView: LiveImageViewModelDelegate {
    func setStaticImage(with image: UIImage) {
        thumbnailImage.image = image
    }
    
    func setAnimatedImage(with url: String) {
        liveImage.loadImage(from: url)
    }
    
    func changeState(to state: MLBusinessLiveImagesState) {
        liveImageState = state
        
        UIView.transition(with: self.liveImage,
                                      duration: 1,
                                      options: .transitionCrossDissolve,
                                      animations: {
            self.thumbnailImage.isHidden = self.viewModel.shouldHideThumbnail(state:self.liveImageState)
            self.liveImage.isHidden = self.viewModel.shouldHideAnimation(state: self.liveImageState)
                                        },
                                      completion: nil)
    }
    
    func clear() {
        thumbnailImage.image = nil
        liveImage.clear()
    }

}
