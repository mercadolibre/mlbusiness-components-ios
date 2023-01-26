//
//  MLBusinessLiveImagesViewModel.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 20/12/2022.
//

import Foundation

enum MLBusinessLiveImagesState {
    case init_multimedia
    case playing
    case paused
    case ready_to_play
    case download
    case download_failed
    case download_success
    case blocked
}

protocol MultimediaListener: AnyObject {
    func onChangeState(state: MLBusinessLiveImagesState)
}

protocol ImageAnimationManagerDelegate: AnyObject {
    func setStaticImage(with image: UIImage)
    func setAnimatedImage(with url: String)
    func transitionView()
    func clear()
}

protocol ImageAnimationManagerProtocol: AnyObject {
    var imageProvider: MLBusinessImageProvider { get set }
    var delegate: ImageAnimationManagerDelegate? { get set }
    var multimediaListener: MultimediaListener? {get set}
    func update(coverMedia: MLBusinessLiveImagesModel?, cover: String?)
    func changeState(to state: MLBusinessLiveImagesState)
    func shouldHideAnimation() -> Bool
    func play()
    func stop()
}

final class ImageAnimationManager: ImageAnimationManagerProtocol {
    var multimediaListener: MultimediaListener?
    var imageProvider: MLBusinessImageProvider
    weak var delegate: ImageAnimationManagerDelegate?
    private var delayWork: DispatchWorkItem?
    private var liveImageState: MLBusinessLiveImagesState = .paused
    private var playPending: Bool = false
        
    private func loadImage(key: String) {
        imageProvider.getImage(key: key, completion:{ [weak self] image in
            if let image = image {
                self?.delegate?.setStaticImage(with: image)
            }
        })
    }
    
    private func loadAnimatedImage(key: String) {
        changeState(to: .download)
        MLBusinessLiveImagesProvider.shared.getLiveImageData(from: key, completion: {
            [weak self] data in
            
            DispatchQueue.main.async {
                if let dataEncoded = data?.base64EncodedString() {
                    self?.changeState(to: .download_success)
                    self?.delegate?.setAnimatedImage(with: dataEncoded)
                } else {
                    self?.changeState(to: .download_failed)
                    self?.changeState(to: .blocked)
                }
            }
        })
    }
    
    private func delayAnimation(delayTime: CGFloat = 1.5) {
        self.delayWork = DispatchWorkItem(block: {
            self.startAnimation()
        })

        if let work = delayWork {
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime, execute: work)
        }
    }
    
    private func startAnimation() {
        changeState(to: .playing)
        self.delegate?.transitionView()
    }
    
    public init(imageProvider: MLBusinessImageProvider? = nil) {
        self.imageProvider = imageProvider ?? MLBusinessURLImageProvider()
    }

    func update(coverMedia: MLBusinessLiveImagesModel?, cover: String?) {
        delegate?.clear()
        changeState(to: .init_multimedia)
        if let coverMedia = coverMedia {
            if let thumbnail = coverMedia.getThumbnail(), let url = coverMedia.getMediaLink() {
                loadImage(key: thumbnail)
                changeState(to: .paused)
                loadAnimatedImage(key: url)
            }
            
        } else if let cover = cover {
            changeState(to: .blocked)
            loadImage(key: cover)
        }
    }
    
    func shouldHideAnimation() -> Bool {
        return liveImageState != .playing
    }
    
    func stop() {
        playPending = false
        if liveImageState != .blocked {
            delayWork?.cancel()
            changeState(to: .paused)
            delegate?.transitionView()
        }
    }
    
    func play() {
        playPending = true
        if liveImageState != .blocked {
            if liveImageState != .ready_to_play {
                delayAnimation()
            } else {
                tryPlayingAnimation()
            }
        }
    }
        
    func changeState(to state: MLBusinessLiveImagesState) {
        if liveImageState == .playing && state == .paused {
            liveImageState = .ready_to_play
        } else {
            liveImageState = state
        }
        
        multimediaListener?.onChangeState(state: liveImageState)
    }
    
    func tryPlayingAnimation() {
        if playPending && liveImageState == .ready_to_play {
            changeState(to: .playing)
            delegate?.transitionView()
        }
    }
}
