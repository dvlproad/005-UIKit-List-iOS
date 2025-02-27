//
//  GuideMenuDataSource.swift
//  CJListDemo-Swift
//
//  Created by qian on 2025/2/10.
//

import UIKit
import CQDemoKit

@objc public class GuideMenuDataSource: NSObject, UITableViewDataSource {
    public var dataModels: [CQTSLocImageDataModel] = [] // 菜单数据
    
    /*
    // 初始化 TableView 的 dataSource
    init(rowCount: Int) {
        let dataModels: [CQTSLocImageDataModel] = CQTSLocImagesUtil.__getTestLocalImageDataModels(withCount: rowCount, randomOrder: false) as! [CQTSLocImageDataModel]
        
        for (index, module) in dataModels.enumerated() {
            module.name = String(format: "%02d", index)
        }
        
        self.dataModels = dataModels
    }
    
    // 初始化 TableView 的 dataSource
    init(dataModels: [CQTSLocImageDataModel]) {
        self.dataModels = dataModels
    }
    */
    
    // 注册 TableView 所需的所有 cell
    func registerAllCells(for tableView: UITableView) {
        tableView.register(GuideMenuTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // MARK: - UITableViewDataSource
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moduleModel = dataModels[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GuideMenuTableViewCell
        let image = UIImage.cqdemokit_xcassetImageNamed(moduleModel.imageName)
        cell.myImageView.image = image
        cell.mainTitleLabel.text = moduleModel.name
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
}

