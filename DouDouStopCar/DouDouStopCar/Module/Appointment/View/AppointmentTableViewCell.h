//
//  AppointmentTableViewCell.h
//  DouDouStopCar
//
//  Created by Rainer on 2017/3/2.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyModel.h"

@interface AppointmentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *labParkingName;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;
@property (weak, nonatomic) IBOutlet UILabel *labAvaiable;
@property (weak, nonatomic) IBOutlet UILabel *labDistance;

+ (AppointmentTableViewCell *)cellForTableView:(UITableView *)tableView;

- (void)refreshDataWith:(NearbyModel *)model;

@end
