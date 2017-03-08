//
//  CitySelectView.h
//  DouDouStopCar
//
//  Created by Rainer on 2017/3/8.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CityBlock)(NSString *city);
@interface CitySelectView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_leftTableView;
    UITableView *_rightTableView;
    NSArray *_cityArray;
    NSInteger _selectIndex;
}
@property (nonatomic, copy) CityBlock block;

- (void)refreshDataWith:(NSArray *)dataSource;

@end
