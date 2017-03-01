//
//  MapCarParkingCell.h
//  DouDouStopCar
//
//  Created by Rainer on 17/2/22.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyModel.h"

typedef void(^PressBlock)(NearbyModel *model);
@interface MapCarParkingCell : UITableViewCell
{
    NearbyModel *nearbyModel;
}
@property (weak, nonatomic) IBOutlet UILabel *labParkingName;
@property (weak, nonatomic) IBOutlet UILabel *labDistance;
@property (weak, nonatomic) IBOutlet UILabel *labCarNum;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;

@property (copy, nonatomic) PressBlock roadBlock;
@property (copy, nonatomic) PressBlock dirBlock;

+ (instancetype)createByNibFile;
- (void)refreshDataWith:(NearbyModel *)model;

@end
