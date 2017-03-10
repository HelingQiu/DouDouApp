//
//  MonthCardCell.h
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/21.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParkingRecordModel.h"

typedef void(^ChargeBlock)();
@interface MonthCardCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labParkingName;
@property (weak, nonatomic) IBOutlet UILabel *labStatus;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UILabel *labPlatNum;
@property (nonatomic, copy) ChargeBlock block;

+ (MonthCardCell *)cellForTableView:(UITableView *)tableView;
- (void)refreshDataWith:(MonthCardModel *)model;

@end
