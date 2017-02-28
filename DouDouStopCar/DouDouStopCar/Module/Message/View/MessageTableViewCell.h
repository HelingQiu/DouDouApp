//
//  MessageTableViewCell.h
//  DouDouStopCar
//
//  Created by Rainer on 17/2/19.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

typedef void(^ChargeBlock)();
@interface MessageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labTopTime;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labDate;
@property (weak, nonatomic) IBOutlet UILabel *labContent;
@property (weak, nonatomic) IBOutlet UILabel *labParkingName;
@property (weak, nonatomic) IBOutlet UILabel *labTime;

@property (copy, nonatomic) ChargeBlock block;

+ (MessageTableViewCell *)cellForTableView:(UITableView *)tableView;
- (void)refreshDataWith:(MessageModel *)model;

@end
