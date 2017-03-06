//
//  ViewController.swift
//  YoutubeDemo
//
//  Created by Abdou on 06/03/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import Cocoa
import OAuthSwift

class ViewController: NSViewController {

    lazy var internalWebViewController: WebViewContoller = {
        let controller = WebViewContoller()
        controller.view = NSView(frame: NSRect(origin: CGPoint.zero, size: CGSize(width: 500, height: 550)))
        controller.viewDidLoad()
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.doOAuthYoutube()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

// MARK: - Youtube Authorization
extension ViewController {

    fileprivate func doOAuthYoutube() {

        let oauthswift = OAuth2Swift(consumerKey: YoutubeAPIKeys.clientID, consumerSecret: "", authorizeUrl: YoutubeAPIURLs.authorizationURL, responseType: "code")

        oauthswift.authorizeURLHandler = self.getURLHundler()

        let _ = oauthswift.authorize(withCallbackURL: YoutubeAPIKeys.redirectURIScheme.appending(":/oauth-callback"), scope: YoutubeAPIURLs.scope, state: "", success: { (credential: OAuthSwiftCredential, response: OAuthSwiftResponse?, _) in

        }) { (error: OAuthSwiftError) in
            showAlertView(title: error._domain, message: error.localizedDescription)
        }
    }
}


// MARK: - Helpers
extension ViewController {
    fileprivate func getURLHundler() -> OAuthSwiftURLHandlerType {
        if self.internalWebViewController.parent == nil {
            self.addChildViewController(self.internalWebViewController)
        }
        internalWebViewController.title = "Authorization"
        return internalWebViewController
    }
}






































































































































