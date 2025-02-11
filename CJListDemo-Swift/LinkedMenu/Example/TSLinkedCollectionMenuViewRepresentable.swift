//
//  TSLinkedCollectionMenuViewRepresentable.swift
//  CJListDemo-Swift
//
//  Created by qian on 2025/2/11.
//

import SwiftUI
import CJListKit_Swift

@available(iOS 13.0, *)
public struct TSLinkedCollectionMenuViewRepresentable: UIViewRepresentable {
    var rightColumnCount: Int
    var layoutModel: CJLinkedMenuLayoutModel
    public var isUseForText: Bool   // true: 文案库选择   false: 图标库选择
    @Binding var isForCloseState: Bool
    var onTapRightIndexPath: ((IndexPath, _ newImageModel: CJBaseImageModel) -> Void)
    
    public func makeUIView(context: Context) -> TSLinkedCollectionMenuView {
        // Initialize the custom view and return it
        return TSLinkedCollectionMenuView(
            rightColumnCount: rightColumnCount,
            layoutModel: layoutModel,
            isUseForText: isUseForText,
            isForCloseState: isForCloseState,
            onTapRightIndexPath: onTapRightIndexPath
        )
    }
    
    public func updateUIView(_ uiView: TSLinkedCollectionMenuView, context: Context) {
        // Here, you can update the view if needed (e.g., if any state changes)
        uiView.isForCloseState = isForCloseState
    }
}
