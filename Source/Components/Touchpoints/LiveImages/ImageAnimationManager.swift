//
//  MLBusinessLiveImagesViewModel.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 20/12/2022.
//

import Foundation

protocol ImageAnimationManagerDelegate: AnyObject {
    func setStaticImage(with image: UIImage)
    func setAnimatedImage(with url: String)
    func changeState(to state: MLBusinessLiveImagesState)
    func transitionView()
    func clear()
}

protocol ImageAnimationManagerProtocol: AnyObject {
    var imageProvider: MLBusinessImageProvider { get set }
    var delegate: ImageAnimationManagerDelegate? { get set }
    func update(coverMedia: MLBusinessLiveImagesModel?, cover: String?)
    func shouldHideAnimation(state: MLBusinessLiveImagesState) -> Bool
    func play(currentState: MLBusinessLiveImagesState)
    func stop(currentState: MLBusinessLiveImagesState)
}

final class ImageAnimationManager: ImageAnimationManagerProtocol {
    var imageProvider: MLBusinessImageProvider
    weak var delegate: ImageAnimationManagerDelegate?
    private var delayWork: DispatchWorkItem?
    
    public init(imageProvider: MLBusinessImageProvider? = nil) {
        self.imageProvider = imageProvider ?? MLBusinessURLImageProvider()
    }

    func update(coverMedia: MLBusinessLiveImagesModel?, cover: String?) {
        
        delegate?.clear()
        
        if let coverMedia = coverMedia {
            if let thumbnail = coverMedia.getThumbnail(), let url = coverMedia.getMediaLink() {
                loadImage(key: thumbnail)
                self.delegate?.changeState(to: .paused)
                loadAnimatedImage(key: url)
            }
            
        } else if let cover = cover {
            self.delegate?.changeState(to: .blocked)
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
                if let dataEncoded = data?.base64EncodedString() {
                    self?.delegate?.setAnimatedImage(with: dataEncoded)
                } else {
                    self?.delegate?.changeState(to: .blocked)
                }
            }
        })
    }
    
    func shouldHideAnimation(state: MLBusinessLiveImagesState) -> Bool {
        return state != .playing
    }
    
    func stop(currentState: MLBusinessLiveImagesState) {
        if currentState != .blocked {
            delayWork?.cancel()
            delegate?.changeState(to: .paused)
            delegate?.transitionView()
        }
    }
    
    func play(currentState: MLBusinessLiveImagesState) {
        if currentState != .blocked {
            let shouldDelay = currentState != .download_success
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
