//
//  LinkedTableMenuViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "LinkedTableMenuViewController.h"
#import <Masonry/Masonry.h>

#import "GuideMenuDataSource.h"
#import "TableViewMenuDataSource.h"

#import <CJComplexUIKit/CJLinkedTableMenuView.h>


@interface LinkedTableMenuViewController ()

@property (nonatomic, strong) GuideMenuDataSource *leftDataSource;
@property (nonatomic, strong) TableViewMenuDataSource *rightDataSource;

@property (nonatomic, strong) CJLinkedTableMenuView *menuView;

@end

@implementation LinkedTableMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor.cyanColor colorWithAlphaComponent:0.8];
    
    self.leftDataSource = [[GuideMenuDataSource alloc] init];
    self.rightDataSource = [[TableViewMenuDataSource alloc] init];
    
    
    self.menuView = [[CJLinkedTableMenuView alloc] initWithLeftWidth: 100 leftSetupBlock:nil leftDataSource:self.leftDataSource rightSetupBlock:nil rightDataSource:self.rightDataSource];
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
