//
//  ParkingDetailViewController.h
//  DouDouStopCar
//
//  Created by Rainer on 2017/3/2.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "DouDouBaseViewController.h"
#import "NearbyModel.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface ParkingDetailViewController : DouDouBaseViewController

@property (nonatomic, assign) CLLocationCoordinate2D startPt;
@property (nonatomic, strong) NearbyModel *model;

@end
