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
    func clear()
}

protocol MLBusinessLiveImagesViewModelProtocol: AnyObject {
    var imageProvider: MLBusinessImageProvider { get set }
    var delegate: LiveImageViewModelDelegate? { get set }
    func update(coverMedia: MLBusinessLiveImagesModel?, cover: String?)
    func shouldHideThumbnail(state: MLBusinessLiveImagesState) -> Bool
    func shouldHideAnimation(state: MLBusinessLiveImagesState) -> Bool
}

final class MLBusinessLiveImagesViewModel: MLBusinessLiveImagesViewModelProtocol {
    
    var imageProvider: MLBusinessImageProvider
    weak var delegate: LiveImageViewModelDelegate?
    
    public init(imageProvider: MLBusinessImageProvider? = nil) {
        self.imageProvider = imageProvider ?? MLBusinessURLImageProvider()
    }
    
    func update(coverMedia: MLBusinessLiveImagesModel?, cover: String?) {
        
        delegate?.clear()
        
        if let coverMedia = coverMedia {
            
            if let thumbnail = coverMedia.getThumbnail(), let url = coverMedia.getMediaLink() {
                
                imageProvider.getImage(key: thumbnail, completion: { [weak self] image in
                    if let image = image {
                        self?.delegate?.setStaticImage(with: image)
                    }
                })
                
                self.delegate?.setAnimatedImage(with: url)
            }
            
        } else if let cover = cover {
                
            imageProvider.getImage(key: cover, completion:{ [weak self] image in
                
                if let image = image {
                    self?.delegate?.setStaticImage(with: image)
                    self?.delegate?.changeState(to: .stoped)
                }
            })
        }
    }
    
    func shouldHideThumbnail(state: MLBusinessLiveImagesState) -> Bool {
        return state == .playing
    }
    
    func shouldHideAnimation(state: MLBusinessLiveImagesState) -> Bool {
        return !shouldHideThumbnail(state: state)
    }
}