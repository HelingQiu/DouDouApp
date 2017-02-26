//
//  CarNumberCell.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/21.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "CarNumberCell.h"

@implementation CarNumberCell

+ (CarNumberCell *)cellForTableView:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:@"CarNumberCell" bundle:nil] forCellReuseIdentifier:@"carnumberCell"];
    CarNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"carnumberCell"];
    if (!cell) {
        cell = [[CarNumberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"carnumberCell"];
    }
    return cell;
}

- (void)refreshDataWith:(PlateNumberModel *)model
{
    [self.labCarNumber setText:model.plateNumber];
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
