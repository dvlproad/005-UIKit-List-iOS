//
//  CJLinkedTableMenuView.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2020/3/26.
//  Copyright © 2020 dvlproad. All rights reserved.
//
//  请参考 CJLinkedCollectionMenuView.swift 的实现（实际上此类可废弃，用 CJLinkedCollectionMenuView.swift 即可)

#import "CJLinkedTableMenuView.h"


@interface CJLinkedTableMenuView ()<UITableViewDelegate>

@property (nonatomic, strong, readonly) UITableView *leftTableView;
@property (nonatomic, strong, readonly) UITableView *rightTableView;

@property (nonatomic, assign) BOOL click;

@property (nonatomic, assign) CGFloat leftWidth;
@property (nonatomic, weak) id<UITableViewDataSource> leftDataSource;
@property (nonatomic, weak) id<UITableViewDataSource> rightDataSource;

@end


@implementation CJLinkedTableMenuView

- (instancetype)initWithLeftWidth:(CGFloat)leftWidth
                   leftSetupBlock:(nullable void (^)(UITableView *leftTableView))leftSetupBlock
                   leftDataSource:(id<UITableViewDataSource>)leftDataSource
                  rightSetupBlock:(nullable void (^)(UITableView *rightTableView))rightSetupBlock
                  rightDataSource:(id<UITableViewDataSource>)rightDataSource
{
    self = [super init];
    if (self) {
        self.leftWidth = leftWidth;
        self.leftDataSource = leftDataSource;
        self.rightDataSource = rightDataSource;
        [self setupViews];
        
        self.leftTableView.dataSource = self.leftDataSource;
        self.rightTableView.dataSource = self.rightDataSource;
    }
    return self;
}


- (void)setupViews {
    _click = NO;
    
    UITableView *leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    leftTableView.delegate = self;
    //leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:leftTableView];
    _leftTableView = leftTableView;
    
    UITableView *rightTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    rightTableView.delegate = self;
    //rightTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:rightTableView];
    _rightTableView = rightTableView;
    
    // 约束左视图宽度为100
    leftTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [leftTableView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [leftTableView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [leftTableView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [leftTableView.widthAnchor constraintEqualToConstant:self.leftWidth]
    ]];
    
    // 约束右视图填充剩余空间
    rightTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [rightTableView.leadingAnchor constraintEqualToAnchor:leftTableView.trailingAnchor],
        [rightTableView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [rightTableView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [rightTableView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]
    ]];
    
}

#pragma mark - UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 如果是 左侧的 tableView 直接return
    if (scrollView == self.leftTableView) return;
    
    //如果是点击左边tableView产生的滑动，不进行左边tableView的移动操作(不然在右边row不够铺满table的时候会出现左侧table移动位置不准确的问题)
    if(!_click) {
        // 取出显示在 视图 且最靠上 的 cell 的 indexPath
        NSIndexPath *topVisibleIndexPath = [[self.rightTableView indexPathsForVisibleRows] firstObject];
        [_leftTableView reloadData];
        
        // 左侧 talbelView 移动的 indexPath ，移动 左侧 tableView 到 指定 indexPath 居中显示
        NSIndexPath *moveToIndexpath = [NSIndexPath indexPathForRow:topVisibleIndexPath.section inSection:0];
        [self.leftTableView selectRowAtIndexPath:moveToIndexpath
                                        animated:YES
                                  scrollPosition:UITableViewScrollPositionMiddle];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == self.leftTableView) return;
    _click = NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 选中 左侧 的 tableView
    if (tableView == self.leftTableView) {
        NSIndexPath *moveToIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        _click = YES;
        // 将右侧 tableView 移动到指定位置
        [self.rightTableView selectRowAtIndexPath:moveToIndexPath
                                         animated:YES
                                   scrollPosition:UITableViewScrollPositionTop];
        
        // 取消选中效果
        [self.rightTableView deselectRowAtIndexPath:moveToIndexPath animated:YES];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
