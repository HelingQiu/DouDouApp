//
//  CarNumberCell.h
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/21.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParkingRecordModel.h"

@interface CarNumberCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labCarNumber;
+ (CarNumberCell *)cellForTableView:(UITableView *)tableView;
- (void)refreshDataWith:(PlateNumberModel *)model;

@end
