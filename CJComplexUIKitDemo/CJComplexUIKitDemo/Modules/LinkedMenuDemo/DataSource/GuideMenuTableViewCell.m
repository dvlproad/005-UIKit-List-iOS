//
//  GuideMenuTableViewCell.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "GuideMenuTableViewCell.h"

@interface GuideMenuTableViewCell () {
    
}
@property (nonatomic, strong) UIView *guideLineView;   /**< cell的底部横线 */

@end


@implementation GuideMenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _showBottomLine = NO;
        [self setupViews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.layer.masksToBounds = YES;
    
    self.showBottomLine = selected;
    if (selected) {
        self.mainTitleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    } else {
        self.mainTitleLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    }
}

#pragma mark - Setter
/// 设置是否显示cell的底部横线
- (void)setShowBottomLine:(BOOL)showBottomLine {
    _showBottomLine = showBottomLine;
    self.guideLineView.hidden = !showBottomLine;
}

#pragma mark - SetupViews & Lazy
- (void)setupViews {
    // cell的边侧竖线
    [self.contentView addSubview:self.guideLineView];
    [self.guideLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.width.equalTo(@4);
        make.centerY.equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView).offset(10);
    }];
    
    // 图片
    [self.contentView addSubview:self.myImageView];
    [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.guideLineView.mas_right);
        make.right.equalTo(self.contentView).mas_offset(0);
        make.top.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
    }];
    
    // 主标题
    [self.contentView addSubview:self.mainTitleLabel];
    [self.mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.guideLineView.mas_right).mas_offset(14.0);
        make.right.equalTo(self.contentView).mas_offset(-14.0);
        make.top.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
    }];
}

/// 主标题
- (UILabel *)mainTitleLabel {
    if (_mainTitleLabel == nil) {
        _mainTitleLabel = [[UILabel alloc] init];
        //_mainTitleLabel.backgroundColor = [UIColor redColor];
        _mainTitleLabel.textAlignment = NSTextAlignmentLeft;
        _mainTitleLabel.font = [UIFont systemFontOfSize:13];
        _mainTitleLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    }
    return _mainTitleLabel;
}

/// 图片
- (UIImageView *)myImageView {
    if (_myImageView == nil) {
        _myImageView = [[UIImageView alloc] init];
    }
    return _myImageView;
}

/// cell的底部横线
- (UIView *)guideLineView {
    if (_guideLineView == nil) {
        _guideLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _guideLineView.layer.masksToBounds = YES;
        _guideLineView.layer.cornerRadius = 2;
        _guideLineView.backgroundColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    }
    return _guideLineView;
}

@end
