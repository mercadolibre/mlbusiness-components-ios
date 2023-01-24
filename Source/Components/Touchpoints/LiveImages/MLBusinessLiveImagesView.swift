//
//  MLBusinessLiveImagesView.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 15/12/2022.
//

import Foundation

enum MLBusinessLiveImagesState {
    case playing
    case paused
    case download_success
    case blocked
}

protocol MLBusinessLiveImagesHelper {
    func play()
    func pause()
}

class MLBusinessLiveImagesCellView: UICollectionViewCell, MLBusinessLiveImagesHelper {
    func play() {}
    func pause() {}
}

class MLBusinessLiveImagesView: UIView {
    
    private var viewModel: ImageAnimationManagerProtocol
    var liveImageState: MLBusinessLiveImagesState = .paused
    
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
    
    public init(with imageProvider: MLBusinessImageProvider? = nil, viewModel: ImageAnimationManagerProtocol = ImageAnimationManager()) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.viewModel.delegate = self
        self.viewModel.imageProvider = imageProvider ?? MLBusinessURLImageProvider()
        
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
        
        liveImage.isHidden = true
        thumbnailImage.isHidden =  false
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
 
    func update(coverMedia: MLBusinessLiveImagesModel?, cover: String?){
        viewModel.update(coverMedia: coverMedia, cover: cover)
    }
}

extension MLBusinessLiveImagesView: MLBusinessLiveImagesHelper {
    
    func play() {
        viewModel.play(currentState: liveImageState)
    }
    
    func pause() {
        viewModel.stop(currentState: liveImageState)
    }
}

extension MLBusinessLiveImagesView: ImageAnimationManagerDelegate {
    
    func transitionView() {
        self.liveImage.isHidden = self.viewModel.shouldHideAnimation(state: self.liveImageState)
    }
        
    func setStaticImage(with image: UIImage) {
        thumbnailImage.image = image
    }
    
    func setAnimatedImage(with url: String) {
        liveImage.loadImage(from: url)
    }
    
    func changeState(to state: MLBusinessLiveImagesState) {
        if liveImageState == .playing && state == .paused {
            liveImageState = .download_success
        } else {
            liveImageState = state
        }
    }
    
    func clear() {
        liveImageState = .blocked
        thumbnailImage.image = nil
        liveImage.isHidden = true
        liveImage.clear()
    }
}
