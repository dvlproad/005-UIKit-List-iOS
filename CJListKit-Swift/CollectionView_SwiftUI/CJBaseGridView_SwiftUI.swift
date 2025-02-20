//
//  CJBaseGridView_SwiftUI.swift
//  CJListKit-Swift
//
//  Created by qian on 2025/1/14.
//
//  多行的滚动视图。（单行或者单列滚动的视图，且可额外设置头尾视图，请见 CJBaseScrollView_SwiftUI.swift)

import SwiftUI

@available(iOS 14.0, *)
public struct CJBaseGridView<CellView: View, TModel: Identifiable>: View {
    let disabledScroll: Bool
    let itemsPerRow: Int // 每行显示的项数
    let cellItemSpacing: CGFloat    // item 之间的间隔
    let rowHeight: CGFloat
    let cellSizeForIndex:  (_ index: Int) -> (CGFloat)
    let cellViewGetter: (_ dataModel: TModel, _ isSelected: Bool) -> CellView
    
    let maxRowCount: Int? // 视图允许占用的最大行数
    
    var dataModels: [TModel]
    @Binding var currentDataModel: TModel?
    var onChangeOfDataModel: ((_ newDataModel: TModel) -> Void)?
    
    public init(
        disabledScroll: Bool = false,
        itemsPerRow: Int,
        cellItemSpacing: CGFloat,
        rowHeight: CGFloat,
        cellSizeForIndex: @escaping (_: Int) -> CGFloat,
        cellViewGetter: @escaping (_ dataModel: TModel, _ isSelected: Bool) -> CellView,
        maxRowCount: Int? = nil,
        dataModels: [TModel],
        currentDataModel: Binding<TModel?> = .constant(nil),
        onChangeOfDataModel: ((_ newDataModel: TModel) -> Void)? = nil
    ) {
        self.disabledScroll = disabledScroll
        self.itemsPerRow = itemsPerRow
        self.cellItemSpacing = cellItemSpacing
        self.rowHeight = rowHeight
        self.cellSizeForIndex = cellSizeForIndex
        self.cellViewGetter = cellViewGetter
        self.maxRowCount = maxRowCount
        self.dataModels = dataModels
        self._currentDataModel = currentDataModel
        self.onChangeOfDataModel = onChangeOfDataModel
    }
    
    public var body: some View {
        let viewHeight: CGFloat? = CJBaseGridViewLayoutUtil.getViewHeight(
            dataCount: dataModels.count,
            itemsPerRow: itemsPerRow,
            rowHeight: rowHeight,
            cellItemSpacing: cellItemSpacing,
            maxRowCount: maxRowCount
        )
        ScrollView {
            let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: itemsPerRow)
            LazyVGrid(columns: columns, alignment: .center, spacing: cellItemSpacing) {
                ForEach(dataModels.indices, id: \.self) { index in
                    let model = dataModels[index]
                    let cellSize = cellSizeForIndex(index)
                    let cellView: CellView = cellViewGetter(model, model.id == currentDataModel?.id)
                    cellView
                        .frame(width: cellSize, height: rowHeight)
                        //.background(Color.randomColor)
                        //.cornerRadius(20.0) // 添加圆角
                        .onTapGesture {
                            tapModel(index, model: model)
                        }
                        .id(index)
                }
            }
//            .background(Color.blue)
        }
        .disabled(self.disabledScroll) // 禁用滚动
        .modifier(ConditionalFrameModifier(viewHeight: viewHeight))  // 使用自定义修饰符
//        .background(Color.green)
//        .cornerRadius(22.5) // 添加圆角
//        .padding(.horizontal, 12.0)
    }
    
    // MARK: Event
    private func tapModel(_ index: Int, model: TModel) {
        currentDataModel = model
        
        onChangeOfDataModel?(model)
    }
}

struct CJBaseGridViewLayoutUtil {
    static func getViewHeight(dataCount: Int, itemsPerRow: Int, rowHeight: CGFloat, cellItemSpacing: CGFloat, maxRowCount: Int?, edgeInset: UIEdgeInsets = .zero) -> CGFloat? {
        guard let maxRowCount = maxRowCount else {
            return nil
        }
        
        let rowCount = dataCount / itemsPerRow + (dataCount % itemsPerRow > 0 ? 1 : 0)
        let showRowCount = min(rowCount, maxRowCount)
        let height: CGFloat = CGFloat(showRowCount) * rowHeight + CGFloat(showRowCount - 1) * cellItemSpacing + edgeInset.top + edgeInset.bottom
        return height
    }
}

@available(iOS 13.0, *)
struct ConditionalFrameModifier: ViewModifier {
    var viewHeight: CGFloat?

    func body(content: Content) -> some View {
        // 确保 viewHeight 是有效的数值，非负且非 NaN
        if let viewHeight = viewHeight, viewHeight >= 0, !viewHeight.isNaN {
            return AnyView(content.frame(height: viewHeight))  // 如果有效，应用 frame
        } else {
            return AnyView(content)  // 否则，保持原样，不应用 frame
        }
    }
}
