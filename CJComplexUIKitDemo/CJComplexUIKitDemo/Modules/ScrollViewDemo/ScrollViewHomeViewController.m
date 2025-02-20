//
//  ScrollViewHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ScrollViewHomeViewController.h"

//UIScrollView
#import "SvDemo_Refresh.h"

//PullScale
#import "PullScaleTopImageViewController.h"

//EmptyView
#import "EmptyScrollViewController1.h"
#import "EmptyScrollViewController2.h"
#import "ScrollContaintViewController.h"



@interface ScrollViewHomeViewController ()

@end

@implementation ScrollViewHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"ScrollViewHome首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //UIScrollView
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIScrollView相关";
        {
            CQDMModuleModel *refreshScrollViewModule = [[CQDMModuleModel alloc] init];
            refreshScrollViewModule.title = @"ScrollView的刷新(MJRefresh)";
            refreshScrollViewModule.classEntry = [SvDemo_Refresh class];
            refreshScrollViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:refreshScrollViewModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //EmptyView
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"EmptyView相关";
        {
            CQDMModuleModel *baseScrollViewModule = [[CQDMModuleModel alloc] init];
            baseScrollViewModule.title = @"DataEmptyView";
            baseScrollViewModule.classEntry = [ScrollContaintViewController class];
            [sectionDataModel.values addObject:baseScrollViewModule];
        }
        {
            CQDMModuleModel *baseScrollViewModule = [[CQDMModuleModel alloc] init];
            baseScrollViewModule.title = @"CJDataEmptyView(DZNEmptyDataSet)";
            baseScrollViewModule.classEntry = [EmptyScrollViewController1 class];
            [sectionDataModel.values addObject:baseScrollViewModule];
        }
        {
            CQDMModuleModel *baseScrollViewModule = [[CQDMModuleModel alloc] init];
            baseScrollViewModule.title = @"CJDataEmptyView(UIScrollView+CJAddFillView)";
            baseScrollViewModule.classEntry = [EmptyScrollViewController2 class];
            [sectionDataModel.values addObject:baseScrollViewModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"其他";
        {
            //PullScaleTopImageViewController
            CQDMModuleModel *pullScaleTopImageModuleModel = [[CQDMModuleModel alloc] init];
            pullScaleTopImageModuleModel.title = @"顶部图片下拉放大，上拉缩小";
            pullScaleTopImageModuleModel.classEntry = [PullScaleTopImageViewController class];
            [sectionDataModel.values addObject:pullScaleTopImageModuleModel];
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
