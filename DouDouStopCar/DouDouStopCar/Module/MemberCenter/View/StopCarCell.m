//
//  StopCarCell.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/20.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "StopCarCell.h"

@implementation StopCarCell

+ (StopCarCell *)cellForTableView:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:@"StopCarCell" bundle:nil] forCellReuseIdentifier:@"stopCell"];
    StopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stopCell"];
    if (!cell) {
        cell = [[StopCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"stopCell"];
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
