//
//  MapCarParkingCell.h
//  DouDouStopCar
//
//  Created by Rainer on 17/2/22.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapCarParkingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labParkingName;
@property (weak, nonatomic) IBOutlet UILabel *labDistance;
@property (weak, nonatomic) IBOutlet UILabel *labCarNum;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;


+ (instancetype)createByNibFile;

@end
