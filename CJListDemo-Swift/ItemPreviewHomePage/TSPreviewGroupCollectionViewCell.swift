//
//  TSPreviewGroupCollectionViewCell.swift
//  CJListDemo-Swift
//
//  Created by qian on 2025/1/14.
//

import UIKit
import CJListKit_Swift

@objc class TSPreviewGroupCollectionViewCell: UICollectionViewCell {
    var titleLabel: UILabel!
    var collectionView: ControlWidgetPreviewGroupCollectionView!
    var onTapSelf: (() -> Void)?
    var onTapGroupItem: ((_ groupItemModel: String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        let titleLabel = UILabel()
        //titleLabel.backgroundColor = UIColor.green
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.cjColor(withHexString: "#333333", alpha: 1.0)
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(12)
        }
        self.titleLabel = titleLabel
        
        
        let collectionView = ControlWidgetPreviewGroupCollectionView.init(frame: .zero, onTapSelf: {
            self.onTapSelf?()
        }, onTapGroupItem: { groupItemModel in
            self.onTapGroupItem?(groupItemModel)
        })
        collectionView.backgroundColor = UIColor.cjColor(withHexString: "#C7C7C7", alpha: 1.0)
        collectionView.layer.cornerRadius = 22.5
        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top).offset(-7.5)
        }
        self.collectionView = collectionView
    }
    
    func configure(tapSelfHandler: @escaping () -> Void, tapGroupItemHandler: @escaping (_ groupItemModel: String) -> Void) {
        self.onTapSelf = tapSelfHandler
        self.onTapGroupItem = tapGroupItemHandler
    }
    
    func setPreviewModel(_ previewModel: TSPreviewModel) {
        self.titleLabel.text = previewModel.name
        
        self.collectionView.groupItemModels = previewModel.entitys
        self.collectionView.reloadData()
    }
}


@objc public class ControlWidgetPreviewGroupCollectionView: UICollectionView {
    var groupItemModels: [String] = []
    var onTapSelf: (() -> Void)
    var onTapGroupItem: ((_ groupItemModel: String) -> Void)
    
    /// 初始化方法
    /// - Parameters:
    ///   - frame: frame
    ///   - onTapSelf: 点击collectionView上非cell的区域
    ///   - onTapGroupItem: 点击collectionView上的cell的区域
    @objc public init(
        frame: CGRect,
        onTapSelf: @escaping () -> Void,
        onTapGroupItem: @escaping (_ groupItemModel: String) -> Void)
    {
        self.onTapSelf = onTapSelf
        self.onTapGroupItem = onTapGroupItem
        
        let layout = CJLeftAlignedFlowLayout()
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
        register(ControlWidgetPreviewGroupItemCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(ControlWidgetPreviewGroupItemCollectionViewCell.self))
        
        // 设置数据源和代理
        dataSource = self
        delegate = self
        
        // 添加点击手势识别器来监听 collectionView 外的点击事件
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideCollectionView(_:)))
        tapGesture.cancelsTouchesInView = false // 确保手势识别器不会阻止其他视图的事件传递
        self.addGestureRecognizer(tapGesture)
    }
    
    // 点击collectionView上的cell的区域触发didSelectItemAt，点击非cell的区域触发另一个方法
    // 手势识别器方法：处理 collectionView 之外的点击事件
    @objc func handleTapOutsideCollectionView(_ gesture: UITapGestureRecognizer) {
        // 检查点击是否发生在 collectionView 内部
        let touchPoint = gesture.location(in: self)
        // 如果点击的位置不在有效的 cell 内部，则触发另一个方法
        if let indexPath = self.indexPathForItem(at: touchPoint) {
            // 如果点击的区域在 cell 内部，则 do nothing
            return
        } else {
            // 如果点击的位置不在任何 cell 内部，则触发特定的处理方法
            //debugPrint("点击了 collectionView 上非 cell 的区域")
            // 在这里处理点击非 cell 区域时的操作
            self.onTapSelf()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension ControlWidgetPreviewGroupCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let groupItemModel = groupItemModels[indexPath.row]
        onTapGroupItem(groupItemModel)
    }
}

// MARK: - UICollectionViewDataSource
extension ControlWidgetPreviewGroupCollectionView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupItemModels.count // 假设有 20 个数据项
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let groupItemModel = groupItemModels[indexPath.row]
        let cell = dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ControlWidgetPreviewGroupItemCollectionViewCell.self), for: indexPath) as! ControlWidgetPreviewGroupItemCollectionViewCell
        //cell.backgroundColor = .cyan
        cell.setGroupItemModel(groupItemModel)
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension ControlWidgetPreviewGroupCollectionView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let groupItemModel = groupItemModels[indexPath.row]

        var columnCount: Int
        var topWidthHeightRatio: CGFloat // 除文字和间距外的顶部视图的宽高比
        var imageDistanceAndImageHeight: CGFloat
  
        columnCount = 4
        topWidthHeightRatio = 70.0/70.0
        imageDistanceAndImageHeight = 0
           

        let sectionInset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
        let columnSpacing = self.collectionView(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: indexPath.section)
        let collectionWidth = collectionView.frame.size.width //UIScreen.main.bounds.width
        let itemsWithSpacingWidth = collectionWidth - sectionInset.left - sectionInset.right
        let itemsWidth = itemsWithSpacingWidth - columnSpacing * CGFloat(columnCount - 1)
        let itemWidth = floor(itemsWidth / CGFloat(columnCount))
        let itemTopHeight = floor(itemWidth / topWidthHeightRatio)
        let itemHeight = itemTopHeight + imageDistanceAndImageHeight
        return CGSize(width: itemWidth, height: itemHeight)
    }
}


/// Group 中 item 的 cell
class ControlWidgetPreviewGroupItemCollectionViewCell: UICollectionViewCell {
    var preImageView: UIImageView! // 预览图（整个结构使用预览图展示）
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        let preImageView = UIImageView()
        //preImageView.backgroundColor = .blue
        preImageView.contentMode = .scaleAspectFill
        preImageView.layer.masksToBounds = true
        self.contentView.addSubview(preImageView)
        preImageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        self.preImageView = preImageView
    }
    
    func setGroupItemModel(_ groupItemModel: String) {
//        if groupItemModel.style == .circle {
            self.preImageView.layer.cornerRadius = CGRectGetWidth(self.frame)/2.0
//        } else {
//            self.preImageView.layer.cornerRadius = 15
//        }
        
        let imageUrl = groupItemModel
        self.preImageView.sd_setImage(with: URL(string: imageUrl))
    }
}
