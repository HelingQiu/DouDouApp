//
//  CollectionCell.h
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/20.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyModel.h"

typedef void(^CollectBlock)();
@interface CollectionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;
@property (weak, nonatomic) IBOutlet UIImageView *collectView;
@property (copy, nonatomic) CollectBlock block;

+ (CollectionCell *)cellForTableView:(UITableView *)tableView;
- (void)refreshDataWith:(NearbyModel *)model;

@end
