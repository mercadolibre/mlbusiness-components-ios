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
    func changeState()
}

class MLBusinessLiveImagesView: UIView {
    
    var imageProvider: MLBusinessImageProvider
    var liveImageState: MLBusinessLiveImagesState = .stoped
    
    public init(with imageProvider: MLBusinessImageProvider? = nil) {
        self.imageProvider = imageProvider ?? MLBusinessURLImageProvider()
        super.init(frame: .zero)
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
        return view
    }()
    
    
    
    func update(coverMedia: MLBusinessLiveImagesModel?, cover: String?){
        
        clear()
        
        if let coverMedia = coverMedia {
            setAnimatedImage(media: coverMedia)
            
        } else if let cover = cover {
            imageProvider.getImage(key: cover) { [weak self] image in
                self?.thumbnailImage.image = image
            }
        }
    }
    
    private func setAnimatedImage(media: MLBusinessLiveImagesModel) {
        if let thumbnail = media.getThumbnail(), let media = media.getMediaLink(){
            imageProvider.getImage(key: thumbnail) { [weak self] image in
                self?.thumbnailImage.image = image
            }
            
            liveImage.loadImage(from: media)
        }
    }
           
    private func clear() {
        thumbnailImage.image = nil
    }
    
}

extension MLBusinessLiveImagesView: MLBusinessLiveImagesHelper {
    func changeState() {
        self.liveImageState = liveImageState == .stoped ? .playing : .stoped
        playStopLiveImage(liveImageState: liveImageState)
    }
    
    func playAnimation() {
        
        UIView.transition(with: self.liveImage,
                                      duration: 1,
                                      options: .transitionCrossDissolve,
                                      animations: {
            self.liveImage.isHidden = false
            self.thumbnailImage.isHidden = true
                                        },
                                      completion: nil)
    }
    
    func stopAnimation() {
        thumbnailImage.isHidden = false
        liveImage.isHidden = true
    }
    
    private func playStopLiveImage(liveImageState: MLBusinessLiveImagesState ) {
        
        switch(liveImageState) {
        case .stoped:
            stopAnimation()
        case .playing:
           playAnimation()
        }
        
    }
    
}
