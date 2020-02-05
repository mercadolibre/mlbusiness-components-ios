//
//  MLBusinessAnimatedButtonProgressView.swift
//  MLBusinessComponents
//
//  Created by Javier Quiles on 05/11/2019.
//

import Foundation
import MLUI

final class MLBusinessAnimatedButtonProgressView: UIView {

    private var deltaIncrementFraction: CGFloat = 6.0
    private let progressViewHeight: CGFloat
    private let progressViewWidth: CGFloat
    private let progressViewAlpha: CGFloat = 0.35

    private var timer: Timer?
    private let timeOut: TimeInterval
    private let timeInterval: TimeInterval = 0.3
    private var timeCounter: Int = 0

    weak var delegate: MLBusinessAnimatedButtonProgressViewDelegate?

    init(view: UIView, timeOut: TimeInterval = 15) {
        progressViewHeight = view.frame.height
        progressViewWidth = view.frame.width
        self.timeOut = timeOut

        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: progressViewHeight))

        backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666876018, blue: 0.2666300237, alpha: 0.4)
        layer.cornerRadius = view.layer.cornerRadius
        alpha = progressViewAlpha

        view.layer.masksToBounds = true
        view.addSubview(self)

        initTimer()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.5,
                                     target: self,
                                     selector: #selector(increment),
                                     userInfo: nil,
                                     repeats: true)
    }

    private func stopTimer () {
        timer?.invalidate()
        timer = nil
    }

    @objc
    private func increment() {
        timeCounter += 1

        let oldWidth = progressViewWidth - frame.width
        let newWidth = frame.width + oldWidth / deltaIncrementFraction
        let newFrame = CGRect(x: 0, y: 0, width: newWidth, height: frame.height)
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.frame = newFrame
        }, completion: { [weak self] _ in
            guard let self = self else { return }

            if Double(self.timeCounter) * self.timeInterval > self.timeOut {
                self.stopTimer()
                self.delegate?.progressViewTimeOut()
            } else if self.timeCounter == 5 || self.timeCounter == 10 {
                self.deltaIncrementFraction *= 2
            }
        })
        
    }

    func reset() {
        frame = CGRect(x: 0, y: 0, width: 0, height: frame.height)
    }

    func finish(completion: @escaping () -> Void) {
        let newFrame = CGRect(x: 0, y: 0, width: progressViewWidth, height: frame.height)

        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.frame = newFrame
        }, completion: { [weak self] _ in
            self?.stopTimer()
            completion()
        })
    }

}
