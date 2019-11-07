//
//  MLBusinessBombCongratsAnimatedButton.swift
//  MLBusinessComponents
//
//  Created by Javier Quiles on 06/11/2019.
//

import Foundation
import MLUI

public class MLBusinessBombCongratsAnimatedButton: UIButton {

    private var progressView: MLBusinessBombCongratsProgressView?
    private var animatedView = UIView(frame: .zero)

    private let normalLabel: String
    private let loadingLabel: String

    public weak var delegate: MLBusinessBombCongratsAnimatedButtonDelegate?

    public init(normalLabel: String, loadingLabel: String) {
        self.normalLabel = normalLabel
        self.loadingLabel = loadingLabel

        super.init(frame: .zero)
        setupView()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 48).isActive = true
        setTitle(normalLabel, for: .normal)
        layer.cornerRadius = 4
        backgroundColor = MLStyleSheetManager.styleSheet.secondaryColor
        layer.borderColor = MLStyleSheetManager.styleSheet.secondaryColor.cgColor
        titleLabel?.font = MLStyleSheetManager.styleSheet.regularSystemFont(ofSize: CGFloat(kMLFontsSizeMedium))
    }

    public func startLoading(timeOut: TimeInterval = 15.0) {
        progressView = MLBusinessBombCongratsProgressView(view: self, timeOut: timeOut)
        setTitle(loadingLabel, for: .normal)
    }

    public func finishLoading(color: UIColor, image: String) {
        progressView?.finish { [weak self] in
            guard let self = self else { return }

            self.animatedView.frame = self.frame
            self.animatedView.backgroundColor = self.backgroundColor
            self.animatedView.layer.cornerRadius = self.layer.cornerRadius
            self.superview?.addSubview(self.animatedView)
            self.alpha = 0

            let circleFrame = CGRect(x: self.frame.midX - self.frame.height / 2,
                                     y: self.frame.minY,
                                     width: self.frame.height,
                                     height: self.frame.height)

            let animation = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 1, animations: {
                self.animatedView.frame = circleFrame
                self.animatedView.layer.cornerRadius = circleFrame.height / 2
            })

            animation.addCompletion({ [weak self] _ in
                self?.explosion(newFrame: circleFrame, color: color, image: image)
            })

            animation.startAnimation()
        }
    }

    private func explosion(newFrame: CGRect, color: UIColor, image: String) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.progressView?.alpha = 0
            self?.animatedView.backgroundColor = color
        }, completion: { _ in
            let scaleFactor: CGFloat = 0.40
            let imageView = UIImageView(frame: CGRect(x: newFrame.width / 2 - (newFrame.width * scaleFactor) / 2,
                                                      y: newFrame.width / 2 - (newFrame.width * scaleFactor) / 2,
                                                      width: newFrame.width * scaleFactor,
                                                      height: newFrame.height * scaleFactor))

            imageView.contentMode = .scaleAspectFit
            imageView.alpha = 0

            self.animatedView.addSubview(imageView)

            UIView.animate(withDuration: 0.6, animations: {
                imageView.alpha = 1
                imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: { _ in
                UIView.animate(withDuration: 0.4, animations: {
                    imageView.alpha = 0
                }, completion: { [weak self] _ in
                    self?.superview?.layer.masksToBounds = false
                    UIView.animate(withDuration: 0.5, animations: {
                        self?.animatedView.transform = CGAffineTransform(scaleX: 50, y: 50)
                    }, completion: { [weak self] _ in
                        self?.delegate?.didFinishAnimation?()
                    })
                })
            })
        })
    }

}
