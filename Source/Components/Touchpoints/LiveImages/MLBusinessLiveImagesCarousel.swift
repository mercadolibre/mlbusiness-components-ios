//
//  MLBusinessLiveImagesCarouselView.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 19/01/2023.
//

import Foundation

protocol MLBusinessMultimediaCarousel: AnyObject {
    func playOnFocus(currentCell: MLBusinessLiveImagesCellView)
    func startByPosition(_ position: Int, cell: MLBusinessLiveImagesCellView, positionFocused: Int)
    func restartFocused(_ position: Int, cell: MLBusinessLiveImagesCellView, positionFocused: Int)
    func pauseFocused()
    func updateConfig()
}


final class MLBusinessMultimediaCarouselImplementation: MLBusinessMultimediaCarousel {
    private var lastCellFocused: MLBusinessLiveImagesCellView?
    private var currentCellFocused: MLBusinessLiveImagesCellView?
    
    func startByPosition(_ position: Int, cell: MLBusinessLiveImagesCellView, positionFocused: Int) {
        if position == 0 && positionFocused == 0 {
            playOnFocus(currentCell: cell)
        }
    }
    
    func playOnFocus(currentCell: MLBusinessLiveImagesCellView) {
        currentCellFocused = currentCell
        if let lastCellFocused = lastCellFocused {
            pauseMultimediaByCell(lastCellFocused)
            self.lastCellFocused = currentCellFocused
            currentCellFocused?.play()
        } else {
            self.lastCellFocused = currentCellFocused
            self.lastCellFocused?.play()
        }
    }
    
    func restartFocused(_ position: Int, cell: MLBusinessLiveImagesCellView, positionFocused: Int) {
        startByPosition(position, cell: cell, positionFocused: positionFocused)
        
        //TODO: updateConfig()
    }
    
    func pauseFocused() {
        currentCellFocused?.pause()
    }
    
    func pauseMultimediaByCell(_ cell: MLBusinessLiveImagesCellView) {
        cell.pause()
    }
    
    func updateConfig() {
        //TODO: WifiUtils and BatteryUtils
    }
}
