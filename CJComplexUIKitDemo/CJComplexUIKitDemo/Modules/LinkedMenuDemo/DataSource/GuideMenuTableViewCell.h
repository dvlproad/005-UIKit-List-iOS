//
//  GuideMenuTableViewCell.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GuideMenuTableViewCell : UITableViewCell {
    
}
@property (nonatomic, strong) UILabel *mainTitleLabel;  /**< 主标题 */
@property (nonatomic, strong) UIImageView *myImageView; /**< 图片 */
@property (nonatomic, assign) BOOL showBottomLine;      /**< 是否显示cell的底部横线(默认YES) */


@end

NS_ASSUME_NONNULL_END
