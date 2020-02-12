//
//  MLBusinessAnimatedButton.swift
//  MLBusinessComponents
//
//  Created by Javier Quiles on 06/11/2019.
//

import Foundation
import MLUI

@objc
public class MLBusinessAnimatedButton: UIButton {

    private var progressView: MLBusinessAnimatedButtonProgressView?
    private var animatedView = UIView(frame: .zero)

    @objc private let normalLabel: String
    @objc private let loadingLabel: String

    @objc public weak var delegate: MLBusinessAnimatedButtonDelegate?

    public override var isEnabled: Bool {
        didSet {
            backgroundColor = self.isEnabled ? MLStyleSheetManager.styleSheet.secondaryColor : MLStyleSheetManager.styleSheet.lightGreyColor
        }
    }

    @objc
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
        setTitleColor(MLStyleSheetManager.styleSheet.whiteColor, for: .normal)
        setTitleColor(MLStyleSheetManager.styleSheet.greyColor, for: .disabled)
        layer.cornerRadius = 4
        backgroundColor = MLStyleSheetManager.styleSheet.secondaryColor
        layer.borderColor = MLStyleSheetManager.styleSheet.secondaryColor.cgColor
        titleLabel?.font = MLStyleSheetManager.styleSheet.regularSystemFont(ofSize: CGFloat(kMLFontsSizeMedium))
    }

    @objc
    public func startLoading(timeOut: TimeInterval = 15.0) {
        progressView = MLBusinessAnimatedButtonProgressView(view: self, timeOut: timeOut)
        progressView?.delegate = self
        setTitle(loadingLabel, for: .normal)
    }

    @objc
    public func resetLoading() {
        progressView?.reset()
    }

    @objc
    public func finishLoading(color: UIColor, image: UIImage?) {
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

    @objc
    public func goToNextViewController(_ nextViewController: UIViewController,
                                       _ navController: UINavigationController,
                                       transitionDuration: TimeInterval = 0.4,
                                       shouldPop: Bool = false) {
        let transition = CATransition()
        transition.duration = transitionDuration
        transition.type = .fade
        navController.view.layer.add(transition, forKey: nil)

        var stack = navController.viewControllers

        if shouldPop { stack.removeLast() }
        
        stack.append(nextViewController)
        navController.setViewControllers(stack, animated: false)
    }

    private func explosion(newFrame: CGRect, color: UIColor, image: UIImage?) {
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
            imageView.image = image

            self.animatedView.addSubview(imageView)

            UIView.animate(withDuration: 0.6, animations: {
                imageView.alpha = 1
                imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: { _ in
                UIView.animate(withDuration: 0.4, animations: {
                    imageView.alpha = 0
                }, completion: { [weak self] _ in
                    guard let self = self else { return }
                    self.superview?.layer.masksToBounds = false
                    self.delegate?.expandAnimationInProgress?()
                    UIView.animate(withDuration: 0.5, animations: {
                        self.animatedView.transform = CGAffineTransform(scaleX: 50, y: 50)
                    }, completion: { [weak self] _ in
                        guard let self = self else { return }
                        self.delegate?.didFinishAnimation(self)
                    })
                })
            })
        })
    }

}

extension MLBusinessAnimatedButton: MLBusinessAnimatedButtonProgressViewDelegate {
    func progressViewTimeOut() {
        delegate?.progressButtonAnimationTimeOut()
    }
}
