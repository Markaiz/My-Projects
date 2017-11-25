//
//  WebsiteViewController.swift
//  SamuraiDoProject
//
//  Created by Mark on 23/10/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import UIKit
import WebKit

class WebsiteViewController: UIViewController,WKUIDelegate {

        var webView: WKWebView!
        
        override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            view = webView
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let myURL = URL(string: "http://samuraido.co.il")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        }
}
