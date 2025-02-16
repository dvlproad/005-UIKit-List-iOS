//
//  TSPreviewModel.swift
//  CJListDemo-Swift
//
//  Created by qian on 2025/1/9.
//

import Foundation
/*
 {
       "componentCategory": null,
       "componentId": 2,
       "componentName": "2222",
       "configFile": "https://resource.widgetisland.cn/dev/component/config/2025-02-11/87f73a62-3d10-41c0-beac-f9b07344c09b.zip",
       "imageList": [
         "https://resource.widgetisland.cn/dev/image/2025-02-11/a40c0957-5b03-4810-8609-ceeca427f5c7.webp",
         "https://resource.widgetisland.cn/dev/image/2025-02-11/886b1595-99ee-4336-bc52-c529e1eaff52.png",
         "https://resource.widgetisland.cn/dev/image/2025-02-11/72785103-899f-41ed-8182-c8786bba7d19.png",
         "https://resource.widgetisland.cn/dev/image/2025-02-11/979ff4fa-2ce5-41ca-8859-e78098e42586.png"
       ],
       "type": 1
     },
 */

public enum ControlWidgetPreviewType: Int, Codable {
    case component = 0  // 0组件
    case set = 1        // 1套图
}


public enum ControlWidgetStyle: String, Sendable, CaseIterable, Codable {
    case circle     // 圆形
    case rectangle  // 长方形
    case square     // 正方形
    
    //MARK: Codable
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        // 获取字符串值
        let rawValue = try container.decode(String.self)
        
        // 如果枚举值存在，则正常初始化
        if let validValue = ControlWidgetStyle(rawValue: rawValue) {
            self = validValue
        } else {
            // 如果是无效的值（例如 "normal"），则默认使用 .toogle
            self = .circle
        }
    }
}

@objcMembers
public class TSPreviewModel: NSObject, Codable {
    var componentCategory: String?
    var id: String
    public var name: String
    var configFile: String?
    var entitys: [String]
    var type: ControlWidgetPreviewType   //数据分类 0组件; 1套图
    var style: ControlWidgetStyle   // 类型
    
    // MARK: Codable
    enum CodingKeys: String, CodingKey {
        case componentCategory = "componentCategory"
        case id = "componentId"
        case name = "componentName"
        case configFile = "configFile"
        case entitys = "imageList"
        case type = "type"
        case style
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        componentCategory = try container.decodeIfPresent(String.self, forKey: .componentCategory)
        let idIValue = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        id = String(idIValue)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        configFile = try container.decodeIfPresent(String.self, forKey: .configFile)
        entitys = try container.decodeIfPresent([String].self, forKey: .entitys) ?? []
        let typeIValue = try container.decodeIfPresent(Int.self, forKey: .type) ?? 0
        type = ControlWidgetPreviewType(rawValue: typeIValue) ?? ControlWidgetPreviewType.component
        style = try container.decodeIfPresent(ControlWidgetStyle.self, forKey: .style) ?? .circle
    }
}


struct LoadJSONUtil {
    static func loadJSON<T: Decodable>(from fileName: String) -> T? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("找不到文件: \(fileName).json")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("解析 JSON 失败: \(error)")
            return nil
        }
    }
    
    static func loadJSONs<T: Decodable>(from fileName: String) -> [T]? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("找不到文件: \(fileName).json")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([T].self, from: data)
        } catch {
            print("解析 JSONs 失败: \(error)")
            return nil
        }
    }
}
