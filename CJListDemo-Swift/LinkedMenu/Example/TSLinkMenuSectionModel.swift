//
//  TSLinkMenuSectionModel.swift
//  CJListDemo-Swift
//
//  Created by qian on 2025/2/11.
//

import Foundation
import SwiftUI
import AppIntents
import CQDemoKit

struct CQControlWidgetExample {
    static func iconExamples() -> [CJBaseImageModel] {
        let items = loadIconFromJSONFile(fileName: "CQControlWidgetColorSymbolExample")
        return items ?? []
    }
    
    static func loadIconFromJSONFile(fileName: String) -> [CJBaseImageModel]? {
        // 获取文件路径
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json") else {
            CJUIKitToastUtil.showMessage("File not found: \(fileName).json")
            return nil
        }
        
        do {
            // 读取文件内容
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            
            // 使用 JSONDecoder 序列化数据
            let decoder = JSONDecoder()
            let items = try decoder.decode([CJBaseImageModel].self, from: data)
            
            return items
        } catch {
            print("Error loading or decoding JSON: \(error)")
            return nil
        }
    }
    
    
    static func iconSectionExamples() -> [TSLinkMenuSectionModel] {
        let sections = loadIconSectionFromJSONFile(fileName: "CQControlWidgetColorSymbolSectionExample")
        return sections ?? []
    }
    
    static func loadIconSectionFromJSONFile(fileName: String) -> [TSLinkMenuSectionModel]? {
        // 获取文件路径
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json") else {
            CJUIKitToastUtil.showMessage("File not found: \(fileName).json")
            return nil
        }
        
        do {
            // 读取文件内容
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            
            // 使用 JSONDecoder 序列化数据
            let decoder = JSONDecoder()
            let items = try decoder.decode([TSLinkMenuSectionModel].self, from: data)
            
            return items
        } catch {
            print("Error loading or decoding JSON: \(error)")
            return nil
        }
    }
    
    
    static func textSectionExamples() -> [TSLinkMenuSectionModel] {
        let sections = loadIconSectionFromJSONFile(fileName: "CQControlWidgetTextSectionExample")
        return sections ?? []
    }
    
    static func loadTextSectionFromJSONFile(fileName: String) -> [TSLinkMenuSectionModel]? {
        // 获取文件路径
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json") else {
            print("File not found: \(fileName).json")
            return nil
        }
        
        do {
            // 读取文件内容
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            
            // 使用 JSONDecoder 序列化数据
            let decoder = JSONDecoder()
            let items = try decoder.decode([TSLinkMenuSectionModel].self, from: data)
            
            return items
        } catch {
            print("Error loading or decoding JSON: \(error)")
            return nil
        }
    }
}

class TSLinkMenuSectionModel: NSObject, NSCopying, NSMutableCopying, Codable {
    
    var type: Int = 0              // section的类型
    var theme: String = ""         // section的名字
    var values: [CJBaseImageModel] = [] // Assuming the array should be of a specific type, e.g., CJBaseImageModel
    
    var isSelected: Bool = false   // section是否选中
    
    override init() {
        super.init()
    }
    
    // MARK: - Initializer
    init(type: Int, theme: String, values: [CJBaseImageModel], isSelected: Bool = false) {
        self.type = type
        self.theme = theme
        self.values = values
        self.isSelected = isSelected
    }
    
    // MARK: - NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = TSLinkMenuSectionModel(type: self.type, theme: self.theme, values: self.values, isSelected: self.isSelected)
        return copy
    }
    
    // MARK: - NSMutableCopying
    func mutableCopy(with zone: NSZone? = nil) -> Any {
        let mutableCopy = TSLinkMenuSectionModel(type: self.type, theme: self.theme, values: self.values, isSelected: self.isSelected)
        return mutableCopy
    }
    
    // MARK: - Codable
    private enum CodingKeys: String, CodingKey {
        case type
        case theme
        case values
        case isSelected
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decodeIfPresent(Int.self, forKey: .type) ?? 0
        theme = try container.decode(String.self, forKey: .theme)
        values = try container.decode([CJBaseImageModel].self, forKey: .values)  // Ensure CJBaseImageModel conforms to Codable
        isSelected = try container.decodeIfPresent(Bool.self, forKey: .isSelected) ?? false
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(theme, forKey: .theme)
        try container.encode(values, forKey: .values)  // Ensure CJBaseImageModel conforms to Codable
        try container.encode(isSelected, forKey: .isSelected)
    }
}


public class CJBaseImageModel: NSObject, Codable {    // 图标库使用UIKit实现，所以这里用 class
    public var id: String               // 图片id
    public var name: String?            // 图片描述名
    public var imageName: String        // 图片地址
    public var imageColorString: String?    // 图标颜色（symbol图标经常使用）
    public var bundleRelativePath: String?  // 图片所在bundle的沙盒相对路径,为nil时候为 Bundle.main
    
    public init(id: String,
                name: String?,
                imageName: String,
                imageColorString: String? = nil,
                bundleRelativePath: String? = "DownloadBundle.bundle"
    ) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.imageColorString = imageColorString
        self.bundleRelativePath = bundleRelativePath
    }
    
    public var downloadBundle: Bundle? {
        var downloadBundle: Bundle?
        let mainBundle: Bundle = Bundle.main
        if let downloadBundlePath = mainBundle.path(forResource: "WidgetIslandSymbol", ofType: ".bundle") {
            downloadBundle = Bundle(path: downloadBundlePath)
        }
        return downloadBundle
    }
    
    static func downloadBundleRelativePath() -> String {
//        let downloadBundlePath = Bundle.main.path(forResource: "DownloadBundle", ofType: "bundle")
//        return downloadBundlePath ?? ""
        return "DownloadBundle.bundle"
    }
    
    public func createUIImage() -> UIImage? {
        let image = UIImage(named: imageName, in: downloadBundle, compatibleWith: nil)
        return image
    }
    
    @available(iOS 13.0, *)
    public func createImageView() -> Image {
        Image(imageName, bundle: downloadBundle)
    }
    
    /// 桌面控制中心选择时候显示
    @available(iOS 16.0, *)
    public func crateDisplayImageView() -> DisplayRepresentation.Image? {
        let imageUrl = downloadBundle?.url(forResource: imageName, withExtension: nil)
//        if imageUrl == nil {
//            return nil
//        }
//        let imageData2 = try? Data(contentsOf: imageUrl!)
        
        let uiimage = UIImage(named: imageName, in: downloadBundle, with: nil)
        if uiimage == nil {
            return nil
        }
        let imageData = uiimage!.pngData()
        if imageData == nil {
            return nil
        }
        
        //print("成功获取图片数据，大小：\(imageData.count) 字节")
        let image: DisplayRepresentation.Image? = DisplayRepresentation.Image(data: imageData!, isTemplate: false)
        
//        Image(imageName, bundle: downloadBundle)
        return image
    }
    
    //MARK: Codable
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageName
        case imageColorString
        case bundleRelativePath
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.imageName = try container.decode(String.self, forKey: .imageName)
        self.imageColorString = try container.decodeIfPresent(String.self, forKey: .imageColorString)
        self.bundleRelativePath = try container.decodeIfPresent(String.self, forKey: .bundleRelativePath)
    }
}

