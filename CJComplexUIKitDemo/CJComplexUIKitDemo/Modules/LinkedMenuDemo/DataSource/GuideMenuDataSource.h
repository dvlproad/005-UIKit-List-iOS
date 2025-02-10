//
//  GuideMenuDataSource.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQTSLocImageDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GuideMenuDataSource : NSObject<UITableViewDataSource>

#pragma mark - Init
/*
 *  初始化 TableView 的 dataSource
 *
 *  @param rowCount             菜单个数
 *
 *  @return TableView 的 dataSource
 */
- (instancetype)initWithRowCount:(NSInteger)rowCount;
/*
 *  初始化 TableView 的 dataSource
 *
 *  @param dataModels            菜单列表数据
 *
 *  @return TableView 的 dataSource
 */
- (instancetype)initWithDataModels:(NSArray<CQTSLocImageDataModel *> *)dataModels NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/*
 *  注册 TableView 所需的所有 cell
 */
- (void)registerAllCellsForTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
