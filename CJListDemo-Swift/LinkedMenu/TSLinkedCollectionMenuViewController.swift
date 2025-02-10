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
    
    private var leftDataSource: GuideMenuDataSource!
    private var rightDataSource: CQTSRipeBaseCollectionViewDataSource!
    private var menuView: CJLinkedCollectionMenuView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.cyan.withAlphaComponent(0.8)
        
        let sectionRowCounts: [NSNumber] = [6, 20, 23, 10, 15, 28]
        self.leftDataSource = GuideMenuDataSource(rowCount: sectionRowCounts.count)
        self.rightDataSource = CQTSRipeBaseCollectionViewDataSource(sectionRowCounts: sectionRowCounts, selectedIndexPaths: nil)
        
        self.menuView = CJLinkedCollectionMenuView(leftWidth: 100, rightColumnCount: 3, leftSetupBlock: { leftTableView in
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
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let selectedIndexPaths = [IndexPath(item: 2, section: 1)]
        self.menuView.updateSelectedIndexPaths(selectedIndexPaths)
    }
}
