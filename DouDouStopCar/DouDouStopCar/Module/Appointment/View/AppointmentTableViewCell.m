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

- (void)refreshDataWith:(NearbyModel *)model
{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.img_url] placeholderImage:nil];
    [self.labParkingName setText:model.name];
    [self.labPrice setText:[NSString stringWithFormat:@"参考价格：%@元/小时",model.referencePrice]];
    [self.labAddress setText:model.address];
    [self.labAvaiable setText:model.available];
    [self.labDistance setText:[NSString stringWithFormat:@"%.2fkm",model.distance.doubleValue]];
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
