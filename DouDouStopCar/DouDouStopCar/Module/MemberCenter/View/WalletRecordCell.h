//
//  WalletRecordCell.h
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/26.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParkingRecordModel.h"

@interface WalletRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labAmount;
@property (weak, nonatomic) IBOutlet UILabel *labType;
@property (weak, nonatomic) IBOutlet UILabel *labTime;

+ (WalletRecordCell *)cellForTableView:(UITableView *)tableView;
- (void)refreshDataWith:(WalletRecordModel *)model;

@end
