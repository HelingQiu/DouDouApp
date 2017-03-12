//
//  CitySelectView.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/3/8.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "CitySelectView.h"

@implementation CitySelectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/5 * 2, frame.size.height) style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.backgroundColor = [UIColor whiteColor];
        _leftTableView.tableFooterView = [UIView new];
        [self addSubview:_leftTableView];
        
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.size.width/5 * 2, 0, frame.size.width/5 * 3, frame.size.height) style:UITableViewStylePlain];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _rightTableView.tableFooterView = [UIView new];
        [self addSubview:_rightTableView];
    }
    return self;
}

- (void)refreshDataWith:(NSArray *)dataSource
{
    _cityArray = dataSource;
    _selectIndex = 0;
    [_leftTableView reloadData];
    [_rightTableView reloadData];
}

#pragma mark - 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _leftTableView) {
        return _cityArray.count;
    }
    NSArray *subArray = [[_cityArray objectAtIndex:_selectIndex] objectForKey:@"districts"];
    return subArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (tableView == _leftTableView) {
        NSString *provice = [[_cityArray objectAtIndex:indexPath.row] objectForKey:@"city"];
        [cell.textLabel setText:provice];
    }else{
        cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        NSArray *subArray = [[_cityArray objectAtIndex:_selectIndex] objectForKey:@"districts"];
        NSString *city = [[subArray objectAtIndex:indexPath.row] objectForKey:@"district"];
        [cell.textLabel setText:city];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == _leftTableView) {
        _selectIndex = indexPath.row;
        [_rightTableView reloadData];
    }else{
        NSArray *subArray = [[_cityArray objectAtIndex:_selectIndex] objectForKey:@"districts"];
        NSString *city = [[subArray objectAtIndex:indexPath.row] objectForKey:@"district"];
        if (self.block) {
            self.block(city);
        }
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
