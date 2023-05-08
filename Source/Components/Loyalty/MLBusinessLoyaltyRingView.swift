//
//  MLBusinessLoyaltyRingView.swift
//  MLBusinessComponents
//
//  Created by Juan sebastian Sanzone on 8/28/19.
//  Copyright © 2019 Juan Sanzone. All rights reserved.
//

import UIKit
import MLUI

@objcMembers
open class MLBusinessLoyaltyRingView: UIView {
    let viewData: MLBusinessLoyaltyRingData

    private let verticalMargin: CGFloat = 4
    private let ringSize: CGFloat = 46
    private let buttonHeight: CGFloat = 20
    private let titleNumberOfLines: Int = 2
    private let subtitleNumberOfLines: Int = 0
    private let fillPercentProgress: Bool
    private weak var ringView: UICircularProgressRing?
    private var tapAction: ((_ deepLink: String) -> Void)?
    private let imageSize: CGFloat = 46

    public init(_ ringViewData: MLBusinessLoyaltyRingData, fillPercentProgress: Bool = true) {
        self.viewData = ringViewData
        self.fillPercentProgress = fillPercentProgress
        super.init(frame: .zero)
        render()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Privates.
extension MLBusinessLoyaltyRingView {
    private func render() {
        self.prepareForAutolayout()

        let titleLabel = buildTitle()
        self.addSubview(titleLabel)
        
        let subtitleLabel = buildSubtitle()
        self.addSubview(subtitleLabel)

        let button = buildButton()
        self.addSubview(button)

        let ring = RingFactory.create(
            number: viewData.getRingNumber?() ?? 0,
            hexaColor: viewData.getRingHexaColor?() ?? "",
            percent: viewData.getRingPercentage?() ?? 0,
            fillPercentage: fillPercentProgress,
            innerCenterText: viewData.getRingNumber?() != nil ? String(viewData.getRingNumber!()) : "")
        
        self.addSubview(ring)
        self.ringView = ring
        
        let imageUrl = buildImageUrl()
        self.addSubview(imageUrl)
        
        makeConstraints(titleLabel, subtitleLabel, button, ring, imageUrl)
    }
    
    private func buildImageUrl() -> UIImageView {
        let icon = UIImageView()
        icon.layer.cornerRadius =  imageSize / 2
        icon.layer.masksToBounds = true
        icon.setRemoteImage(imageUrl: viewData.getImageUrl?() ?? "")
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        icon.prepareForAutolayout(.clear)
        return icon
    }
    
    // MARK: Builders.
    private func buildTitle() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.prepareForAutolayout(.clear)
        titleLabel.numberOfLines = titleNumberOfLines
//        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
//        titleLabel.attributedText = viewData.getTitle().convertHtmlToAttributedStringWithCSS(font: UIFont.ml_regularSystemFont(ofSize: UI.FontSize.S_FONT), csscolor: "white", lineheight: 5, csstextalign: "center")
//        titleLabel.attributedText = viewData.getTitle().UIFont.ml_regularSystemFont(ofSize: UI.FontSize.S_FONT)
//        titleLabel.font = UIFont.ml_regularSystemFont(ofSize: UI.FontSize.S_FONT)
//        titleLabel.font = MLStyleSheetManager.styleSheet.regularSystemFont(ofSize: CGFloat(12.0))
        titleLabel.font = MLStyleSheetManager.styleSheet.regularSystemFont(ofSize: CGFloat(12.0))
//        titleLabel.attributedText = viewData.getTitle().htmlToAttributedString(withFont: titleLabel.font)
        titleLabel.attributedText = MLBusinessLoyaltyRingView.htmlToAttributedString(htmlString: viewData.getTitle().string, font: UIFont.ml_semiboldSystemFont(ofSize: UI.FontSize.S_FONT), color: UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.45), alignment: .center)
        
//        let attributedText = NSMutableAttributedString(string: titleLabel.text!)
//        attributedText.addAttributes([
//            NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
//            //            NSAttributedString.Key.foregroundColor: UIColor(hexString: UIColor.blue),
//        ], range: NSRange(location: 0, length: 5))
//        titleLabel.attributedText = attributedText
//        titleLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.45)
//        titleLabel.setLineHeight(12)
        //        titleLabel.text = viewData.getTitle()
//                titleLabel.attributedText = viewData.getTitle().htmlAttributedString()
        NSLog("Fuente nombre: \(String(describing: titleLabel.font))");
        titleLabel.applyBusinessLabelStyle()
        return titleLabel
    }
    
    private func buildSubtitle() -> UILabel {
        let subtitleLabel = UILabel()
        subtitleLabel.prepareForAutolayout(.clear)
        subtitleLabel.numberOfLines = subtitleNumberOfLines
        subtitleLabel.text = viewData.getSubtitle?() ?? nil
        subtitleLabel.font = UIFont.ml_regularSystemFont(ofSize: UI.FontSize.XS_FONT)
//        subtitleLabel.font = UIFont.systemFont(ofSize: UI.FontSize.XS_FONT)
//        printf("Fuente nomre: \(String(describing: subtitleLabel.font))");
        NSLog("Fuente nombre: \(String(describing: subtitleLabel.font))");
        subtitleLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.45)
        return subtitleLabel
    }

    private func buildButton() -> UIButton {
        let button = UIButton()
        button.prepareForAutolayout(.clear)
        button.setTitle(viewData.getButtonTitle(), for: .normal)
        button.titleLabel?.font = UIFont.ml_semiboldSystemFont(ofSize: UI.FontSize.XS_FONT)
        button.setTitleColor(MLStyleSheetManager.styleSheet.secondaryColor, for: .normal)
        button.addTarget(self, action:  #selector(self.didTapOnButton), for: .touchUpInside)
        button.isHidden = viewData.getButtonTitle() == "" || viewData.getButtonDeepLink() == ""
        return button
    }

    // MARK: Constraints.
    func makeConstraints(_ titleLabel: UILabel, _ subtitleLabel: UILabel, _ button: UIButton, _ ring: UICircularProgressRing, _ img : UIImageView) {
        NSLayoutConstraint.activate([
            ring.topAnchor.constraint(equalTo: topAnchor, constant: verticalMargin),
            ring.leadingAnchor.constraint(equalTo: leadingAnchor),
            ring.widthAnchor.constraint(equalToConstant: ringSize),
            ring.heightAnchor.constraint(equalToConstant: ringSize),
            img.topAnchor.constraint(equalTo: topAnchor, constant: verticalMargin),
            img.leadingAnchor.constraint(equalTo: leadingAnchor),
            img.widthAnchor.constraint(equalToConstant: imageSize),
            img.heightAnchor.constraint(equalToConstant: imageSize),
            titleLabel.topAnchor.constraint(equalTo: ring.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: ring.trailingAnchor, constant: UI.Margin.M_MARGIN),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UI.Margin.XXXS_MARGIN),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            button.heightAnchor.constraint(equalToConstant: buttonHeight),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalMargin)
        ])
    }

    // MARK: Tap Selector.
    @objc private func didTapOnButton() {
        tapAction?(viewData.getButtonDeepLink())
    }
    
    
    
    
    static func htmlToAttributedString(htmlString: String, font: UIFont, color: UIColor, alignment: NSTextAlignment = .center) -> NSAttributedString {

            let modifiedFont = String(format: "<span style=\"font-family: '\(font.fontName)'; font-size: \(font.pointSize)\">%@</span>", htmlString)

            guard let data = modifiedFont.data(using: .unicode, allowLossyConversion: true) else {
                return NSAttributedString(string: htmlString)
            }

            do {

                let paragraphStyle = NSMutableParagraphStyle()

                paragraphStyle.alignment = alignment

                let attrStr = try NSMutableAttributedString(
                    data: data,
                    options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                    documentAttributes: nil
                )

                let allRange = NSRange(location: 0, length: attrStr.length)
                attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: allRange)
                attrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: allRange)

                return attrStr
            } catch {
                return NSAttributedString(string: htmlString)
            }
        }

}

// MARK: Public Methods.
extension MLBusinessLoyaltyRingView {
    @objc open func addTapAction(_ action: @escaping ((_ deepLink: String) -> Void)) {
        self.tapAction = action
    }

    @objc open func fillPercentProgressWithAnimation(_ duration: TimeInterval = 1.0) {
        ringView?.startProgress(to: CGFloat(viewData.getRingPercentage?() ?? 0), duration: duration)
    }
}

//extension String {
//    func htmlAttributedString() -> NSAttributedString? {
//        let htmlTemplate = """
//        <!doctype html>
//        <html>
//           <head>
//              <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
//              <style>
//                 body {
//                font-family: .SFUI-Regular;
//                 }
//              </style>
//           </head>
//           <body>
//              \(self)
//           </body>
//        </html>
//        """
//
//        guard let data = htmlTemplate.data(using: .utf8) else {
//            return nil
//        }
//
//        guard let attributedString = try? NSAttributedString(
//            data: data,
//            options: [.documentType: NSAttributedString.DocumentType.html],
//            documentAttributes: nil
//        ) else {
//            return nil
//        }
//
//        return attributedString
//    }
//
////        let htmlProfileString = "<html><head><style>body {font-family:\"-apple-system\";font-size: 16px;color: #FFFFFF;text-decoration:none;}</style></head><body>" +
////
////
////
////                                        """
////                                        ñandú
////                                        <b> Negrita </b>
////                                        <strike> Tachado </strike>
////                                        <strike><strong> Negrita y Tachado </strong></strike>
////                                        <mark style="background: #27a750 !important; color: #FFF">&nbspFondo verde y letras blancas </mark>
////                                        <font size="6">&nbspGrande </font>
////                                        <font size="2">Pequeño </font>
////                                        <span style="font-size: 22px; color:red; font-weight: bold; font-style: italic;"> italic cursiva roja 22px</span>
////                                        """
////
////
////
////
////                                + "</body></head></html>"
////
////                            let htmlData = NSString(string: htmlProfileString).data(using: String.Encoding.unicode.rawValue)
////
////                            let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
////
////                            let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
////        return attributedString
////    }
//}



//extension String {
//    private var convertHtmlToNSAttributedString: NSAttributedString? {
//        guard let data = data(using: .utf8) else {
//            return nil
//        }
//        do {
//            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
//        }
//        catch {
//            print(error.localizedDescription)
//            return nil
//        }
//    }
//
//    public func convertHtmlToAttributedStringWithCSS(font: UIFont?, csscolor: String, lineheight: Int, csstextalign: String) -> NSAttributedString? {
//        guard let font = font else {
//            return convertHtmlToNSAttributedString
//        }
////        let modifiedString = "<style>body{}</style>\(self)"
//        let modifiedString = "<style>body{font-family: '\(font.fontName)'; font-size:\(font.pointSize)px; color: \(csscolor); line-height: \(lineheight)px; text-align: \(csstextalign); }</style>\(self)"
//        guard let data = modifiedString.data(using: .utf8) else {
//            return nil
//        }
//        do {
//            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
//        }
//        catch {
//            print(error)
//            return nil
//        }
//    }
//}

//extension NSAttributedString {
//    func htmlToAttributedString(withFont font: UIFont) -> NSAttributedString? {
//        let modifiedText = String(format: "<span style=\"font-family: '\(font.fontName)'; font-size: \(font.pointSize)\">%@</span>", self)
//
//        guard let data = modifiedText.data(using: .utf8) else { return nil }
//        do {
//            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
//        } catch {
//            return nil
//        }
//    }
//}


