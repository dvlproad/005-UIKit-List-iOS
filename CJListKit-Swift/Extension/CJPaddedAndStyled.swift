//
//  TSTSSwiftUIView.swift
//  TSDemoDemo
//
//  Created by ciyouzen on 2020/2/14.
//  Copyright © 2020 dvlproad. All rights reserved.
//

import SwiftUI

// 自定义视图修饰符
@available(iOS 13.0, *)
struct PaddedAndStyled: ViewModifier {
    var paddingInsets: EdgeInsets
    var backgroundColor: Color
    var cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .padding(paddingInsets)  // 应用自定义边距
            .background(backgroundColor)  // 设置背景色
            .cornerRadius(cornerRadius)  // 设置圆角
    }
}

// 创建一个扩展方法来简化使用
@available(iOS 13.0, *)
extension View {
    func paddedAndStyled(paddingInsets: EdgeInsets, backgroundColor: Color, cornerRadius: CGFloat) -> some View {
        self.modifier(PaddedAndStyled(paddingInsets: paddingInsets, backgroundColor: backgroundColor, cornerRadius: cornerRadius))
    }
}


@available(iOS 13.0, *)
struct PaddedAndStyled_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Hello, SwiftUI!")
                .background(Color.white)  // 内部视图的背景色
                .padding(EdgeInsets(top: 12.0, leading: 12.0, bottom: 12.0, trailing: 12.0))  // 内部视图的边距
                .background(Color.green)  // 内部视图的背景色
                .cornerRadius(22.5)  // 内部视图的圆角
                .padding(EdgeInsets(top: 39.0, leading: 12.0, bottom: 39.0, trailing: 12.0))  // 外部视图与内部视图的边距
                .background(Color.blue)  // 外部视图的背景色
                .cornerRadius(12.0)  // 外部视图的圆角
            
            Text("Hello, SwiftUI!")
                .background(Color.white)
                .paddedAndStyled(
                    paddingInsets: EdgeInsets(top: 12.0, leading: 12.0, bottom: 12.0, trailing: 12.0),
                    backgroundColor: Color.green,
                    cornerRadius: 22.5
                )
                .paddedAndStyled(
                    paddingInsets: EdgeInsets(top: 39.0, leading: 12.0, bottom: 39.0, trailing: 12.0),
                    backgroundColor: Color.blue,
                    cornerRadius: 12.0
                )
        }
    }
}
