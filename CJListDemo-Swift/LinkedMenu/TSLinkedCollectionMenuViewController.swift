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

@objc public class TSLinkedCollectionMenuViewController: UIViewController {
    // cell 的高度
    private var rightColumnCount: Int
    private var rightCellWidthHeightRatio: CGFloat
    @objc public init(rightColumnCount: Int, rightCellWidthHeightRatio: CGFloat) {
        self.rightColumnCount = rightColumnCount
        self.rightCellWidthHeightRatio = rightCellWidthHeightRatio
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private var leftDataSource: GuideMenuDataSource!
    private var rightDataSource: CQTSRipeBaseCollectionViewDataSource!
    private var menuView: CJLinkedCollectionMenuView!
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.cyan.withAlphaComponent(0.8)
        
        
        self.rightDataSource = CQTSRipeBaseCollectionViewDataSource(sectionDataModels: [])
        self.leftDataSource = GuideMenuDataSource()
        
        self.menuView = CJLinkedCollectionMenuView(leftWidth: 100, rightColumnCount: self.rightColumnCount, leftCellHeight: 44.0, rightCellWidthHeightRatio: self.rightCellWidthHeightRatio, leftSetupBlock: { leftTableView in
            self.leftDataSource.registerAllCells(for: leftTableView)
        }, leftDataSource: self.leftDataSource, rightSetupBlock: { rightCollectionView in
            self.rightDataSource.registerAllCells(for: rightCollectionView)
        }, rightDataSource: self.rightDataSource, onTapRightIndexPath: { indexPath in
            if let dataModel = self.rightDataSource.dataModel(at: indexPath) as? CQTSLocImageDataModel {
                let message = "点击了:\(dataModel.name)"
                CJUIKitToastUtil.showMessage(message)
            }
        })
        
        
        self.menuView.backgroundColor = .red
        self.view.addSubview(self.menuView)
        self.menuView.snp.makeConstraints { make in
            make.left.equalTo(self.view).offset(10)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        
        // 请求数据
        let sectionRowCounts: [NSNumber] = [6, 20, 23, 10, 15, 28]
        let selectedIndexPaths = [IndexPath(item: 10, section: 2)]
        self.requestData(sectionRowCounts: sectionRowCounts, selectedIndexPaths: selectedIndexPaths)
    }
    
    private func requestData(sectionRowCounts: [NSNumber], selectedIndexPaths: [IndexPath]?) {
        var sectionDataModels: [CQDMSectionDataModel] = []
        for section in 0..<sectionRowCounts.count {
            let nRowCount = sectionRowCounts[section]
            let iRowCount = nRowCount.intValue
            
            let sectionDataModel = CQDMSectionDataModel()
            sectionDataModel.theme = "section \(section)"
            sectionDataModel.values = CQTSLocImagesUtil.__getTestLocalImageDataModels(withCount: iRowCount, randomOrder: false)
            
            for item in 0..<iRowCount {
                var module: CQTSLocImageDataModel = sectionDataModel.values[item] as! CQTSLocImageDataModel
                module.name = "\(section)-\(String(format: "%02d", item))"
                
                let isSelected = selectedIndexPaths?.contains(IndexPath(item: item, section: section)) ?? false
                module.selected = isSelected
            }
            
            sectionDataModels.append(sectionDataModel)
        }
        
        // 2秒后执行
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setupDataSource(sectionDataModels: sectionDataModels)
        }
    }
    
    private func setupDataSource(sectionDataModels: [CQDMSectionDataModel]) {
        var menuDataModels: [CQTSLocImageDataModel] = []
        var selectedIndexPaths: [IndexPath] = []
        
        let sectionCount = sectionDataModels.count
        for section in 0..<sectionCount {
            let sectionDataModel: CQDMSectionDataModel = sectionDataModels[section]
            let menuDataModel = CQTSLocImageDataModel()
            menuDataModel.name = sectionDataModel.theme
            menuDataModels.append(menuDataModel)
            
            
            let valueCount = sectionDataModel.values.count
            for item in 0..<valueCount {
                var module: CQTSLocImageDataModel = sectionDataModel.values[item] as! CQTSLocImageDataModel
                if module.selected {
                    selectedIndexPaths.append(IndexPath(item: item, section: section))
                }
            }
        }
        self.rightDataSource.sectionDataModels = sectionDataModels
        self.leftDataSource.dataModels = menuDataModels
        self.menuView.reloadData()
        self.menuView.updateSelectedIndexPaths(selectedIndexPaths, animated: true, scrollPosition: .centeredVertically)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
