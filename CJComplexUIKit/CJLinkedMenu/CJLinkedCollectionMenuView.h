//
//  CJLinkedCollectionMenuView.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2020/3/26.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJLinkedCollectionMenuView : UIView

/*
 *  初始化 CollectionView 的 dataSource
 *
 *  @param leftWidth            左侧菜单所占宽度
 *  @param rightColumnCount     右侧菜单列数
 *  @param leftSetupBlock       左侧菜单的setupBlock
 *  @param leftDataSource       左侧菜单的dataSource
 *  @param rightSetupBlock      右侧菜单的setupBlock
 *  @param rightDataSource      右侧菜单的dataSource
 *  @param onTapRightIndexPath  点击右侧的数据
 *
 *  @return CollectionView 的 dataSource
 */
- (instancetype)initWithLeftWidth:(CGFloat)leftWidth
                 rightColumnCount:(NSInteger)rightColumnCount
                   leftSetupBlock:(nullable void (^)(UITableView *leftTableView))leftSetupBlock
                   leftDataSource:(id<UITableViewDataSource>)leftDataSource
                  rightSetupBlock:(nonnull void (^)(UICollectionView *rightCollectionView))rightSetupBlock
                  rightDataSource:(id<UICollectionViewDataSource>)rightDataSource
              onTapRightIndexPath:(void (^)(NSIndexPath *indexPath))onTapRightIndexPath NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/*
 *  更新选中哪些位置(一般在 layoutSubviews 或 viewDidLayoutSubviews 中调用以设置初始选中的cell）
 *
 *  @param selectedIndexPaths   选中的indexPath数组
 */
- (void)updateSelectedIndexPaths:(nullable NSArray<NSIndexPath *> *)selectedIndexPaths;

@end

NS_ASSUME_NONNULL_END
