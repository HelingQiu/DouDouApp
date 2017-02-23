//
//  NearByParkingListCell.h
//  DouDouStopCar
//
//  Created by Rainer on 17/2/23.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyModel.h"

typedef void(^NavigaAction)();
@interface NearByParkingListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;
@property (weak, nonatomic) IBOutlet UILabel *labDistance;

@property (nonatomic, copy) NavigaAction block;

+ (NearByParkingListCell *)cellForTableView:(UITableView *)tableView;

- (void)refreshWithData:(NearbyModel *)model;

@end
