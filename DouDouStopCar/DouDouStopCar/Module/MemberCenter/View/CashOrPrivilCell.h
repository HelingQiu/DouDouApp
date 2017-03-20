//
//  CashOrPrivilCell.h
//  DouDouStopCar
//
//  Created by Rainer on 17/3/20.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParkingRecordModel.h"
@interface CashOrPrivilCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UILabel *labAmount;
@property (weak, nonatomic) IBOutlet UILabel *labStatus;

+ (CashOrPrivilCell *)cellForTableView:(UITableView *)tableView;
- (void)refreshDataWith:(CashRecordModel *)model;
- (void)refreshBillDataWith:(ApplyBillModel *)model;

@end
