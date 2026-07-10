//
//  DouyinAPIClient.swift
//  CJListDemo-Swift
//
//  Created by qian on 2025/2/11.
//
/*  使用方法如下：
let apiClient = DouyinAPIClient()
let cookie = "your_cookie_here"
apiClient.fetchVideoData(videoID: "7414051930047106342", cookie: cookie) { data in
 print("API 返回数据:", data ?? "请求失败")
}
*/

import Foundation
import JavaScriptCore

@objc open class DouyinAPIClient: NSObject {
    private var jsContext: JSContext?
    private let userAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/537.36 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/537.36"
    
    public override init() {
        super.init()
        loadJavaScript()
    }
    
    private func loadJavaScript() {
        guard let jsPath = Bundle.main.path(forResource: "dy", ofType: "js"),
              let jsSource = try? String(contentsOfFile: jsPath) else {
            print("JavaScript 文件加载失败")
            return
        }
        jsContext = JSContext()
        jsContext?.evaluateScript(jsSource)
    }
    
    func getABogus(params: String) -> String? {
        return jsContext?.objectForKeyedSubscript("get_a_bogus")?.call(withArguments: [params, userAgent]).toString()
    }
    
    @objc public func fetchVideoData(videoID: String, cookie: String, completion: @escaping (String?) -> Void) {
        let url = "https://www.douyin.com/aweme/v1/web/aweme/detail/"
        
        var params = [
            "device_platform": "webapp",
            "aid": "6383",
            "aweme_id": videoID,
            "version_code": "190500",
            "browser_name": "Safari",
            "os_name": "iOS"
        ]
        
        let queryString = params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        guard let aBogus = getABogus(params: queryString) else {
            completion(nil)
            return
        }
        
        params["a_bogus"] = aBogus
        let requestURL = url + "?" + params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")

        var request = URLRequest(url: URL(string: requestURL)!)
        request.httpMethod = "GET"
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        request.setValue(cookie, forHTTPHeaderField: "Cookie")

        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data, let responseString = String(data: data, encoding: .utf8) else {
                completion(nil)
                return
            }
            completion(responseString)
        }
        task.resume()
    }
}
