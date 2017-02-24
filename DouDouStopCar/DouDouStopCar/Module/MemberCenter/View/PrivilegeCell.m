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
