//
//  CJMoneyUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJDecimalUtil.h"

@interface CJMoneyUtil : NSObject

#pragma mark - "分" 转 "元"(向上取整)
///将分以保留0位小数的方式转为元
+ (NSString *)zeroUpDecimalPriceYuanStringFromPriceFen:(CGFloat)priceFen;

///将分以保留1位小数的方式转为元(向上取整)
+ (NSString *)oneUpDecimalPriceYuanStringFromPriceFen:(CGFloat)priceFen;
///将分以保留1位小数的方式转为元(向下取整)
+ (NSString *)oneDownDecimalPriceYuanStringFromPriceFen:(CGFloat)priceFen;


/**
 *  将分以保留几位小数的方式转为元（向上取整）
 *
 *  @param priceFen         分
 *  @param decimalCount     保留的小数位数
 *  @param decimalDealType  取整的方式
 *
 *  @return 字符串
 */
+ (NSString *)getPriceYuanStringFromPriceFen:(CGFloat)priceFen withDecimalCount:(NSInteger)decimalCount decimalDealType:(CJDecimalDealType)decimalDealType;


@end
