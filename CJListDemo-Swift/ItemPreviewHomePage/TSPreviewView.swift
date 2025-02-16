//
//  TSPreviewView.swift
//  CJListDemo-Swift
//
//  Created by qian on 2025/1/14.
//

import UIKit
import SDWebImageWebPCoder

@objc public class TSPreviewView: UIView {
    var collectionView: TSPreviewCollectionView!
    
    var dataModels: [TSPreviewModel] = []
    var onTapEntity: ((TSPreviewModel) -> Void)
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    var isUseLeftAlignedFlowLayout: Bool
    @objc public init(
        isUseLeftAlignedFlowLayout: Bool,
        onTapEntity: @escaping (TSPreviewModel) -> Void) {
            self.isUseLeftAlignedFlowLayout = isUseLeftAlignedFlowLayout
        self.onTapEntity = onTapEntity
        super.init(frame: .zero)
        
        // 注册 WebP 解码器
        let webPCoder = SDImageWebPCoder.shared
        SDImageCodersManager.shared.addCoder(webPCoder)
        
        setupViews()
        
        NotificationCenter.default.addObserver(forName: Notification.Name("kNoti_Get_NewSymbols"), object: nil, queue: .main) { _ in
            self.collectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = .orange

        self.setupCollectionView()
        
        requestPreviewData()
    }
    
    private func requestPreviewData() {
        let dataModels: [TSPreviewModel] = LoadJSONUtil.loadJSONs(from: "previewDatas") ?? []
        
        self.dataModels = dataModels
        self.collectionView.dataModels = dataModels
        self.collectionView.reloadData()
    }
    
    func setupCollectionView() {
        collectionView = TSPreviewCollectionView(frame: .zero, isUseLeftAlignedFlowLayout: isUseLeftAlignedFlowLayout, onTapEntity: onTapEntity)
        self.addSubview(collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
