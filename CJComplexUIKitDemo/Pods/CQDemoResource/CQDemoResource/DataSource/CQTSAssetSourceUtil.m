//
//  CQTSAssetSourceUtil.m
//  CQDemoResource
//
//  Created by ciyouzen on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTSAssetSourceUtil.h"
#import <CQDemoKit/CQTSGitUtil.h>   // 在 subspec:Demo_Resource 下

@implementation CQTSAssetSourceUtil

#pragma mark 资源文件名 / 资源文件Url
+ (NSArray<NSString *> *)localFileNames:(NSArray<NSString *> *)folderNames {
    NSArray *resultDictionarys = [CQTSAssetSourceUtil assetDictsWithFolderNames:folderNames];
    
    // 创建可变数组存放结果
    NSMutableArray<NSString *> *resultImagesNames = [NSMutableArray array];
    for (NSDictionary *resultDictionary in resultDictionarys) {
        NSString *imageName = resultDictionary[@"assetName"];
        if (imageName && imageName.length > 0) {
            [resultImagesNames addObject:imageName];
        }
    }
    return resultImagesNames;
}

/// 我自己 github 上的 资源图片
+ (NSArray<NSString *> *)networkFileUrls:(NSArray<NSString *> *)folderNames {
    NSString *githubUrl = @"https://github.com/dvlproad/001-UIKit-CQDemo-iOS/blob/master/CQDemoResource/Resources";
    
    NSArray *resultDictionarys = [CQTSAssetSourceUtil assetDictsWithFolderNames:folderNames];
    
    // 创建可变数组存放结果
    NSMutableArray<NSString *> *imageUrls_github = [NSMutableArray array];
    for (NSDictionary *resultDictionary in resultDictionarys) {
        NSString *folderName = resultDictionary[@"folderName"];
        NSString *imageName = resultDictionary[@"assetName"];
        NSString *fullUrl = [CQTSGitUtil githubAssetUrlFromBaseUrl:githubUrl
                                                        folderName:folderName
                                                         imageName:imageName];
        [imageUrls_github addObject:fullUrl];
    }
    return imageUrls_github;
}

+ (NSArray<NSDictionary *> *)assetDictsWithFolderNames:(NSArray<NSString *> *)folderNames {
    NSMutableArray *resultDictionarys = [[NSMutableArray alloc] init];
    if ([folderNames containsObject:@"jpg"]) {
        NSArray *sourceImageNames = @[
            @"cqts_1.jpg",
            @"cqts_2.jpg",
            @"cqts_3.jpg",
            @"cqts_4.jpg",
            @"cqts_5.jpg",
            @"cqts_6.jpg",
            @"cqts_7.jpg",
            @"cqts_8.jpg",
            @"cqts_9.jpg",
            @"cqts_10.jpg",
            @"cqts_long_horizontal_1.jpg",
            @"cqts_long_vertical_1.jpg",
            @"cqts_bgCar.jpg",
            @"cqts_bgSky.jpg",
        ];
        for (NSString *sourceImageName in sourceImageNames) {
            NSDictionary *dict = @{
                @"folderName": @"jpg",
                @"assetName": sourceImageName
            };
            [resultDictionarys addObject:dict];
        }
    }
    
    if ([folderNames containsObject:@"jpg_big"]) {
        NSArray *sourceImageNames = @[
            @"cqts_big_15M.jpg",
            @"cqts_big_22M.jpg",
        ];
        for (NSString *sourceImageName in sourceImageNames) {
            NSDictionary *dict = @{
                @"folderName": @"jpg_big",
                @"assetName": sourceImageName
            };
            [resultDictionarys addObject:dict];
        }
    }
    
    if ([folderNames containsObject:@"gif"]) {
        NSArray *sourceImageNames = @[
            @"cqts_01.gif",
            @"cqts_02.gif",
            @"cqts_03.gif",
            @"cqts_04.gif",
        ];
        for (NSString *sourceImageName in sourceImageNames) {
            NSDictionary *dict = @{
                @"folderName": @"GIF",
                @"assetName": sourceImageName
            };
            [resultDictionarys addObject:dict];
        }
    }
    
    if ([folderNames containsObject:@"webp"]) {
        NSArray *sourceImageNames = @[
            @"cqts_wp_1.webp",
        ];
        for (NSString *sourceImageName in sourceImageNames) {
            NSDictionary *dict = @{
                @"folderName": @"webp",
                @"assetName": sourceImageName
            };
            [resultDictionarys addObject:dict];
        }
    }
    
    if ([folderNames containsObject:@"svg"]) {
        NSArray *sourceImageNames = @[
            @"cqts_normal_svg_01.svg",
            @"cqts_normal_svg_02.svg",
            @"cqts_normal_animation_svg_01.svg",
            @"cqts_symbol_svg_01.svg",              // symbol 图标
        ];
        for (NSString *sourceImageName in sourceImageNames) {
            NSDictionary *dict = @{
                @"folderName": @"SVG",
                @"assetName": sourceImageName
            };
            [resultDictionarys addObject:dict];
        }
    }
    /*
    if ([folderNames containsObject:@"mp3"]) {
        NSArray *sourceImageNames = @[
//            @"cqts_normal_audio_01.mp3",
//            @"cqts_normal_audio_02.mp3",
        ];
        for (NSString *sourceImageName in sourceImageNames) {
            NSDictionary *dict = @{
                @"folderName": @"mp3",
                @"assetName": sourceImageName
            };
            [resultDictionarys addObject:dict];
        }
    }
    */
    if ([folderNames containsObject:@"mp4"]) {
        NSArray *sourceImageNames = @[
            @"cqts_normal_video_01.mp4",
            @"cqts_vap_01.mp4",
            @"cqts_wallpaper_01.mp4",
        ];
        for (NSString *sourceImageName in sourceImageNames) {
            NSDictionary *dict = @{
                @"folderName": @"mp4",
                @"assetName": sourceImageName
            };
            [resultDictionarys addObject:dict];
        }
    }
    
    
    return resultDictionarys;
}

#pragma mark Icon资源文件 Url
/// 所有的网络测试icon图片地址
+ (NSArray<NSString *> *)iconUrls {
    NSArray<NSString *> *imageUrls = @[
        #pragma mark 以下网络图片从 https://image.baidu.com 中获取
        @"https://img2.baidu.com/it/u=248809548,2992510422&fm=253&fmt=auto&app=138&f=PNG?w=500&h=500",
        @"https://img0.baidu.com/it/u=3087067444,242345469&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500",
        @"https://img0.baidu.com/it/u=2142566046,3495686177&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500",
        @"https://img2.baidu.com/it/u=3935222850,2993881202&fm=253&fmt=auto&app=138&f=JPEG?w=707&h=500",
        @"https://img1.baidu.com/it/u=1110022854,3922459600&fm=253&fmt=auto&app=138&f=PNG?w=500&h=500",
        @"https://img0.baidu.com/it/u=2618490059,1120160608&fm=253&fmt=auto&app=138&f=JPEG?w=560&h=500",
    ];
    return imageUrls;
}

@end
