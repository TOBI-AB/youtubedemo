//
//  Common.swift
//  YoutubeDemo
//
//  Created by Abdou on 06/03/2017.
//  Copyright © 2017 Abdou. All rights reserved.
//

import AppKit

struct YoutubeAPIKeys {
    static let clientID = "242373373621-o1lau8utkj8quoj0c0db60ri9a2etbf3.apps.googleusercontent.com"
    static let redirectURIScheme = "com.googleusercontent.apps.242373373621-o1lau8utkj8quoj0c0db60ri9a2etbf3"
    //":/oauth2redirect"
}

struct YoutubeAPIURLs {
    static let authorizationURL = "https://accounts.google.com/o/oauth2/v2/auth"
    static let accessTokenURL = "https://www.googleapis.com/oauth2/v4/token"
    static let scope = "https://www.googleapis.com/auth/youtube.force-ssl"
}

enum Tokens {
    case accessToken
    case refreshToken
}

func showAlertView(title: String, message: String) {
    let alert = NSAlert()
    alert.messageText = title
    alert.informativeText = message
    alert.addButton(withTitle: "Close")
    alert.runModal()
}













