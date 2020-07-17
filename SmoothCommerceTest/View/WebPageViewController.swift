//
//  WebPageViewController.swift
//  SmoothCommerceTest
//
//  Created by Rafael Cunha de Oliveira on 2020-07-17.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit
import WebKit
/*
   WebKit framework in order to show the web page.
*/

class WebPageViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var urlString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWebView()
        showLoading()
    }

    func setUpWebView() {
        webView.navigationDelegate = self
        guard let url = URL(string: urlString) else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}

extension WebPageViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideLoading()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideLoading()
        let failError = CustomError(description: error.localizedDescription, code: 404)
        showError(failError)
    }
}

