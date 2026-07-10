//
//  DouyinWebScraper.swift
//  CJListDemo-Swift
//
//  Created by qian on 2025/2/11.
//
/*  使用方法如下：
let scraper = DouyinWebScraper(videoURL: "https://www.douyin.com/video/7414051930047106342")
scraper.fetchVideoData { data in
    print("抖音视频数据:", data ?? "获取失败")
}
*/

import UIKit
import WebKit

@objc open class DouyinWebScraper: NSObject, WKNavigationDelegate {
    private var webView: WKWebView!
    private var videoID: String
    private var completion: (([String: Any]?) -> Void)?

    @objc public init(videoURL: String) {
        self.videoID = videoURL.components(separatedBy: "/").last ?? ""
        super.init()

        let config = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = self
    }

    @objc public func fetchVideoData(completion: @escaping ([String: Any]?) -> Void) {
        self.completion = completion
        guard let url = URL(string: "https://www.douyin.com/video/\(videoID)") else {
            completion(nil)
            return
        }

        DispatchQueue.main.async {
            self.webView.load(URLRequest(url: url))
        }
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let js = "document.documentElement.innerHTML"
        webView.evaluateJavaScript(js) { result, error in
            guard let html = result as? String, error == nil else {
                self.completion?(nil)
                return
            }

            if let jsonData = self.extractJSON(from: html) {
                self.completion?(jsonData)
            } else {
                self.completion?(nil)
            }
        }
    }

    private func extractJSON(from html: String) -> [String: Any]? {
        guard let range = html.range(of: "window.__DATA__ = ") else { return nil }
        let jsonString = html[range.upperBound...].split(separator: ";")[0]
        
        if let jsonData = jsonString.data(using: .utf8) {
            return try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        }
        return nil
    }
}
