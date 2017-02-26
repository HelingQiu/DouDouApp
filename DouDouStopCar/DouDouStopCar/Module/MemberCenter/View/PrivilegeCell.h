//
//  PrivilegeCell.h
//  DouDouStopCar
//
//  Created by Rainer on 17/2/24.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParkingRecordModel.h"

@interface PrivilegeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labContent;
@property (weak, nonatomic) IBOutlet UILabel *labStatus;
@property (weak, nonatomic) IBOutlet UILabel *labAmount;

+ (PrivilegeCell *)cellForTableView:(UITableView *)tableView;
- (void)refreshDataWith:(RechargeModel *)model;

@end
