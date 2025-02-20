//
//  TSTSSwiftUIView.swift
//  TSDemoDemo
//
//  Created by ciyouzen on 2020/2/14.
//  Copyright © 2020 dvlproad. All rights reserved.
//

import SwiftUI
import UIKit
import CJListKit_Swift

@available(iOS 14.0, *)
@objc public class TSTSUIView: UIView {
    let itemsPerRow: Int // 每行显示的项数
    let cellItemSpacing: CGFloat
    let cellWidth: CGFloat
    let rowHeight: CGFloat
    let maxRowCount: Int? // 视图允许占用的最大行数
    
    @objc public init(itemsPerRow: Int, cellItemSpacing: CGFloat, cellWidth: CGFloat, rowHeight: CGFloat, maxRowCount: Int = 9999) {
        self.itemsPerRow = itemsPerRow
        self.cellItemSpacing = cellItemSpacing
        self.cellWidth = cellWidth
        self.rowHeight = rowHeight
        self.maxRowCount = maxRowCount
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    init() {
        fatalError("init() can not be implemented")
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 从 swiftuiView 生成 uiView ，并显示到视图中
    private var hostingController: UIViewController?
    private func setupViews() {
        let swiftuiView = TSTSSwiftUIView(itemsPerRow: itemsPerRow, cellItemSpacing: cellItemSpacing, cellWidth: cellWidth, rowHeight: rowHeight, maxRowCount: maxRowCount)
        let hostingController = UIHostingController(rootView: swiftuiView)
        self.hostingController = hostingController
        
        let uiView: UIView = hostingController.view ?? UIView()
        self.showUIView(uiView)
    }
    
    // 添加到 uiView ,并设置约束
    private func showUIView(_ uiView: UIView) {
        self.addSubview(uiView)
        uiView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uiView.topAnchor.constraint(equalTo: self.topAnchor),
            uiView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            uiView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            uiView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

@available(iOS 14.0, *)
@objc public class TSTSUIViewController: UIViewController {
    let itemsPerRow: Int // 每行显示的项数
    let cellItemSpacing: CGFloat
    let cellWidth: CGFloat
    let rowHeight: CGFloat
    let maxRowCount: Int? // 视图允许占用的最大行数
    
    @objc public init(itemsPerRow: Int, cellItemSpacing: CGFloat, cellWidth: CGFloat, rowHeight: CGFloat, maxRowCount: Int = 9999) {
        self.itemsPerRow = itemsPerRow
        self.cellItemSpacing = cellItemSpacing
        self.cellWidth = cellWidth
        self.rowHeight = rowHeight
        self.maxRowCount = maxRowCount
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    init() {
        fatalError("init() can not be implemented")
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 105/255.0, green: 193/255.0, blue: 243/255.0, alpha: 1)

        // 创建 SwiftUI 视图，并用 UIHostingController 来包装 SwiftUI 视图
        let swiftUIView = TSTSSwiftUIView(itemsPerRow: itemsPerRow, cellItemSpacing: cellItemSpacing, cellWidth: cellWidth, rowHeight: rowHeight, maxRowCount: maxRowCount)
        let hostingController = UIHostingController(rootView: swiftUIView)

        // 添加到当前视图控制器的视图中，并设置 Auto Layout 约束
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            hostingController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])

        // 完成添加子视图控制器
        hostingController.didMove(toParent: self)
    }
}



@available(iOS 14.0, *)
struct TSTSSwiftUIView: View {
    let itemsPerRow: Int // 每行显示的项数
    let cellItemSpacing: CGFloat
    let cellWidth: CGFloat
    let rowHeight: CGFloat
    let maxRowCount: Int? // 视图允许占用的最大行数
    
    @State var dataModels: [TSGridItemModel] = []
    var body: some View {
        let edgeInset = UIEdgeInsets(top: 39.0, left: 12.0, bottom: 39.0, right: 12.0)
        
        VStack(alignment: .center, spacing: 0) {
            CJEdgeInsetGridView(
                backgroundView: {
                    Color.red
                    //Color(hex: "#F5F5F5")
                },
                contentEdgeInset: edgeInset,
                contentBackgroundColor: Color.green, // Color(hex: "#EBEBEB")
                contentCornerRadius: 22.5,
                disabledScroll: true,
                cellEdgeInset: UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0),
                itemsPerRow: itemsPerRow,
                cellItemSpacing: cellItemSpacing,
                rowHeight: rowHeight,
                cellSizeForIndex: { index in
                    return cellWidth
                },
                cellViewGetter: { dataModel, isSelected in
                    return Color.random()
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .overlay(
                            Text(dataModel.text) // 展示索引，帮助调试
                                .foregroundColor(.black)
                        )
                    
                },
                maxRowCount: maxRowCount,
                dataModels: self.dataModels,
                currentDataModel: .constant(nil),
                onChangeOfDataModel: { newDataModel in
                    
                }
            )
        }
        .onAppear() {
            // 创建100个 TSGridItemModel
            var dataModels: [TSGridItemModel] = []
            for i in 0 ..< 7 {
                let model = TSGridItemModel(id: i, text: "Item \(i)")
                dataModels.append(model)
            }
            self.dataModels = dataModels
        }
    }
}

@available(iOS 13.0, *)
public struct ConditionalFrameModifier: ViewModifier {
    public var viewHeight: CGFloat?

    public func body(content: Content) -> some View {
        // 确保 viewHeight 是有效的数值，非负且非 NaN
        if let viewHeight = viewHeight, viewHeight >= 0, !viewHeight.isNaN {
            return AnyView(content.frame(height: viewHeight))  // 如果有效，应用 frame
        } else {
            return AnyView(content)  // 否则，保持原样，不应用 frame
        }
    }
}


struct TSGridItemModel: Identifiable {
    var id: Int
    var text: String
}

// MARK: 预览 BaseControlWidgetAnimationViewInApp
@available(iOS 14.0, *)
struct TSTSSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TSTSSwiftUIView(itemsPerRow: 4, cellItemSpacing: 20, cellWidth: 80, rowHeight: 50, maxRowCount: 2)
    }
}


@available(iOS 13.0, *)
extension Color {
    // 从十六进制颜色字符串生成 Color
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // 如果颜色字符串以 # 开头，去掉 #
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }
        
        // 默认颜色值
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
    
    // 随机颜色生成器
    static func random() -> Color {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1),
            opacity: Double.random(in: 0...1)
        )
    }
}
