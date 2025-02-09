//
//  CollectionMenuDataSource.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionMenuDataSource : NSObject<UICollectionViewDataSource>

//- (instancetype)init


- (void)registerAllCellsForCollectionView:(UICollectionView *)collectionView;

@end

NS_ASSUME_NONNULL_END
