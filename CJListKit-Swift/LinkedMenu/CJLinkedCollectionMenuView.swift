//
//  CJLinkedCollectionMenuView.swift
//  CJListKit-Swift
//
//  Created by qian on 2025/1/17.
//

import UIKit

@objc public class CJLinkedCollectionMenuView: UIView, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private(set) var leftTableView: UITableView!
    private(set) var rightCollectionView: UICollectionView!
    
    private var click: Bool = false
    
    private var leftWidth: CGFloat
    private var rightColumnCount: Int
    
    private weak var leftDataSource: UITableViewDataSource?
    private weak var rightDataSource: UICollectionViewDataSource?
    
    private var leftTableViewSetupBlock: ((UITableView) -> Void)?
    private var rightCollectionViewSetupBlock: ((UICollectionView) -> Void)?
    private var onTapRightIndexPath: ((IndexPath) -> Void)?
    
    @objc public init(leftWidth: CGFloat,
         rightColumnCount: Int,
         leftSetupBlock: ((UITableView) -> Void)?,
         leftDataSource: UITableViewDataSource?,
         rightSetupBlock: @escaping (UICollectionView) -> Void,
         rightDataSource: UICollectionViewDataSource?,
         onTapRightIndexPath: @escaping (IndexPath) -> Void) {
        
        self.leftWidth = leftWidth
        self.rightColumnCount = rightColumnCount
        self.leftDataSource = leftDataSource
        self.rightDataSource = rightDataSource
        self.leftTableViewSetupBlock = leftSetupBlock
        self.rightCollectionViewSetupBlock = rightSetupBlock
        self.onTapRightIndexPath = onTapRightIndexPath
        
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc public func updateSelectedIndexPaths(_ selectedIndexPaths: [IndexPath]?) {
        selectedIndexPaths?.forEach { indexPath in
            rightCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        }
    }
    
    private func setupViews() {
        click = false
        
        leftTableView = UITableView(frame: .zero, style: .plain)
        leftTableViewSetupBlock?(leftTableView)
        leftTableView.delegate = self
        leftTableView.dataSource = leftDataSource
        addSubview(leftTableView)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        rightCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        rightCollectionViewSetupBlock?(rightCollectionView)
        rightCollectionView.delegate = self
        rightCollectionView.dataSource = rightDataSource
        addSubview(rightCollectionView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        leftTableView.translatesAutoresizingMaskIntoConstraints = false
        rightCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftTableView.topAnchor.constraint(equalTo: topAnchor),
            leftTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            leftTableView.widthAnchor.constraint(equalToConstant: leftWidth),
            
            rightCollectionView.leadingAnchor.constraint(equalTo: leftTableView.trailingAnchor),
            rightCollectionView.topAnchor.constraint(equalTo: topAnchor),
            rightCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            rightCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // MARK: - UITableViewDelegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTableView {
            let moveToIndexPath = IndexPath(row: 0, section: indexPath.row)
            click = true
            rightCollectionView.scrollToItem(at: moveToIndexPath, at: .top, animated: true)
            rightCollectionView.deselectItem(at: moveToIndexPath, animated: true)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    // MARK: - UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onTapRightIndexPath?(indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //print("=======取消选择")
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let perRowMaxColumnCount = rightColumnCount
        
        let sectionInset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
        let columnSpacing = self.collectionView(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: indexPath.section)
        
        let width = collectionView.frame.width
        let validWidth = width - sectionInset.left - sectionInset.right - columnSpacing * CGFloat(perRowMaxColumnCount - 1)
        let collectionViewCellWidth = floor(validWidth / CGFloat(perRowMaxColumnCount))
        
        return CGSize(width: collectionViewCellWidth, height: collectionViewCellWidth)
    }
    
    // MARK: - UIScrollViewDelegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView != leftTableView, !click else { return }
        
        let visibleIndexPaths = rightCollectionView.indexPathsForVisibleItems.sorted { $0.section < $1.section }
        guard let topVisibleIndexPath = visibleIndexPaths.first else { return }
        
        let moveToIndexPath = IndexPath(row: topVisibleIndexPath.section, section: 0)
        leftTableView.selectRow(at: moveToIndexPath, animated: true, scrollPosition: .middle)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView != leftTableView {
            click = false
        }
    }
}
