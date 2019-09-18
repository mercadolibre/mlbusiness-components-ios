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
        let downloadAppView = setupDownloadAppView(bottomOf: discountView)
        let crossSellingBoxView = setupCrossSellingBoxView(bottomOf: downloadAppView)
        setupLoyaltyHeaderView(bottomOf: crossSellingBoxView)
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

    private func setupDownloadAppView(bottomOf targetView: UIView) -> MLBusinessDownloadAppView {
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
        
        return downloadAppView
    }
    
    private func setupLoyaltyHeaderView(bottomOf targetView: UIView) -> MLBusinessLoyaltyHeaderView {
        let loyaltyHeaderView = MLBusinessLoyaltyHeaderView(LoyaltyHeaderData(), fillPercentProgress: true)
        view.addSubview(loyaltyHeaderView)
        NSLayoutConstraint.activate([
            loyaltyHeaderView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 16),
            loyaltyHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            loyaltyHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
            ])
        return loyaltyHeaderView
    }

    private func setupCrossSellingBoxView(bottomOf targetView: UIView) -> MLBusinessCrossSellingBoxView {

        let crossSellingBoxView = MLBusinessCrossSellingBoxView(CrossSellingBoxData())
        view.addSubview(crossSellingBoxView)
        NSLayoutConstraint.activate([
            crossSellingBoxView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            crossSellingBoxView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            crossSellingBoxView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 16)
        ])

        crossSellingBoxView.addTapAction { (deepLink) in
            print(deepLink)
        }
        
        return crossSellingBoxView
    }
}

extension ViewController {
    private func animateRing() {
        ringView?.fillPercentProgressWithAnimation()
    }
}
