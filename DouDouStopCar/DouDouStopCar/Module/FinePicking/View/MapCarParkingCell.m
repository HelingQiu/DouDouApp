//
//  MapCarParkingCell.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/22.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "MapCarParkingCell.h"

@implementation MapCarParkingCell

+ (instancetype)createByNibFile
{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"MapCarParkingCell" owner:nil options:nil];
    MapCarParkingCell *cell = [nibContents firstObject];
    return cell;
}

- (IBAction)roadAction:(UIButton *)sender {
    if (self.roadBlock) {
        self.roadBlock(nearbyModel);
    }
}

- (IBAction)directAction:(UIButton *)sender {
    if (self.dirBlock) {
        self.dirBlock(nearbyModel);
    }
}

- (void)refreshDataWith:(NearbyModel *)model
{
    nearbyModel = model;
    [self.labParkingName setText:model.name];
    [self.labParkingName setText:model.street_view];
    [self.labCarNum setText:[NSString stringWithFormat:@"空车位：%@",model.available]];
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
