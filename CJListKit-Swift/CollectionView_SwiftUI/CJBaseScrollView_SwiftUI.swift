//
//  IconCollectionView.swift
//  CJListKit-Swift
//
//  Created by qian on 2025/1/14.
//
import SwiftUI

@available(iOS 14.0, *)
public struct BaseIconsScrollView<CellView: View, HeaderView: View, BottomView: View, TModel: Identifiable>: View {
    //let axes: Axis.Set
    var direction: Axis.Set // 用来设置滚动方向，支持水平和竖直
    let cellItemSpacing: CGFloat    // item 之间的间隔
    let cellSizeForIndex:  (_ index: Int) -> (width: CGFloat?, height: CGFloat?)
    let cellViewGetter: (_ dataModel: TModel, _ isSelected: Bool) -> CellView
    
    var maxCount: Int?
    var headerView: (() -> HeaderView)?  // 头部视图
    var bottomView: (() -> BottomView)?   // 尾部视图
    
    var dataModels: [TModel]
    @Binding var currentDataModel: TModel?
    var onChangeOfDataModel: ((_ newDataModel: TModel) -> Void)
    
    @State var selectedIndex: Int?
    
    public init(direction: Axis.Set,
                cellItemSpacing: CGFloat,
                // cell 的 width / height 返回nil，则会自适应父视图大小
                cellSizeForIndex: @escaping (_ index: Int) -> (width: CGFloat?, height: CGFloat?),
                cellViewGetter: @escaping (_ dataModel: TModel, _ isSelected: Bool) -> CellView,
                
                maxCount: Int? = nil,
                headerView: (() -> HeaderView)? = nil,
                bottomView: (() -> BottomView)? = nil,
                
                dataModels: [TModel],
                currentDataModel: Binding<TModel?>,
                onChangeOfDataModel: @escaping (_: TModel) -> Void
    ) {
        self.direction = direction
        
        self.cellItemSpacing = cellItemSpacing
        self.cellSizeForIndex = cellSizeForIndex
        self.cellViewGetter = cellViewGetter
        
        self.maxCount = maxCount
        self.headerView = headerView
        self.bottomView = bottomView
        
        self.dataModels = dataModels
        self._currentDataModel = currentDataModel
        self.onChangeOfDataModel = onChangeOfDataModel
    }
    
    // MARK: View
    public var body: some View {
        ScrollViewReader { scrollView in
            ScrollView(direction, showsIndicators: false) {
                if direction == .vertical {
                    LazyVStack(spacing: cellItemSpacing) {
                        buildItems()
                    }
                } else {
                    LazyHStack(spacing: cellItemSpacing) {
                        buildItems()
                    }
                }
            }
            .onChange(of: selectedIndex) { newValue in
                withAnimation {
                    if let index = newValue {
                        scrollView.scrollTo(index, anchor: .center)
                    }
                }
            }
            .onAppear() {
                selectedIndex = dataModels.firstIndex(where: { $0.id == currentDataModel?.id }) ?? -1
                withAnimation {
                    if let index = selectedIndex {
                        scrollView.scrollTo(index, anchor: .center)
                    }
                }
            }
        }
    }
    
    // 处理视图项目的生成
    // 用 Group 来包裹不同的视图元素。这样可以根据滚动方向（direction）动态选择合适的布局容器（LazyVStack 或 LazyHStack）。
    private func buildItems() -> some View {
        Group {
            if headerView != nil {
                headerView!()
            }
            
            let itemCount = dataModels.count
            let showCount = maxCount != nil ? min(maxCount!, itemCount) : itemCount
            ForEach(0..<showCount, id:\.self) { index in
                let model = dataModels[index]
//                let showItems = dataModels.prefix(showCount) // 截取最多 showCount 个元素
//                ForEach(Array(showItems.enumerated()), id: \.offset) { index, model in
                let cellSize = cellSizeForIndex(index)
                cellViewGetter(model, model.id == currentDataModel?.id)
                    .frame(width: cellSize.width, height: cellSize.height)
                    //.background(Color.randomColor)
                    .onTapGesture {
                        tapModel(index, model: model)
                    }
                    .id(index)
            }
            
            if bottomView != nil {
                if let maxCount = maxCount, itemCount > maxCount {
                    bottomView!()
                }
            }
        }
    }
    
    // MARK: Event
    private func tapModel(_ index: Int, model: TModel) {
        currentDataModel = model
        
        selectedIndex = dataModels.firstIndex(where: { $0.id == model.id }) ?? -1
        
        onChangeOfDataModel(model)
    }
}
