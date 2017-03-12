//
//  SearchParkingViewController.h
//  DouDouStopCar
//
//  Created by Rainer on 2017/3/7.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "DouDouBaseTableViewController.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "NearbyModel.h"

typedef void(^SearchBlock)(NearbyModel *model);
@interface SearchParkingViewController : DouDouBaseTableViewController

@property (nonatomic, copy) NSString *locationCity;
@property (nonatomic, assign) CLLocationCoordinate2D locationPt;

@property (nonatomic, copy) SearchBlock block;

@end
