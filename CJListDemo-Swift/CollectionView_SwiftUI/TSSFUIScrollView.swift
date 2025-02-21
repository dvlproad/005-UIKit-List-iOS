//
//  TSSwiftUIGridViewSwiftUIView.swift
//  TSDemoDemo
//
//  Created by ciyouzen on 2020/2/14.
//  Copyright © 2020 dvlproad. All rights reserved.
//

import SwiftUI
import CQDemoKit
import CQDemoKit_Swift
import CJListKit_Swift

@available(iOS 14.0, *)
@objc public class TSTSUIView: CQDemoSwiftUIBaseUIView {
    @objc public init() {
        super.init(
            swiftUIView: IconScrollView(
                currentDataModel: .constant(nil),
                enableTintColor: .constant(true),
                onChangeOfDataModel: {
                    newDataModel in
                },
                onTapMore: {
                    
                }
            )
        )
    }
}

@available(iOS 14.0, *)
@objc public class TSTSUIViewController: CQDemoSwiftUIBaseUIViewController {
    @objc public init() {
        super.init(
            swiftUIView: IconScrollView(
                currentDataModel: .constant(nil),
                enableTintColor: .constant(true),
                onChangeOfDataModel: {
                    newDataModel in
                },
                onTapMore: {
                    
                }
            )
        )
    }
}

@available(iOS 14.0, *)
struct IconScrollView: View {
    var maxCount: Int?
    @State var dataModels: [TSGridItemModel] = []
    @Binding var currentDataModel: TSGridItemModel?
    @Binding var enableTintColor: Bool // 是否显示tintColor，控制中心图标关闭状态时候不显示
    var onChangeOfDataModel: ((_ newDataModel: TSGridItemModel) -> Void)
    var onTapMore: (() -> Void)
    
    var body: some View {
        CJBaseScrollView(
            direction: .horizontal,
            cellItemSpacing: 12,
            cellSizeForIndex: { index in
                return (width: 44, height: 44)
            },
            cellViewGetter: { dataModel, isSelected, _ in
                return dataModel.color
                    .cornerRadius(44/2.0)
                    .overlay(
                        Text(dataModel.text)
                            .foregroundColor(.black)
                    )
            },
            maxCount: 10,
            bottomView: {
                IconMoreButton(onTapMore: onTapMore)
            },
            dataModels: dataModels,
            selectedDataModel: $currentDataModel,
            tapAgainShouldCancle: false,
            onTapDataModelComplete: { newDataModel in
                onChangeOfDataModel(newDataModel)
            }
        )
        //.background(Color.red)
        .onFirstAppear() {
            self.requestData()
        }
    }
    
    private func requestData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            var dataModels: [TSGridItemModel] = []
            for i in 0 ..< 100 {
                let model = TSGridItemModel(id: i, text: "Item \(i)")
                dataModels.append(model)
            }
            self.dataModels = dataModels
        }
    }
}

import SwiftUI

@available(iOS 13.0, *)
extension View {
    func onFirstAppear(perform action: (() -> Void)? = nil) -> some View {
        modifier(OnFirstAppear(action: action))
    }
}

@available(iOS 13.0, *)
private struct OnFirstAppear: ViewModifier {
    let action: (() -> Void)?
    
    @State private var hasAppeared = false
    
    func body(content: Content) -> some View {
        content.onAppear {
            if !hasAppeared {
                hasAppeared = true
                action?()
            }
        }
    }
}



@available(iOS 13.0, *)
struct IconMoreButton: View {
    var onTapMore: (() -> Void)
    
    var body: some View {
        Button {
            onTapMore()
        } label: {
            Text("更多")
                .font(.system(size: 11, weight: .regular))
                .foregroundColor(Color(hex: "#999999"))
        }
        .frame(width: 44, height: 44, alignment: .center)
        .background(Color(hex: "#F5F5F5"))
        .cornerRadius(10)
    }
}

