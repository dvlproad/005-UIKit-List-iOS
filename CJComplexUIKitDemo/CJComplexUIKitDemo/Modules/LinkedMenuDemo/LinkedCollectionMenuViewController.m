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
#import "CollectionMenuDataSource.h"

#import <CJComplexUIKit/CJLinkedCollectionMenuView.h>
#import <CQDemoKit/CJUIKitCollectionViewCell.h>

@interface LinkedCollectionMenuViewController ()

@property (nonatomic, strong) GuideMenuDataSource *leftDataSource;
@property (nonatomic, strong) CollectionMenuDataSource *rightDataSource;

@property (nonatomic, strong) CJLinkedCollectionMenuView *menuView;

@end

@implementation LinkedCollectionMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor.cyanColor colorWithAlphaComponent:0.8];
    
    self.leftDataSource = [[GuideMenuDataSource alloc] init];
    self.rightDataSource = [[CollectionMenuDataSource alloc] init];
    
    __weak typeof(self)weakSelf = self;
    self.menuView = [[CJLinkedCollectionMenuView alloc] initWithLeftWidth:100 leftSetupBlock:^(UITableView * _Nonnull leftTableView) {
        //
    } leftDataSource:self.leftDataSource rightSetupBlock:^(UICollectionView * _Nonnull rightCollectionView) {
        [weakSelf.rightDataSource registerAllCellsForCollectionView:rightCollectionView];
    } rightDataSource:self.rightDataSource];

    self.menuView.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.menuView];
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuide).offset(10);
        make.bottom.equalTo(self.mas_bottomLayoutGuide).offset(-10);
    }];
}


@end
