//
//  TableViewMenuDataSource.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "TableViewMenuDataSource.h"

@implementation TableViewMenuDataSource

#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"第 %ld 组", section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    //设置cell被选中时背景颜色
    UIView *backgroundViews = [[UIView alloc]initWithFrame:cell.frame];
    backgroundViews.backgroundColor = [[UIColor systemPinkColor] colorWithAlphaComponent:0.8];
    [cell setSelectedBackgroundView:backgroundViews];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld组-第%ld行", indexPath.section, indexPath.row];
    
    return cell;
}

@end
