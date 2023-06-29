//
//  MLBusinessLoyaltyHeaderView.swift
//  MLBusinessComponents
//
//  Created by Nicolas Battelli on 16/09/2019.
//

import UIKit

@objcMembers
public final class MLBusinessLoyaltyHeaderView: UIView {
    
    private var viewData: MLBusinessLoyaltyHeaderData?
    
    private let viewHeight: CGFloat = 60
    private let fillPercentProgress: Bool
    private let titleNumberOfLines: Int = 1
    private let ringSize: CGFloat = 36
    
    //New part:
    private weak var iconView: UIImageView?
    
    private weak var ringView: UICircularProgressRing?
    private weak var titleLabel: UILabel?
    private weak var subTitleLabel: UILabel?
    
    public init(_ viewData: MLBusinessLoyaltyHeaderData? = nil, fillPercentProgress: Bool = true) {
        self.viewData = viewData
        self.fillPercentProgress = fillPercentProgress
        super.init(frame: .zero)
        render()
        update()
    }
    
    public func update(_ viewData: MLBusinessLoyaltyHeaderData?) {
        self.viewData = viewData
        update()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Privates methods
private extension MLBusinessLoyaltyHeaderView {
    
    private func update() {
        self.backgroundColor = viewData?.getBackgroundHexaColor().hexaToUIColor()
        
        self.titleLabel?.text = viewData?.getTitle()
        self.titleLabel?.textColor = viewData?.getPrimaryHexaColor()?.hexaToUIColor()
        self.titleLabel?.isHidden = false
        
        self.subTitleLabel?.text = viewData?.getSubtitle()
        self.subTitleLabel?.textColor = viewData?.getPrimaryHexaColor()?.hexaToUIColor()
        
        
        let ringNumber = viewData?.getRingNumber() ?? 1
        let ringHexaColor = viewData?.getPrimaryHexaColor() ?? "FFFFFF"
        let secondaryHexaColor = viewData?.getSecondaryHexaColor() ?? "FFFFFF"
        let ringPercentage = viewData?.getRingPercentage() ?? 0
        
        let iconSize = viewData?.getIconSize() ?? 50
        let descriptionSize = viewData?.getDescriptionSize() ?? 14
        
        self.ringView?.fontColor = ringHexaColor.hexaToUIColor()
        self.ringView?.innerRingColor = ringHexaColor.hexaToUIColor()
        self.ringView?.outerRingColor = secondaryHexaColor.hexaToUIColor()
        self.ringView?.innerCenterText = String(Float(ringNumber))
        self.ringView?.isHidden = false
        
        if self.fillPercentProgress {
            self.ringView?.startProgress(to: CGFloat(ringPercentage), duration: 0)
        }
        
        if(viewData?.getSubtitle() != nil){
            if(viewData?.getRingNumber() == nil){
                hideRing(self.ringView!)
            }
            if(viewData?.getTitle() != nil){
                hideTitle()
            }
        }
    }
    
    private func render() {
        self.prepareForAutolayout()
        
        let titleLabel = buildTitle()
        self.addSubview(titleLabel)
        
        let subTitleLabel = buildSubTitle()
        self.addSubview(subTitleLabel)
        
        let ringView = buildRing()
        self.addSubview(ringView)
        
        makeConstraints(titleLabel, subTitleLabel, ringView)
    }
    
    // MARK: Builders.
    private func buildTitle() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.prepareForAutolayout(.clear)
        titleLabel.numberOfLines = titleNumberOfLines
        titleLabel.font = UIFont.ml_semiboldSystemFont(ofSize: UI.FontSize.XS_FONT)
        self.titleLabel = titleLabel
        return titleLabel
    }
    
    private func buildSubTitle() -> UILabel {
        let subTitleLabel = UILabel()
        subTitleLabel.prepareForAutolayout(.clear)
        subTitleLabel.numberOfLines = titleNumberOfLines
        subTitleLabel.font = UIFont.ml_semiboldSystemFont(ofSize: UI.FontSize.M_FONT)
        self.subTitleLabel = subTitleLabel
        return subTitleLabel
    }
    
    private func buildRing() -> UIView {
        self.ringView?.isHidden = false
        let ring = RingFactory.create(number: Int(self.viewData?.getRingNumber() ?? 1),
                                      hexaColor: self.viewData?.getPrimaryHexaColor() ?? "FFFFFF",
                                      percent: self.viewData?.getRingPercentage() ?? 0,
                                      fillPercentage: self.fillPercentProgress)
        ring.outerRingWidth = 3
        ring.innerRingWidth = 3
        ring.font = UIFont.ml_semiboldSystemFont(ofSize: 20)
        self.ringView = ring
        return ring
    }
    
    private func hideRing( _ ring: UIView?) {
        self.ringView?.isHidden = true
        NSLayoutConstraint.activate([
            ring!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UI.Margin.XXXS_MARGIN),
            ring!.widthAnchor.constraint(equalToConstant: 0)
        ])
        self.subTitleLabel?.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2).isActive = true
        self.subTitleLabel?.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
    }
    
    private func hideTitle() {
        //Esta parte pone al subtitle en el centro!
        subTitleLabel!.topAnchor.constraint(equalTo: topAnchor, constant: UI.Margin.XXS_MARGIN).isActive = true
        subTitleLabel!.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UI.Margin.XXS_MARGIN).isActive = true
        
        //Revisar esta parte
        //Agregar documentacion explicando que onda
        //Esta parte esconde propiamente el title
        titleLabel?.isHidden = true
        titleLabel!.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0).isActive = true
        titleLabel!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UI.Margin.XS_MARGIN).isActive = true
        titleLabel!.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        titleLabel!.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        titleLabel?.heightAnchor.constraint(equalToConstant: 0)
        
    }
    
    // MARK: Constraints.
    func makeConstraints(_ titleLabel: UILabel, _ subTitleLabel: UILabel, _ ring: UIView) {
        NSLayoutConstraint.activate([
            ring.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ring.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UI.Margin.S_MARGIN),
            ring.heightAnchor.constraint(equalToConstant: ringSize),
            ring.widthAnchor.constraint(equalToConstant: ringSize),
            titleLabel.leftAnchor.constraint(equalTo: ring.rightAnchor, constant: UI.Margin.S_MARGIN),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: UI.Margin.XS_MARGIN),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UI.Margin.S_MARGIN),
            subTitleLabel.bottomAnchor.constraint(equalTo: ring.bottomAnchor, constant: 2),
            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            self.heightAnchor.constraint(equalToConstant: viewHeight)
            ])
    }
}

// MARK: Public Methods
extension MLBusinessLoyaltyHeaderView {
    @objc public final func fillPercentProgressWithAnimation(_ duration: TimeInterval = 1.0) {
        guard let ringPercentage = viewData?.getRingPercentage() else { return }
        ringView?.startProgress(to: CGFloat(ringPercentage), duration: duration)
    }
}
