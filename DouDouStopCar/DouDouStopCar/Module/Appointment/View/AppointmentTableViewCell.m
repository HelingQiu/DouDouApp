//
//  AppointmentTableViewCell.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/3/2.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "AppointmentTableViewCell.h"

@implementation AppointmentTableViewCell

+ (AppointmentTableViewCell *)cellForTableView:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:@"AppointmentTableViewCell" bundle:nil] forCellReuseIdentifier:@"appointCell"];
    AppointmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"appointCell"];
    if (!cell) {
        cell = [[AppointmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"appointCell"];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
