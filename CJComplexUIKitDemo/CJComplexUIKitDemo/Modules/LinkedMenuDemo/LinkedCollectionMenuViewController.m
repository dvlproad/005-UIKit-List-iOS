//
//  LinkedCollectionMenuViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "LinkedCollectionMenuViewController.h"
#import <Masonry/Masonry.h>

#import "GuideMenuDataSource.h"

#import <CJComplexUIKit/CJLinkedCollectionMenuView.h>
#import <CQDemoKit/CJUIKitCollectionViewCell.h>
#import <CQDemoKit/CQTSRipeBaseCollectionViewDataSource.h>
#import <CQDemoKit/CJUIKitToastUtil.h>

@interface LinkedCollectionMenuViewController ()

@property (nonatomic, strong) GuideMenuDataSource *leftDataSource;
@property (nonatomic, strong) CQTSRipeBaseCollectionViewDataSource *rightDataSource;    // CollectionMenuDataSource

@property (nonatomic, strong) CJLinkedCollectionMenuView *menuView;

@end

@implementation LinkedCollectionMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor.cyanColor colorWithAlphaComponent:0.8];
    
    NSArray<NSNumber *> *sectionRowCounts = @[@6, @20, @23, @10, @15, @28];
    self.leftDataSource = [[GuideMenuDataSource alloc] initWithRowCount:sectionRowCounts.count];
    self.rightDataSource = [[CQTSRipeBaseCollectionViewDataSource alloc] initWithSectionRowCounts:sectionRowCounts selectedIndexPaths:nil];
    
    __weak typeof(self)weakSelf = self;
    self.menuView = [[CJLinkedCollectionMenuView alloc] initWithLeftWidth:100 rightColumnCount:3 leftSetupBlock:^(UITableView * _Nonnull leftTableView) {
        [weakSelf.leftDataSource registerAllCellsForTableView:leftTableView];
    } leftDataSource:self.leftDataSource rightSetupBlock:^(UICollectionView * _Nonnull rightCollectionView) {
        [weakSelf.rightDataSource registerAllCellsForCollectionView:rightCollectionView];
    } rightDataSource:self.rightDataSource onTapRightIndexPath:^(NSIndexPath * _Nonnull indexPath) {
        CQTSLocImageDataModel *dataModel = [weakSelf.rightDataSource dataModelAtIndexPath:indexPath];
        NSString *message = [NSString stringWithFormat:@"点击了:%@", dataModel.name];
        [CJUIKitToastUtil showMessage:message];
    }];

    self.menuView.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.menuView];
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuide).offset(10);
        make.bottom.equalTo(self.mas_bottomLayoutGuide).offset(-10);
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    NSArray<NSIndexPath *> *selectedIndexPaths = @[[NSIndexPath indexPathForItem:2 inSection:1]];
    [self.menuView updateSelectedIndexPaths:selectedIndexPaths];
}

@end
