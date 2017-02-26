//
//  PrivilegeCell.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/24.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "PrivilegeCell.h"

@implementation PrivilegeCell

+ (PrivilegeCell *)cellForTableView:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:@"PrivilegeCell" bundle:nil] forCellReuseIdentifier:@"privilegeCell"];
    PrivilegeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"privilegeCell"];
    if (!cell) {
        cell = [[PrivilegeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"privilegeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)refreshDataWith:(RechargeModel *)model
{
    [self.labName setText:model.name];
    if (model.couponType == 0) {
        [self.labContent setText:@"优惠劵"];
    }else{
        [self.labContent setText:@"停车券"];
    }
    if (model.status == 0) {
        [self.labStatus setText:@"未使用"];
    }else{
        [self.labStatus setText:@"已使用"];
    }
    [self.labAmount setText:model.amount];
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
