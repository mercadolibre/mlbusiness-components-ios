//
//  testWEBP.swift
//  MLBusinessComponents
//
//  Created by Lautaro Bonasora on 28/11/2022.
//

import Foundation

import UIKit
import WebKit

class ViewController: UIViewController {
    
    let imageView = ImagePlaybackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imageView.loadImage(from: URL(string: "https://http2.mlstatic.com/storage/pm-media/delivery-media/webp/0/ezgif-1-3def9a773e-0184ab46-d9ca-7df3-876b-a9ac4098ad9e.webp")!)
    }
}

class ImagePlaybackView: UIView {
    
    let webview = WKWebView()
    
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
    
    func loadImage(from url: URL) {
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
        let s = html.replacingOccurrences(of: "[URL]", with: url.absoluteString)
        webview.loadHTMLString(s, baseURL: nil)
    }
}
