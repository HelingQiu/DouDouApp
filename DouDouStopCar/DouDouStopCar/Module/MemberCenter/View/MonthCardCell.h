//
//  MonthCardCell.h
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/21.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChargeBlock)();
@interface MonthCardCell : UITableViewCell

@property (nonatomic, copy) ChargeBlock block;
+ (MonthCardCell *)cellForTableView:(UITableView *)tableView;

@end
