//
//  AppDelegate.swift
//  YoutubeDemo
//
//  Created by Abdou on 06/03/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import Cocoa
import OAuthSwift

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    class var sharedInstance: AppDelegate {
        return NSApplication.shared().delegate as? AppDelegate ?? AppDelegate()
    }
}

extension AppDelegate {

    // Get Authorization Code
    func applicationHandle(url: URL) {
        let codeArray = url.absoluteString.components(separatedBy: "=")
        let code = codeArray.last ?? ""

        self.exchangeAuthorizationCodeToAccessToken(authorizationCode: code)
    }

    // Exchange Authorization Code to Access Token
    fileprivate func exchangeAuthorizationCodeToAccessToken(authorizationCode: String) {

        let redirectURi = YoutubeAPIKeys.redirectURIScheme.appending(":/oauth-callback")
        let parameters = ["code":authorizationCode,"client_id":YoutubeAPIKeys.clientID,"client_secret":"","redirect_uri":redirectURi,"grant_type":"authorization_code"] as [String: String]

        let oauthswift = OAuth2Swift(consumerKey: YoutubeAPIKeys.clientID, consumerSecret: "", authorizeUrl: "", accessTokenUrl: "", responseType: "")

        _ = oauthswift.startAuthorizedRequest(YoutubeAPIURLs.accessTokenURL, method: OAuthSwiftHTTPRequest.Method.POST, parameters: parameters, success: { (response: OAuthSwiftResponse) in

            do {
                guard let json = try response.jsonObject() as? [AnyHashable: Any] else { return }
                self.storeTokensInKeychain(tokens: json)
                print(json)




            } catch {
                print("error parsing json")
            }

        }) { (error: OAuthSwiftError) in
            showAlertView(title: error._domain, message: error.description)
        }
    }

    // Store access token in keychain
    fileprivate func storeTokensInKeychain(tokens: [AnyHashable: Any]) {

    }
}




//                let title = "Access Token"
//                let message = "Access Token: \n\(accessToken) \n\n Refresh_token: \n\(refreshToken)"
//                showAlertView(title: title, message: message)



































