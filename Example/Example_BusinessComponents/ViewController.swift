//
//  ViewController.swift
//  Example_BusinessComponents
//
//  Created by Juan sebastian Sanzone on 9/9/19.
//  Copyright © 2019 Mercado Libre. All rights reserved.
//

import UIKit
import MLBusinessComponents

class ViewController: UIViewController, MLBusinessLoyaltyBroadcastReceiver {
    
    @IBOutlet private weak var containerView: UIView!
    
    private weak var ringView: MLBusinessLoyaltyRingView?
    private weak var loyaltyHeaderView: MLBusinessLoyaltyHeaderView?
    private var discountTouchpointsView: MLBusinessTouchpointsView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateRing()
    }
    
    func receiveInfo(_ notification: Notification) {
        if let loyaltyBroadcastData = notification.object as? MLBusinessLoyaltyBroadcastData {
            NSLog("Received info from broadcast: Level %i - Percentage %d - Color %@", loyaltyBroadcastData.level, loyaltyBroadcastData.percentage, loyaltyBroadcastData.primaryColor)
        }
     }
    
}

// MARK: Setups
extension ViewController {
    private func setupView(_ receiver: MLBusinessLoyaltyBroadcastReceiver) {
        let newRingView = setupRingView(receiver)
        self.ringView = newRingView
        let dividingLineView = setupDividingLineView(bottomOf: newRingView)
        let itemDescriptionView = setupItemDescriptionView(bottomOf: dividingLineView)
        let crossSellingBoxView = setupCrossSellingBoxView(bottomOf: itemDescriptionView)
        let discountView = setupDiscountView(numberOfItems: 6, bottomOf: crossSellingBoxView)
        let actionCardView = setupActionCardView(bottomOf: discountView)
        let discountTouchpointView = setupDiscountTouchpointsView(numberOfItems: 6, bottomOf: actionCardView)
        let downloadAppView = setupDownloadAppView(bottomOf: discountTouchpointView)
        let loyaltyHeaderView = setupLoyaltyHeaderView(bottomOf: downloadAppView)
        let animatedButtonView = setupAnimatedButtonView(bottomOf: loyaltyHeaderView)
        let rowView = setupRowView(bottomOf: animatedButtonView)
        let hybridCarousel = setupHybridCarouselView(bottomOf: rowView)
        let multipleRowTouchpointView = setupMultipleRowTouchpointView(bottomOf: hybridCarousel)
        
        /* Cover Carousel */
        
        let carouselView = setupCoverCarouselView(bottomOf: multipleRowTouchpointView)
        
        /******************/
        
        let openSheet = setupSheetViewController(bottomOf: carouselView)
        
        openSheet.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -64).isActive = true
    }
    
    private func setupCoverCarouselView(bottomOf topView: UIView) -> UIView {
        let carousel = MLBusinessCoverCarouselContainerView()
        
        containerView.addSubview(carousel)
        
        NSLayoutConstraint.activate([
            carousel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            carousel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            carousel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 16)
        ])
        
        let cardModels = [MLBusinessCoverCarouselContainerItemModel(row: RowData()), MLBusinessCoverCarouselContainerItemModel(row: RowData())]
        carousel.update(with: cardModels)
        
        return carousel
    }

    private func setupRingView(_ receiver: MLBusinessLoyaltyBroadcastReceiver) -> MLBusinessLoyaltyRingView {
        let ringData = LoyaltyRingData()
        let ringView = MLBusinessLoyaltyRingView(ringData, fillPercentProgress: false)

        containerView.addSubview(ringView)

        NSLayoutConstraint.activate([
            ringView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            ringView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            ringView.topAnchor.constraint(equalTo: containerView.topAnchor)
        ])

        ringView.addTapAction { deepLink in
            print(deepLink)
        }
        
        let broadcaster = MLBusinessLoyaltyBroadcaster.instance as MLBusinessLoyaltyBroadcaster
        broadcaster.register(receiver)
        broadcaster.updateInfo(MLBusinessLoyaltyBroadcastData(level: ringData.getRingNumber(),
                                                              percentage: ringData.getRingPercentage(),
                                                              primaryColor: ringData.getRingHexaColor()))
        
        return ringView
    }

    private func setupDividingLineView(bottomOf targetView: UIView) -> UIView {
        let dividingLineView = MLBusinessDividingLineView(hasTriangle: true)
        containerView.addSubview(dividingLineView)
        NSLayoutConstraint.activate([
            dividingLineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32),
            dividingLineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32),
            dividingLineView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 20)
        ])
        return dividingLineView
    }

    private func setupDiscountView(numberOfItems: Int, bottomOf targetView: UIView) -> MLBusinessDiscountBoxView {
        let discountView = MLBusinessDiscountBoxView(DiscountData(numberOfItems: numberOfItems))
        containerView.addSubview(discountView)
        NSLayoutConstraint.activate([
            discountView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            discountView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            discountView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 16)
        ])
        discountView.addTapAction { (selectedIndex, deepLink, trackId) in
            print("EBC: index \(selectedIndex), deeplink: \(deepLink ?? ""), trackId: \(trackId ?? "")")
            discountView.update(DiscountData(numberOfItems: Int.random(in: 1...6)))
        }
        return discountView
    }

    private func setupActionCardView(bottomOf targetView: UIView) -> MLBusinessActionCardView {
        let actionCardView = MLBusinessActionCardView(ActionCardData())
        containerView.addSubview(actionCardView)
        NSLayoutConstraint.activate([
            actionCardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            actionCardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            actionCardView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 16)
        ])
        actionCardView.addTapAction {
            print("Button tapped")
        }
        return actionCardView
    }
    
    private func setupDiscountTouchpointsView(numberOfItems: Int, bottomOf targetView: UIView) -> UIView {
        discountTouchpointsView = MLBusinessTouchpointsView()
        guard let discountTouchpointsView = discountTouchpointsView else { return UIView(frame: .zero) }
        discountTouchpointsView.delegate = self
        discountTouchpointsView.setTouchpointsTracker(with: DiscountTrackerData(touchPointId: "BusinessComponents-Example"))
        discountTouchpointsView.update(with: DiscountTouchpointsGridData(numberOfItems: numberOfItems))
        containerView.addSubview(discountTouchpointsView)
        NSLayoutConstraint.activate([
            discountTouchpointsView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            discountTouchpointsView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            discountTouchpointsView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 16)
        ])
        return discountTouchpointsView
    }
    
    private func setupDownloadAppView(bottomOf targetView: UIView) -> MLBusinessDownloadAppView {
        let downloadAppView = MLBusinessDownloadAppView(DownloadAppData())
        containerView.addSubview(downloadAppView)
        NSLayoutConstraint.activate([
            downloadAppView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 16),
            downloadAppView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            downloadAppView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])

        downloadAppView.addTapAction { (deepLink) in
//            print(deepLink)
        }
        
        return downloadAppView
    }

    private func setupCrossSellingBoxView(bottomOf targetView: UIView) -> MLBusinessCrossSellingBoxView {

        let crossSellingBoxView = MLBusinessCrossSellingBoxView(CrossSellingBoxData())
        containerView.addSubview(crossSellingBoxView)
        NSLayoutConstraint.activate([
            crossSellingBoxView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            crossSellingBoxView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            crossSellingBoxView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 16)
        ])

        crossSellingBoxView.addTapAction { (deepLink) in
            print(deepLink)
        }
        
        return crossSellingBoxView
    }
    
    private func setupLoyaltyHeaderView(bottomOf targetView: UIView) -> MLBusinessLoyaltyHeaderView {
        let loyaltyHeaderView = MLBusinessLoyaltyHeaderView(LoyaltyHeaderData(), fillPercentProgress: false)
        containerView.addSubview(loyaltyHeaderView)
        NSLayoutConstraint.activate([
            loyaltyHeaderView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 16),
            loyaltyHeaderView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            loyaltyHeaderView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
            ])
        self.loyaltyHeaderView = loyaltyHeaderView
        return loyaltyHeaderView
    }
    
    private func setupItemDescriptionView(bottomOf targetView: UIView) -> MLBusinessItemDescriptionView {
        let itemDescriptionView = MLBusinessItemDescriptionView(ItemDescriptionData())
        containerView.addSubview(itemDescriptionView)
        NSLayoutConstraint.activate([
            itemDescriptionView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 16),
            itemDescriptionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            itemDescriptionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
            ])
        return itemDescriptionView
    }

    private func setupAnimatedButtonView(bottomOf targetView: UIView) -> MLBusinessAnimatedButton {
        let animatedButtonView = MLBusinessAnimatedButton(normalLabel: "Normal", loadingLabel: "Loading")
        containerView.addSubview(animatedButtonView)
        NSLayoutConstraint.activate([
            animatedButtonView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 16),
            animatedButtonView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            animatedButtonView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
        animatedButtonView.addTarget(self, action: #selector(animatedButtonDidTap(_:)), for: .touchUpInside)
        animatedButtonView.delegate = self

        return animatedButtonView
    }
    
    private func setupRowView(bottomOf targetView: UIView) -> MLBusinessRowView {
        let rowView = MLBusinessRowView()
        rowView.update(with: RowData())
        containerView.addSubview(rowView)
        NSLayoutConstraint.activate([
            rowView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 16),
            rowView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            rowView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
        return rowView
    }
    
    private func setupHybridCarouselView(bottomOf targetView: UIView) -> UIView {
        let discountTouchpointsView = MLBusinessTouchpointsView()
        discountTouchpointsView.setTouchpointsTracker(with: DiscountTrackerData(touchPointId: "BusinessComponents-Example"))
        discountTouchpointsView.update(with: HybridCarouselData())
        containerView.addSubview(discountTouchpointsView)
        NSLayoutConstraint.activate([
            discountTouchpointsView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            discountTouchpointsView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            discountTouchpointsView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 16)
        ])
        return discountTouchpointsView
    }
    
    private func setupMultipleRowTouchpointView(bottomOf targetView: UIView) -> UIView {
        let discountTouchpointsView = MLBusinessTouchpointsView()
        discountTouchpointsView.setTouchpointsTracker(with: DiscountTrackerData(touchPointId: "BusinessComponents-Example"))
        discountTouchpointsView.update(with: MultipleRowData())
        containerView.addSubview(discountTouchpointsView)
        NSLayoutConstraint.activate([
            discountTouchpointsView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            discountTouchpointsView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            discountTouchpointsView.topAnchor.constraint(equalTo: targetView.bottomAnchor)
        ])
        return discountTouchpointsView
    }
    
    private func setupSheetViewController(bottomOf targetView: UIView) -> UIView {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open Sheet", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 6.0
        containerView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 16),
            button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 54.0)
        ])
        
        button.addTarget(self, action: #selector(openSheetDidTap), for: .touchUpInside)
        
        return button
    }

    @objc
    private func openSheetDidTap() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello, world!"
        label.textColor = .black
        
        let vc = UIViewController()
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.backgroundColor = .red
        
        vc.view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: vc.view.leftAnchor),
            label.rightAnchor.constraint(equalTo: vc.view.rightAnchor),
            label.topAnchor.constraint(equalTo: vc.view.topAnchor),
            label.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
            vc.view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400)
        ])
        
        let sheet = SheetViewController(rootViewController: vc, sizes: [.intrinsic, .fixedFromTop(100)])
        self.present(sheet, animated: true)
    }
    
    @objc
    private func animatedButtonDidTap(_ button: MLBusinessAnimatedButton) {
        button.startLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            button.finishLoading(color: .ml_meli_green(), image: nil)
        }
    }
}

extension ViewController {
    private func animateRing() {
        ringView?.fillPercentProgressWithAnimation()
        loyaltyHeaderView?.fillPercentProgressWithAnimation()
    }
}

extension ViewController: MLBusinessAnimatedButtonDelegate {
    func expandAnimationInProgress() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func didFinishAnimation(_ animatedButton: MLBusinessAnimatedButton) {
        guard let navigationController = navigationController else { return }

        let newVC = UIViewController()
        newVC.view.backgroundColor = .red

        animatedButton.goToNextViewController(newVC, navigationController)
    }

    func progressButtonAnimationTimeOut() {
        print("TimeOut")
    }

}

extension ViewController: MLBusinessTouchpointsUserInteractionHandler {
    func didTap(with selectedIndex: Int, deeplink: String, trackingId: String) {
        print("EBC: index \(selectedIndex), deeplink: \(deeplink), trackId: \(trackingId)")
        guard let discountTouchpointsView = discountTouchpointsView else { return }
        discountTouchpointsView.update(with: DiscountTouchpointsGridData(numberOfItems: Int.random(in: 1...6)))
    }
}
