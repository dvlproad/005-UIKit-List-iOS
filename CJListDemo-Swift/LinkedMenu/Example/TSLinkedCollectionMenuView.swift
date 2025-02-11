//
//  TSLinkedCollectionMenuViewController.swift
//  CJListDemo-Swift
//
//  Created by qian on 2025/1/17.
//

import UIKit
import SnapKit
import CJListKit_Swift
import CQDemoKit

@objc public class TSLinkedCollectionMenuView: UIView {
    // cell 的高度
    private var rightColumnCount: Int
    private var layoutModel: CJLinkedMenuLayoutModel
    public var isUseForText: Bool   // true: 文案库选择   false: 图标库选择
    public var isForCloseState: Bool
    private var onTapRightIndexPath: ((IndexPath, _ newImageModel: CJBaseImageModel) -> Void)
    @objc public init(
        rightColumnCount: Int,
        layoutModel: CJLinkedMenuLayoutModel,
        isUseForText: Bool,
        isForCloseState: Bool,
        onTapRightIndexPath: @escaping (IndexPath, _ newImageModel: CJBaseImageModel) -> Void
    ) {
        self.rightColumnCount = rightColumnCount
        self.layoutModel = layoutModel
        self.isUseForText = isUseForText
        self.isForCloseState = isForCloseState
        self.onTapRightIndexPath = onTapRightIndexPath
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private var leftDataSource: LeftMenuDataSource!
    private var rightDataSource: RightMenuDataSource!
    private var menuView: CJLinkedCollectionMenuView!
    private func setupViews() {
        self.backgroundColor = UIColor.white.withAlphaComponent(1.0)
        
        
        self.rightDataSource = RightMenuDataSource(sectionDataModels: [], enableTintColor: !isForCloseState)
        self.leftDataSource = LeftMenuDataSource()
        
        self.menuView = CJLinkedCollectionMenuView(leftWidth: 87, rightColumnCount: self.rightColumnCount, leftCellHeight: 52.0, layoutModel: self.layoutModel, leftSetupBlock: { leftTableView in
            self.leftDataSource.registerAllCells(for: leftTableView)
        }, leftDataSource: self.leftDataSource, rightSetupBlock: { rightCollectionView in
            self.rightDataSource.registerAllCells(for: rightCollectionView)
        }, rightDataSource: self.rightDataSource, onTapRightIndexPath: { indexPath in
            let dataModel = self.rightDataSource.dataModel(at: indexPath)
            if self.isUseForText {
                let message = "点击了:\(dataModel.name ?? "未知文案")"
                CJUIKitToastUtil.showMessage(message)
            } else {
                let message = "点击了:\(dataModel.imageName)"
                CJUIKitToastUtil.showMessage(message)
            }
            self.onTapRightIndexPath(indexPath, dataModel)
        })
        self.addSubview(self.menuView)
        self.menuView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(0)
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-0)
        }
        
        // 请求数据
        let sectionRowCounts: [NSNumber] = [6, 20, 23, 10, 15, 28]
        let selectedIndexPaths = [IndexPath(item: 10, section: 2)]
        self.requestData(sectionRowCounts: sectionRowCounts, selectedIndexPaths: selectedIndexPaths)
    }
    
    private func requestData(sectionRowCounts: [NSNumber], selectedIndexPaths: [IndexPath]?) {
        let sectionDataModels: [TSLinkMenuSectionModel] = isUseForText ? CQControlWidgetExample.textSectionExamples() : CQControlWidgetExample.iconSectionExamples()
        
        // 2秒后执行
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setupDataSource(sectionDataModels: sectionDataModels)
        }
    }
    
    private func setupDataSource(sectionDataModels: [TSLinkMenuSectionModel]) {
        var menuDataModels: [CJBaseImageModel] = []
        var selectedIndexPaths: [IndexPath] = []
        
        let sectionCount = sectionDataModels.count
        for section in 0..<sectionCount {
            let sectionDataModel: TSLinkMenuSectionModel = sectionDataModels[section]
            var menuDataModel: CJBaseImageModel = sectionDataModel.values.first!
            menuDataModel.name = sectionDataModel.theme
            menuDataModels.append(menuDataModel)
            
            
            let valueCount = sectionDataModel.values.count
            for item in 0..<valueCount {
                var module: CJBaseImageModel = sectionDataModel.values[item] 
                if module.imageName == "icon_control_katong_1" {
                    selectedIndexPaths.append(IndexPath(item: item, section: section))
                }
            }
        }
        self.rightDataSource.sectionDataModels = sectionDataModels
        self.leftDataSource.dataModels = menuDataModels
        self.menuView.reloadData()
        self.menuView.updateSelectedIndexPaths(selectedIndexPaths, animated: true, scrollPosition: .centeredVertically)
    }
}
