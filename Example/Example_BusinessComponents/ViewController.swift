//
//  ViewController.swift
//  Example_BusinessComponents
//
//  Created by Juan sebastian Sanzone on 9/9/19.
//  Copyright © 2019 Mercado Libre. All rights reserved.
//

import UIKit
import MLBusinessComponents

class ViewController: UIViewController {
    private weak var ringView: MLBusinessLoyaltyRingView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateRing()
    }
}

// MARK: Setups
extension ViewController {
    private func setupView() {
        let newRingView = setupRingView()
        self.ringView = newRingView
        let dividingLineView = setupDividingLineView(bottomOf: newRingView)
        let discountView = setupDiscountView(bottomOf: dividingLineView)
        setupDownloadAppView(bottomOf: discountView)
    }

    private func setupRingView() -> MLBusinessLoyaltyRingView {
        let ringView = MLBusinessLoyaltyRingView(LoyaltyRingData(), fillPercentProgress: false)

        view.addSubview(ringView)

        NSLayoutConstraint.activate([
            ringView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ringView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ringView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])

        ringView.addTapAction { deepLink in
            print(deepLink)
        }

        return ringView
    }

    private func setupDividingLineView(bottomOf targetView: UIView) -> UIView {
        let dividingLineView = MLBusinessDividingLineView(hasTriangle: true)
        view.addSubview(dividingLineView)
        NSLayoutConstraint.activate([
            dividingLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            dividingLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            dividingLineView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 20)
        ])

        return dividingLineView
    }

    private func setupDiscountView(bottomOf targetView: UIView) -> MLBusinessDiscountBoxView {
        let discountView = MLBusinessDiscountBoxView(DiscountData())
        view.addSubview(discountView)
        NSLayoutConstraint.activate([
            discountView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            discountView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            discountView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 16)
        ])

        discountView.addTapAction { (selectedIndex, deepLink, trackId) in
            // To test update data feature.
            if selectedIndex == 0 {
                discountView.update(DiscountDataForTestUpdate())
            } else {
                discountView.update(DiscountData())
            }
        }
        return discountView
    }

    private func setupDownloadAppView(bottomOf targetView: UIView) {
        let downloadAppView = MLBusinessDownloadAppView(DownloadAppData())
        view.addSubview(downloadAppView)
        NSLayoutConstraint.activate([
            downloadAppView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 16),
            downloadAppView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            downloadAppView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        downloadAppView.addTapAction { (deepLink) in
//            print(deepLink)
        }
    }
}

extension ViewController {
    private func animateRing() {
        ringView?.fillPercentProgressWithAnimation()
    }
}
