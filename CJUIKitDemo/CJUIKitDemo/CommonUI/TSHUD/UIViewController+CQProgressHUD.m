//
//  UIViewController+CQProgressHUD.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/11/1.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "UIViewController+CQProgressHUD.h"
#import <objc/runtime.h>
#import <CJBaseOverlayKit/UIViewController+CJProgressHUD.h>
#import <CJBaseOverlayKit/UIViewController+CJChrysanthemumHUD.h>


@interface UIViewController () {
    
}

@end

@implementation UIViewController (CQProgressHUD)

/// 显示HUD
- (void)cq_showProgressHUD {
    NSString *animationNamed = @"loading_tea";
    [self cj_showProgressHUDWithAnimationNamed:animationNamed];
}

/// 隐藏HUD
- (void)cq_dismissProgressHUD {
    [self cj_dismissProgressHUD];
}

/// 上传过程中显示开始上传的进度提示
- (void)cjdemo_showStartProgressMessage:(NSString * _Nullable)startProgressMessage {
    [self cj_showChrysanthemumHUDWithMessage:startProgressMessage animated:YES];
}

/// 上传过程中显示正在上传的进度提示
- (void)cjdemo_showProgressingMessage:(NSString *)progressingMessage {
    [self cj_updateChrysanthemumHUDWithMessage:progressingMessage];
}

/// 上传过程中显示结束上传的进度提示
- (void)cjdemo_showEndProgressMessage:(NSString *)endProgressMessage isSuccess:(BOOL)isSuccess {
    [self cj_updateChrysanthemumHUDWithMessage:endProgressMessage];
    if (isSuccess) {
        [self cj_hideChrysanthemumHUDWithAnimated:YES afterDelay:0.35];
    } else {
        [self cj_hideChrysanthemumHUDWithAnimated:YES afterDelay:1];
    }
}

@end
