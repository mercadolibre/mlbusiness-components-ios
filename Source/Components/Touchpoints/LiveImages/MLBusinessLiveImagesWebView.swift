//
//  MLBusinessLiveImagesWebView.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 14/12/2022.
//

import Foundation
import UIKit
import WebKit


protocol MLBusinessLiveImagesWebViewDelegate {
    func didFinishLoadingWebView()
}

class MLBusinessLiveImagesWebView: UIView {
    
    private lazy var webview: WKWebView = {
        let view = WKWebView()
        view.navigationDelegate = self
        return view
    }()
    
    var delegate: MLBusinessLiveImagesWebViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        isUserInteractionEnabled = false
        
        webview.translatesAutoresizingMaskIntoConstraints = false
        webview.backgroundColor = .white
        webview.scrollView.showsVerticalScrollIndicator = false
        webview.scrollView.showsHorizontalScrollIndicator = false
        addSubview(webview)
        NSLayoutConstraint.activate([
            webview.leftAnchor.constraint(equalTo: leftAnchor),
            webview.rightAnchor.constraint(equalTo: rightAnchor),
            webview.topAnchor.constraint(equalTo: topAnchor),
            webview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
       
    }
    
    func loadImage(from url: String) {
        let html = """
        <html>
        <style>
            * {
                margin: 0;
            }

            html {
                margin: 0;
            }

            body {
                margin: 0;
            }

            .bg {
            position: fixed;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            }

            .bg img {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            margin: auto;
            min-width: 50%;
            min-height: 50%;
            }
        </style>

        <div class="bg">
            <img src="[URL]" alt="">
          </div>
        </html>
        """

            let s = html.replacingOccurrences(of: "[URL]", with: url)
            webview.loadHTMLString(s, baseURL: nil)
    }
}

extension MLBusinessLiveImagesWebView: WKNavigationDelegate {
        
}
