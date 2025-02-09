//
//  CJLinkedTableMenuView.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2020/3/26.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJLinkedTableMenuView : UIView

- (instancetype)initWithLeftWidth:(CGFloat)leftWidth
                   leftSetupBlock:(nullable void (^)(UITableView *leftTableView))leftSetupBlock
                   leftDataSource:(id<UITableViewDataSource>)leftDataSource
                  rightSetupBlock:(nullable void (^)(UITableView *rightTableView))rightSetupBlock
                  rightDataSource:(id<UITableViewDataSource>)rightDataSource NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
