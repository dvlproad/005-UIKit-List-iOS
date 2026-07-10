//
//  DouyinUrlHomeViewController.m
//  TSListDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DouyinUrlHomeViewController.h"
#import <CQDemoKit/CJUIKitAlertUtil.h>
#import <TSDemo_Web_Swift/TSDemo_Web_Swift-Swift.h>

@interface DouyinUrlHomeViewController ()  {
    
}

@end

@implementation DouyinUrlHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"Web首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    
    
    // 抖音视频地址解析
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"利用 WebView 进行抖音视频地址解析";
        {
            CQDMModuleModel *videoUrlModule = [[CQDMModuleModel alloc] init];
            videoUrlModule.title = @"利用 WebView 进行抖音视频地址解析";
            videoUrlModule.actionBlock = ^{
                DouyinWebScraper *scraper = [[DouyinWebScraper alloc] initWithVideoURL:@"https://www.douyin.com/video/7414051930047106342"];
                [scraper fetchVideoDataWithCompletion:^(NSDictionary<NSString *,id> * _Nullable data) {
                    if (data == nil) {
                        NSLog(@"抖音视频数据获取失败");
                        return;
                    }
                    NSLog(@"抖音视频数据:%@", data);
                }];
            };
            [sectionDataModel.values addObject:videoUrlModule];
        }
        {
            CQDMModuleModel *videoUrlModule = [[CQDMModuleModel alloc] init];
            videoUrlModule.title = @"利用 WebView 进行抖音视频地址解析";
            videoUrlModule.actionBlock = ^{
                NSString *videoID = @"7414051930047106342";
                NSString *cookie = @"your_cookie_here";
                DouyinAPIClient *apiClient = [[DouyinAPIClient alloc] init];
                
                [apiClient fetchVideoDataWithVideoID:videoID cookie:cookie completion:^(NSString * _Nullable data) {
                    if (data == nil) {
                        NSLog(@"抖音视频数据获取失败");
                        return;
                    }
                    NSLog(@"抖音视频数据:%@", data);
                }];
            };
            [sectionDataModel.values addObject:videoUrlModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}

- (void)showIKnowAlertViewWithTitle:(NSString *)title {
    [CJUIKitAlertUtil showIKnowAlertInViewController:self withTitle:title iKnowBlock:nil];
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
