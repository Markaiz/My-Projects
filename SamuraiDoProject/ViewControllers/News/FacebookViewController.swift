//
//  FacebookViewController.swift
//  SamuraiDoProject
//
//  Created by Mark on 23/10/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import UIKit

import WebKit

class FacebookViewController: UIViewController,WKUIDelegate {
    
    
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "https://www.facebook.com/samuraidojudo")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
