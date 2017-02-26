//
//  StopCarCell.h
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/20.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParkingRecordModel.h"

@interface StopCarCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labPlate;
@property (weak, nonatomic) IBOutlet UIButton *privilegeButton;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UILabel *labPay;
@property (weak, nonatomic) IBOutlet UILabel *labOld;
@property (weak, nonatomic) IBOutlet UILabel *labNew;
@property (weak, nonatomic) IBOutlet UILabel *labInTime;
@property (weak, nonatomic) IBOutlet UIImageView *rightView;

+ (StopCarCell *)cellForTableView:(UITableView *)tableView;
- (void)refreshDataWith:(ParkingRecordModel *)model;

@end
