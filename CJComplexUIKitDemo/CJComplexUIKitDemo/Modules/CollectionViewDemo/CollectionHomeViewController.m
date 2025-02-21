//
//  CollectionHomeViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CollectionHomeViewController.h"

#import <CQDemoKit/CJUIKitToastUtil.h>
#import <CJListDemo_Swift/CJListDemo_Swift-Swift.h>

//UICollectionView
#import "CvDemo_Complex.h"

#import "MyEqualCellSizeCollectionViewController.h"
#import "MyEqualCellSizeViewController.h"
#import "MyCycleADViewController.h"

#import "OpenCollectionViewController.h"
#import "CustomLayoutCollectionViewController.h"

//图片选择的集合视图
#import "UploadNoneImagePickerViewController.h"
#import "UploadDirectlyImagePickerViewController.h"

#import "LEWorkHomeViewController.h"

@interface CollectionHomeViewController ()  {
    
}

@end

@implementation CollectionHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"Collection首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //UICollectionView
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UICollectionView相关";
        {
            CQDMModuleModel *complexDemoModule = [[CQDMModuleModel alloc] init];
            complexDemoModule.title = @"ComplexDemo";
            complexDemoModule.classEntry = [CvDemo_Complex class];
            complexDemoModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:complexDemoModule];
        }
        {
            CQDMModuleModel *MyEqualCellSizeCollectionViewModule = [[CQDMModuleModel alloc] init];
            MyEqualCellSizeCollectionViewModule.title = @"MyEqualCellSizeCollectionView(等cell大小)";
            MyEqualCellSizeCollectionViewModule.classEntry = [MyEqualCellSizeCollectionViewController class];
            MyEqualCellSizeCollectionViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:MyEqualCellSizeCollectionViewModule];
        }
        {
            CQDMModuleModel *MyEqualCellSizeViewModule = [[CQDMModuleModel alloc] init];
            MyEqualCellSizeViewModule.title = @"MyEqualCellSizeView(嵌套的等cell大小)";
            MyEqualCellSizeViewModule.classEntry = [MyEqualCellSizeViewController class];
            MyEqualCellSizeViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:MyEqualCellSizeViewModule];
        }
        {
            CQDMModuleModel *cycleScrollViewModule = [[CQDMModuleModel alloc] init];
            cycleScrollViewModule.title = @"MyCycleADView(无限循环的视图)";
            cycleScrollViewModule.classEntry = [MyCycleADViewController class];
            cycleScrollViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:cycleScrollViewModule];
        }
        {
            CQDMModuleModel *openCollectionViewModule = [[CQDMModuleModel alloc] init];
            openCollectionViewModule.title = @"OpenCollectionView(可展开)";
            openCollectionViewModule.classEntry = [OpenCollectionViewController class];
            [sectionDataModel.values addObject:openCollectionViewModule];
        }
        {
            CQDMModuleModel *customLayoutModule = [[CQDMModuleModel alloc] init];
            customLayoutModule.title = @"CustomLayout(自定义布局)";
            customLayoutModule.classEntry = [CustomLayoutCollectionViewController class];
            customLayoutModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:customLayoutModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //图片选择的集合视图DataScrollView
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"DataScrollView(带数据源的滚动视图)";
        {
            CQDMModuleModel *imagePickerCollectionViewModule = [[CQDMModuleModel alloc] init];
            imagePickerCollectionViewModule.title = @"图片选择的集合视图(没上传操作)";
            imagePickerCollectionViewModule.classEntry = [UploadNoneImagePickerViewController class];
            imagePickerCollectionViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:imagePickerCollectionViewModule];
        }
        {
            CQDMModuleModel *imagePickerCollectionViewModule = [[CQDMModuleModel alloc] init];
            imagePickerCollectionViewModule.title = @"图片选择的集合视图(有上传操作)";
            imagePickerCollectionViewModule.classEntry = [UploadDirectlyImagePickerViewController class];
            imagePickerCollectionViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:imagePickerCollectionViewModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 其他
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"其他";
        {
            CQDMModuleModel *imagePickerCollectionViewModule = [[CQDMModuleModel alloc] init];
            imagePickerCollectionViewModule.title = @"工作首页";
            imagePickerCollectionViewModule.classEntry = [LEWorkHomeViewController class];
            [sectionDataModel.values addObject:imagePickerCollectionViewModule];
        }
        {
            CQDMModuleModel *previewListModule = [[CQDMModuleModel alloc] init];
            previewListModule.title = @"Item的预览列表(已解决布局)";
            previewListModule.content = @"常用于外部不提供详情数据，而是用一整张预览图来展示\n重点:已解决某行数据不足时候排列会从一二位跑到头尾位置";
            previewListModule.contentLines = 2;
            previewListModule.viewGetterHandle = ^UIView * _Nonnull{
                UIView *tsView = [[TSPreviewView alloc] initWithIsUseLeftAlignedFlowLayout:YES onTapEntity:^(TSPreviewModel * _Nonnull previewModel) {
                    NSString *message = [NSString stringWithFormat:@"点击了预览项: %@", previewModel.name];
                    [CJUIKitToastUtil showMessage:message];
                }];
                return tsView;
            };
            [sectionDataModel.values addObject:previewListModule];
        }
        {
            CQDMModuleModel *previewListModule = [[CQDMModuleModel alloc] init];
            previewListModule.title = @"Item的预览列表(使用系统有布局问题)";
            previewListModule.content = @"常用于外部不提供详情数据，而是用一整张预览图来展示\n重点:未解决某行数据不足时候排列会从一二位跑到头尾位置";
            previewListModule.contentLines = 2;
            previewListModule.viewGetterHandle = ^UIView * _Nonnull{
                UIView *tsView = [[TSPreviewView alloc] initWithIsUseLeftAlignedFlowLayout:NO onTapEntity:^(TSPreviewModel * _Nonnull previewModel) {
                    NSString *message = [NSString stringWithFormat:@"点击了预览项: %@", previewModel.name];
                    [CJUIKitToastUtil showMessage:message];
                }];
                return tsView;
            };
            [sectionDataModel.values addObject:previewListModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    // SwiftUI
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"SwiftUI";
        {
            CQDMModuleModel *previewListModule = [[CQDMModuleModel alloc] init];
            previewListModule.title = @"多行的滚动视图(SwiftUI)";
            previewListModule.content = @"每行4个，不够继续下一行\n视图高度自动适配";
            previewListModule.contentLines = 2;
            previewListModule.viewGetterHandle = ^UIView * _Nonnull{
//                UIView *tsView = [[TSTSUIView alloc] initWithIsUseLeftAlignedFlowLayout:NO onTapEntity:^(TSPreviewModel * _Nonnull previewModel) {
//                    NSString *message = [NSString stringWithFormat:@"点击了预览项: %@", previewModel.name];
//                    [CJUIKitToastUtil showMessage:message];
//                }];
                if (@available(iOS 14.0, *)) {
                    UIView *tsView = [[TSSwiftUIGridViewUIView alloc] initWithItemsPerRow:4 cellItemSpacing:20 cellWidth:70.0 rowHeight:70.0 maxRowCount:9999];
                    return tsView;
                } else {
                    // Fallback on earlier versions
                    return UIView.new;
                }
            };
            [sectionDataModel.values addObject:previewListModule];
        }
        {
            CQDMModuleModel *previewListModule = [[CQDMModuleModel alloc] init];
            previewListModule.title = @"多行的滚动视图(SwiftUI)";
            previewListModule.content = @"每行4个，不够继续下一行\n视图高度自动适配，最多2行";
            previewListModule.contentLines = 2;
            previewListModule.viewGetterHandle = ^UIView * _Nonnull{
                if (@available(iOS 14.0, *)) {
                    UIView *tsView = [[TSSwiftUIGridViewUIView alloc] initWithItemsPerRow:4 cellItemSpacing:20 cellWidth:70.0 rowHeight:70.0 maxRowCount:2];
                    return tsView;
                } else {
                    // Fallback on earlier versions
                    return UIView.new;
                }
            };
            [sectionDataModel.values addObject:previewListModule];
        }
        
        {
            CQDMModuleModel *previewListModule = [[CQDMModuleModel alloc] init];
            previewListModule.title = @"单行或者单列滚动的视图，且可额外设置头尾视图。(SwiftUI)";
            previewListModule.content = @"";
            previewListModule.contentLines = 2;
            previewListModule.viewGetterHandle = ^UIView * _Nonnull{
                if (@available(iOS 14.0, *)) {
                    UIView *tsView = [[TSTSUIView alloc] init];
                    return tsView;
                } else {
                    // Fallback on earlier versions
                    return UIView.new;
                }
            };
            [sectionDataModel.values addObject:previewListModule];
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
