//
//  WebViewController.swift
//  YoutubeDemo
//
//  Created by Abdou on 06/03/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import AppKit
import WebKit
import OAuthSwift

typealias WebView = WKWebView

class WebViewContoller: OAuthWebViewController {

    let webView = WebView()
    var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.webView.frame = self.view.frame
        self.webView.navigationDelegate = self
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)

    }

    override func handle(_ url: URL) {
        self.url = url
        super.handle(url)
        self.loadAddressURL()

    }

    fileprivate func loadAddressURL() {
        guard let url = self.url else {
            print("Invalid URL", #function, #line)
            return
        }

        let request = URLRequest(url: url)
        self.webView.load(request)
    }
}

// MARK: - WKNavigationDelegate
extension WebViewContoller: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Navigation fail: \(error.localizedDescription)")
        self.dismissWebViewController()
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        // here we handle internally the callback url and call method that call handleOpenURL (not app scheme used)
        if let url = navigationAction.request.url, url.scheme == YoutubeAPIKeys.redirectURIScheme {

            AppDelegate.sharedInstance.applicationHandle(url: url)

            decisionHandler(.cancel)

            self.dismissWebViewController()
            return
        }
        decisionHandler(.allow)
    }
}































