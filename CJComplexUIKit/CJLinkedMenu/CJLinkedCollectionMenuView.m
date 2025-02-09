//
//  CJLinkedCollectionMenuView.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2020/3/26.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJLinkedCollectionMenuView.h"


@interface CJLinkedCollectionMenuView ()<UICollectionViewDelegate>

@property (nonatomic, strong, readonly) UITableView *leftTableView;
@property (nonatomic, strong, readonly) UICollectionView *rightCollectionView;

@property (nonatomic, assign) BOOL click;

@property (nonatomic, assign) CGFloat leftWidth;
@property (nonatomic, weak) id<UITableViewDataSource> leftDataSource;
@property (nonatomic, weak) id<UICollectionViewDataSource> rightDataSource;
//@property (nonatomic, weak) UICollectionViewLayout *rightCollectionViewLayout;
@property (nonatomic, copy) void (^rightCollectionViewSetupBlock)(UICollectionView *rightCollectionView);


@end


@implementation CJLinkedCollectionMenuView

- (instancetype)initWithLeftWidth:(CGFloat)leftWidth
                   leftSetupBlock:(nullable void (^)(UITableView *leftTableView))leftSetupBlock
                   leftDataSource:(id<UITableViewDataSource>)leftDataSource
                  rightSetupBlock:(nonnull void (^)(UICollectionView *rightCollectionView))rightSetupBlock
                  rightDataSource:(id<UICollectionViewDataSource>)rightDataSource
{
    self = [super init];
    if (self) {
        self.leftWidth = leftWidth;
        self.leftDataSource = leftDataSource;
        self.rightDataSource = rightDataSource;
        self.rightCollectionViewSetupBlock = rightSetupBlock;
        [self setupViews];
        
        self.leftTableView.dataSource = self.leftDataSource;
        self.rightCollectionView.dataSource = self.rightDataSource;
        self.rightCollectionView.delegate = self;
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
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *rightCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.rightCollectionViewSetupBlock(rightCollectionView);
    rightCollectionView.delegate = self;
    //rightCollectionView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //rightCollectionView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:rightCollectionView];
    _rightCollectionView = rightCollectionView;
    
    // 约束左视图宽度为100
    leftTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [leftTableView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [leftTableView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [leftTableView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [leftTableView.widthAnchor constraintEqualToConstant:self.leftWidth]
    ]];
    
    // 约束右视图填充剩余空间
    rightCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [rightCollectionView.leadingAnchor constraintEqualToAnchor:leftTableView.trailingAnchor],
        [rightCollectionView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [rightCollectionView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [rightCollectionView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]
    ]];
    
}

#pragma mark - UICollectionViewDelegate
////“点到”item时候执行的时间(allowsMultipleSelection为默认的NO的时候，只有选中，而为YES的时候有选中和取消选中两种操作)
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - UICollectionViewDelegateFlowLayout
// 此部分已在父类中实现
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 40, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat collectionViewCellWidth = 0;
    CGFloat collectionViewCellHeight = 0;
    
    NSInteger perRowMaxColumnCount = 4;
    
    UIEdgeInsets sectionInset = [self collectionView:collectionView
                                              layout:collectionViewLayout
                              insetForSectionAtIndex:indexPath.section];
    CGFloat columnSpacing = [self collectionView:collectionView
                                          layout:collectionViewLayout
        minimumInteritemSpacingForSectionAtIndex:indexPath.section];
    
    CGFloat width = CGRectGetWidth(collectionView.frame);
    CGFloat validWith = width - sectionInset.left - sectionInset.right - columnSpacing*(perRowMaxColumnCount-1);
    collectionViewCellWidth = floorf(validWith/perRowMaxColumnCount);
    collectionViewCellHeight = collectionViewCellWidth;
    
    
    return CGSizeMake(collectionViewCellWidth, collectionViewCellHeight);
}



#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 如果是 左侧的 tableView 直接return
    if (scrollView == self.leftTableView) return;
    
    //如果是点击左边tableView产生的滑动，不进行左边tableView的移动操作(不然在右边row不够铺满table的时候会出现左侧table移动位置不准确的问题)
    if(!_click) {
        // 取出显示在 视图 且最靠上 的 cell 的 indexPath
//        NSIndexPath *topVisibleIndexPath = [[self.rightCollectionView indexPathsForVisibleItems] firstObject];
//        [_leftTableView reloadData];
        
        // 获取当前可见的 Cell， 并在其中获取最靠上的 `indexPath`
        NSArray *visibleCells = [self.rightCollectionView indexPathsForVisibleItems];
        if (visibleCells.count == 0) return;
        NSIndexPath *topVisibleIndexPath = [[visibleCells sortedArrayUsingComparator:^NSComparisonResult(NSIndexPath *obj1, NSIndexPath *obj2) {
            return obj1.section > obj2.section;
        }] firstObject];
        
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
        // 将右侧 collection 移动到指定位置
        [self.rightCollectionView scrollToItemAtIndexPath:moveToIndexPath
                                                 atScrollPosition:UICollectionViewScrollPositionTop
                                                         animated:YES];
        
        // 取消选中效果
        [self.rightCollectionView deselectItemAtIndexPath:moveToIndexPath animated:YES];
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
