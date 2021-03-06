//
//  IjinbuNetworkClient.h
//  IjinbuNetworkDemo
//
//  Created by ciyouzen on 2017/3/6.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IjinbuResponseModel.h"

#import "IjinbuSession.h"
#import "IjinbuUser.h"

//API路径--ijinbu
#define API_BASE_Url_ijinbu(_Url_) [[@"http://www.ijinbu.com/" stringByAppendingString:_Url_] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

@interface IjinbuNetworkClient : NSObject

+ (nullable IjinbuNetworkClient *)sharedInstance;

- (nullable NSURLSessionDataTask *)ijinbu_postUrl:(nullable NSString *)Url
                                           params:(nullable id)params
                                            cache:(BOOL)cache
                                    completeBlock:(nullable void (^)(IjinbuResponseModel * _Nullable responseModel))completeBlock;

@end
