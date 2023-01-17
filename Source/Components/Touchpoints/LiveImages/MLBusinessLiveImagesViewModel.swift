//
//  MLBusinessLiveImagesViewModel.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 20/12/2022.
//

import Foundation

protocol LiveImageViewModelDelegate: AnyObject {
    func setStaticImage(with image: UIImage)
    func setAnimatedImage(with url: String)
    func changeState(to state: MLBusinessLiveImagesState)
    func transitionView()
    func clear()
}

protocol MLBusinessLiveImagesViewModelProtocol: AnyObject {
    var imageProvider: MLBusinessImageProvider { get set }
    var delegate: LiveImageViewModelDelegate? { get set }
    func update(coverMedia: MLBusinessLiveImagesModel?, cover: String?)
    func shouldHideAnimation(state: MLBusinessLiveImagesState) -> Bool
    func prepareForPlaying(state: MLBusinessLiveImagesState)
    func prepareForStoping(state: MLBusinessLiveImagesState)
}

final class MLBusinessLiveImagesViewModel: MLBusinessLiveImagesViewModelProtocol {
    var imageProvider: MLBusinessImageProvider
    weak var delegate: LiveImageViewModelDelegate?
    private var delayWork: DispatchWorkItem?
    
    public init(imageProvider: MLBusinessImageProvider? = nil) {
        self.imageProvider = imageProvider ?? MLBusinessURLImageProvider()
    }

    func update(coverMedia: MLBusinessLiveImagesModel?, cover: String?) {
        
        delegate?.clear()
        
        if let coverMedia = coverMedia {
            if let thumbnail = coverMedia.getThumbnail(), let url = coverMedia.getMediaLink() {
                loadImage(key: thumbnail)
                self.delegate?.changeState(to: .stoped)
                loadAnimatedImage(key: url)
            }
            
        } else if let cover = cover {
            self.delegate?.changeState(to: .bloqued)
            loadImage(key: cover)
        }
    }
    
    private func loadImage(key: String) {
        imageProvider.getImage(key: key, completion:{ [weak self] image in
            if let image = image {
                self?.delegate?.setStaticImage(with: image)
            }
        })
    }
    
    private func loadAnimatedImage(key: String) {
        
        MLBusinessLiveImagesProvider.shared.getLiveImageData(from: key, completion: {
            [weak self] data in
            
            DispatchQueue.main.async {
                self?.delegate?.setAnimatedImage(with: data?.base64EncodedString() ?? "")
            }
        })
    }
    
    func shouldHideAnimation(state: MLBusinessLiveImagesState) -> Bool {
        return state != .playing
    }
    
    func prepareForStoping(state: MLBusinessLiveImagesState) {
        if state != .bloqued {
            delayWork?.cancel()
            delegate?.changeState(to: .stoped)
            delegate?.transitionView()
        }
    }
    
    func prepareForPlaying(state: MLBusinessLiveImagesState) {
        if state != .bloqued {
            let shouldDelay = state != .readyToPlay
            showAnimatedImage(shouldDelay: shouldDelay)
        }
    }
        
    private func showAnimatedImage(shouldDelay: Bool, delayTime: CGFloat = 1.5) {
        if shouldDelay {
            self.delayWork = DispatchWorkItem(block: {
                self.startAnimation()
            })

            if let work = delayWork {
                DispatchQueue.main.asyncAfter(deadline: .now() + delayTime, execute: work)
            }

        } else {
            startAnimation()
        }
    }
    
    private func startAnimation() {
        self.delegate?.changeState(to: .playing)
        self.delegate?.transitionView()
    }
}
