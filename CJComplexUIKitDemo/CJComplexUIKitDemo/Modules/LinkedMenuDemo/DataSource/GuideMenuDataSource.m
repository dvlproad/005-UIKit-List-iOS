//
//  GuideMenuDataSource.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "GuideMenuDataSource.h"
#import "GuideMenuTableViewCell.h"
#import "CQTSLocImagesUtil.h"

@interface GuideMenuDataSource () {
    
}
@property (nonatomic, strong) NSArray<CQTSLocImageDataModel *> *dataModels;    /**< 菜单数据 */

@property (nonatomic, copy, readonly) void(^cellAtIndexPathConfigBlock)(UICollectionViewCell *bCollectionViewCell, NSIndexPath *bIndexPath); /**< 绘制指定indexPath的cell */

@end


@implementation GuideMenuDataSource

#pragma mark - Init
/*
 *  初始化 TableView 的 dataSource
 *
 *  @param rowCount             菜单个数
 *
 *  @return TableView 的 dataSource
 */
- (instancetype)initWithRowCount:(NSInteger)rowCount
{
    NSInteger iRowCount = rowCount;
    
    NSMutableArray<CQTSLocImageDataModel *> *dataModels = [CQTSLocImagesUtil __getTestLocalImageDataModelsWithCount:iRowCount randomOrder:NO];
    for (int row = 0; row < iRowCount; row++) {
        CQTSLocImageDataModel *module = [dataModels objectAtIndex:row];
        module.name = [NSString stringWithFormat:@"%02d", row];
    }

    self = [self initWithDataModels:dataModels];
    if (self) {
        
    }
    return self;
}

/*
 *  初始化 TableView 的 dataSource
 *
 *  @param dataModels            菜单列表数据
 *
 *  @return TableView 的 dataSource
 */
- (instancetype)initWithDataModels:(NSArray<CQTSLocImageDataModel *> *)dataModels
{
    self = [super init];
    if (self) {
        self.dataModels = dataModels;
    }
    return self;
}


/*
 *  注册 TableView 所需的所有 cell
 */
- (void)registerAllCellsForTableView:(UITableView *)tableView {
    [tableView registerClass:[GuideMenuTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CQTSLocImageDataModel *moduleModel = [self.dataModels objectAtIndex:indexPath.row];
    
    GuideMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.myImageView.image = moduleModel.image;
    cell.mainTitleLabel.text = moduleModel.name;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}

@end
