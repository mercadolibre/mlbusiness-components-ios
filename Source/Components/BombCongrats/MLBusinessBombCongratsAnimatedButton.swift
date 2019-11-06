//
//  MLBusinessBombCongratsAnimatedButton.swift
//  MLBusinessComponents
//
//  Created by Javier Quiles on 06/11/2019.
//

import Foundation

class MLBusinessBombCongratsAnimatedButton: UIButton {

    private var progressView: MLBusinessBombCongratsProgressView?

    private let normalLabel: String
    private let loadingLabel: String
    private let retryLabel: String

    init(normalLabel: String, loadingLabel: String, retryLabel: String) {
        self.normalLabel = normalLabel
        self.loadingLabel = loadingLabel
        self.retryLabel = retryLabel

        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
