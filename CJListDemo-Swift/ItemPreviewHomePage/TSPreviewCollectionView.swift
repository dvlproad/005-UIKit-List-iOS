//
//  TSPreviewCollectionView.swift
//  CJListDemo-Swift
//
//  Created by qian on 2025/1/14.
//
//  自定义的 FlowLayout (如不同cell宽度时候左对齐)

import UIKit
import CJListKit_Swift
import CQDemoKit

@objc public class TSPreviewCollectionView: UICollectionView {
    var dataModels: [TSPreviewModel] = []
//    var onTapIndexPath: ((IndexPath) -> Void)
    var onTapEntity: ((TSPreviewModel) -> Void)
    
    // 初始化方法
    @objc public init(frame: CGRect,
                      isUseLeftAlignedFlowLayout: Bool,
                      onTapEntity: @escaping (TSPreviewModel) -> Void)
    {
        self.onTapEntity = onTapEntity
        
        let layout = isUseLeftAlignedFlowLayout ? CJLeftAlignedFlowLayout() : UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: frame, collectionViewLayout: layout)
        
        commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        // 注册 Cell 类型
        register(TSPreviewNormalCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(TSPreviewNormalCollectionViewCell.self))
        register(TSPreviewGroupCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(TSPreviewGroupCollectionViewCell.self))
        
        backgroundColor = .clear
        // 设置数据源和代理
        dataSource = self
        delegate = self
    }
    
    public func setDataModels(_ dataModels: [TSPreviewModel]) {
        self.dataModels = dataModels
        reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension TSPreviewCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dataModel = dataModels[indexPath.row]
        onTapEntity(dataModel)
    }
}

// MARK: - UICollectionViewDataSource
extension TSPreviewCollectionView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModels.count // 假设有 20 个数据项
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dataModel = dataModels[indexPath.row]
        if dataModel.type == .single {
            let cell = dequeueReusableCell(withReuseIdentifier: NSStringFromClass(TSPreviewNormalCollectionViewCell.self), for: indexPath) as! TSPreviewNormalCollectionViewCell
            //cell.backgroundColor = .red
            cell.setPreviewModel(dataModel)
            return cell
        }
        
        let cell = dequeueReusableCell(withReuseIdentifier: NSStringFromClass(TSPreviewGroupCollectionViewCell.self), for: indexPath) as! TSPreviewGroupCollectionViewCell
        //cell.backgroundColor = .red
        cell.setPreviewModel(dataModel)
        cell.configure(
            tapSelfHandler: { [weak self] in
                CJUIKitToastUtil.showMessage("点击了 groupCollectionView 上非 cell 的区域")
                self?.onTapEntity(dataModel)
            }, tapGroupItemHandler: { [weak self] groupItemModel in
                CJUIKitToastUtil.showMessage("点击了 groupCollectionView 上 cell 的区域")
                self?.onTapEntity(dataModel)
            }
        )
        
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension TSPreviewCollectionView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 18, left: 12, bottom: 22, right: 12)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
        let columnSpacing = self.collectionView(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: indexPath.section)
        let collectionWidth = collectionView.frame.size.width //UIScreen.main.bounds.width
        let itemsWithSpacingWidth = collectionWidth - sectionInset.left - sectionInset.right
        
        let previewModel = dataModels[indexPath.row]

        var columnCount: Int
        var topWidthHeightRatio: CGFloat // 除文字和间距外的顶部视图的宽高比
        var imageDistanceAndImageHeight: CGFloat
        if previewModel.type == .group {
            columnCount = 1
            let groupcolumnCount = 4
            let groupRowCount = (previewModel.entitys.count-1) / 4 + 1
            let groupSectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
            
            let groupcolumnSpacing = 16.0
            let groupCollectionWidth = itemsWithSpacingWidth
            let groupitemsWithSpacingWidth = groupCollectionWidth - groupSectionInset.left - groupSectionInset.right
            let groupitemsWidth = groupitemsWithSpacingWidth - groupcolumnSpacing * CGFloat(groupcolumnCount - 1)
            let groupitemWidth = floor(groupitemsWidth / CGFloat(groupcolumnCount))
            let groupitemHeight = groupitemWidth
            let groupCollectionHeight = groupSectionInset.top + groupSectionInset.bottom + CGFloat(groupRowCount) * groupitemHeight + CGFloat(groupRowCount-1) * groupcolumnSpacing
            topWidthHeightRatio = groupCollectionWidth/groupCollectionHeight
            
//            let groupItemWidth = 70.0
//            topWidthHeightRatio = 351/(2*12.5+CGFloat(groupRowCount) * 70.0 + CGFloat(groupRowCount-1) * 16)
            
            imageDistanceAndImageHeight = 7.5+12
            
        } else { //if setEntitys.count == 1
            let widgetStyle = previewModel.style
            switch widgetStyle {
            case .circle:
                columnCount = 4
                topWidthHeightRatio = 72.5/72.5
                imageDistanceAndImageHeight = 10+12
            case .rectangle:
                columnCount = 2
                topWidthHeightRatio = 165/75.0
                imageDistanceAndImageHeight = 8+12
            case .square:
                columnCount = 1
                topWidthHeightRatio = 351/95.0
                imageDistanceAndImageHeight = 7.5+12
            }
        }

        
        
        let itemsWidth = itemsWithSpacingWidth - columnSpacing * CGFloat(columnCount - 1)
        let itemWidth = floor(itemsWidth / CGFloat(columnCount))
        let itemTopHeight = floor(itemWidth / topWidthHeightRatio)
        let itemHeight = itemTopHeight + imageDistanceAndImageHeight
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
