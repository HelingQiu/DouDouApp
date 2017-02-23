//
//  NearByParkingListCell.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/23.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "NearByParkingListCell.h"

@implementation NearByParkingListCell

+ (NearByParkingListCell *)cellForTableView:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:@"NearByParkingListCell" bundle:nil] forCellReuseIdentifier:@"nearbyCell"];
    NearByParkingListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nearbyCell"];
    if (!cell) {
        cell = [[NearByParkingListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"nearbyCell"];
    }
    return cell;
}

- (void)refreshWithData:(NearbyModel *)model
{
    [self.labTitle setText:model.name];
    [self.labAddress setText:model.address];
    [self.labDistance setText:model.total];
}

- (IBAction)navigationAction:(UIButton *)sender {
    if (self.block) {
        self.block();
    }
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
