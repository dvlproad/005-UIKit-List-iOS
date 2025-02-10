//
//  LinkedMenuHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "LinkedMenuHomeViewController.h"

#import <CJListDemo_Swift/CJListDemo_Swift-Swift.h>


@interface LinkedMenuHomeViewController ()

@end

@implementation LinkedMenuHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"联动的菜单首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    __weak typeof(self)weakSelf = self;
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //UIScrollView
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"联动的菜单(左右)";
        {
            CQDMModuleModel *refreshScrollViewModule = [[CQDMModuleModel alloc] init];
            refreshScrollViewModule.title = @"联动的菜单(左右)";
            refreshScrollViewModule.content = @"右侧是 CollectionView（4列)";
            refreshScrollViewModule.actionBlock = ^{
                UIViewController *vc = [[TSLinkedCollectionMenuViewController alloc] initWithRightColumnCount:4 rightCellWidthHeightRatio:1.0];
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };
            [sectionDataModel.values addObject:refreshScrollViewModule];
        }
        {
            CQDMModuleModel *refreshScrollViewModule = [[CQDMModuleModel alloc] init];
            refreshScrollViewModule.title = @"联动的菜单(左右)";
            refreshScrollViewModule.content = @"右侧是 CollectionView（1列)";
            refreshScrollViewModule.actionBlock = ^{
                UIViewController *vc = [[TSLinkedCollectionMenuViewController alloc] initWithRightColumnCount:1 rightCellWidthHeightRatio:300/44.0];
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };
            [sectionDataModel.values addObject:refreshScrollViewModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
