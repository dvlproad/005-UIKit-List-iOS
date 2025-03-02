//
//  CJBaseOverlayThemeManager.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJBaseOverlayThemeManager.h"

@implementation CJBaseOverlayThemeManager

+ (CJBaseOverlayThemeManager *)sharedInstance {
    static CJBaseOverlayThemeManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _serviceThemeModel = [[CJBaseOverlayThemeModel alloc] init];
    }
    return self;
}

/**
 *  获取当前正在使用的主题
 *
 *  @return serviceThemeModel
 */
+ (CJBaseOverlayThemeModel *)serviceThemeModel {
    return [CJBaseOverlayThemeManager sharedInstance].serviceThemeModel;
}


///**
// *  获取overlay当前公共的themeModel
// *
// *  @return overlay当前公共的themeModel
// */
//+ (CJOverlayCommonThemeModel *)serviceOverlayCommonThemeModel {
//    return [CJBaseOverlayThemeManager sharedInstance].serviceThemeModel.commonThemeModel;
//}

@end
