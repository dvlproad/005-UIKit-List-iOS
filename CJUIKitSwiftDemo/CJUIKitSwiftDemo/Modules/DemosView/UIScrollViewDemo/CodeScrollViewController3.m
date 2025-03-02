//
//  CodeScrollViewController3.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CodeScrollViewController3.h"

@interface CodeScrollViewController3 () {
    
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;

@end

@implementation CodeScrollViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"ScrollView(纯代码创建)", nil);
    self.view.backgroundColor = CJColorFromHexString(@"#f2f2f2");
    
    UIView *scrollSuperView1 = [[UIView alloc] init];
    [self.view addSubview:scrollSuperView1];
    [scrollSuperView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(140);
        make.height.mas_equalTo(200);
    }];
    self.scrollSuperView1 = scrollSuperView1;
    
    
    UIView *scrollSuperView2 = [[UIView alloc] init];
    [self.view addSubview:scrollSuperView2];
    [scrollSuperView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(scrollSuperView1.mas_bottom).mas_offset(40);
        make.height.mas_equalTo(200);
    }];
    self.scrollSuperView2 = scrollSuperView2;
    
    [self setupScrollView];
}

- (void)setupScrollView {
    [self setupView1];
    [self setupView2];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2秒后异步执行这里的代码...
        [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.scrollSuperView1).mas_offset(20);
            make.bottom.mas_equalTo(self.scrollSuperView1).mas_offset(-20);
        }];
    });
}

- (void)setupView1 {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor redColor];
    [self.scrollSuperView1 addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.scrollSuperView1);
    }];
    self.scrollView = scrollView;
    
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor greenColor];
    [scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(scrollView);
        make.top.bottom.mas_equalTo(scrollView);
        make.width.mas_equalTo(scrollView.mas_width);
        make.height.mas_equalTo(scrollView.mas_height).mas_offset(1);
    }];
    self.containerView = containerView;
}

- (void)setupView2 {
    /* Masonry设置uiscrollview的contentsize */
    UIScrollView *pageScrollView = [[UIScrollView alloc] init];
    pageScrollView.pagingEnabled = YES;
    pageScrollView.backgroundColor = [UIColor redColor];
    [self.scrollSuperView2 addSubview:pageScrollView];
    [pageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.scrollSuperView2);
    }];
    
    
    UIView *pageContainerView = [[UIView alloc] init];
    pageContainerView.backgroundColor = [UIColor greenColor];
    [pageScrollView addSubview:pageContainerView];
    [pageContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(pageScrollView);
        make.top.bottom.mas_equalTo(pageScrollView);
        make.width.mas_equalTo(pageScrollView.mas_width).multipliedBy(3).mas_offset(0);
        make.height.mas_equalTo(pageScrollView.mas_height);
    }];
    
    
    
    UIView *lastViewAddInScrollView = nil;
    
    NSInteger pageCount = 3;
    for (NSInteger i = 0; i < pageCount; i++) {
        UIView *pageView = [[UIView alloc] init];
        pageView.backgroundColor = CJColorRandom;
        [pageContainerView addSubview:pageView];
        
        [pageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(pageScrollView);
            make.width.mas_equalTo(pageScrollView.mas_width);
            
            if (lastViewAddInScrollView) {
                make.left.mas_equalTo(lastViewAddInScrollView.mas_right).mas_offset(0);
            } else {
                make.left.mas_equalTo(pageScrollView);
            }
            
        }];
        
        lastViewAddInScrollView = pageView;
    }
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
