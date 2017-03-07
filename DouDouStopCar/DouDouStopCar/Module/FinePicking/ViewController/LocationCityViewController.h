//
//  LocationCityViewController.h
//  DouDouStopCar
//
//  Created by Rainer on 17/2/24.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "DouDouBaseViewController.h"

typedef void(^CityBlock)(NSString *city);
@interface LocationCityViewController : DouDouBaseViewController

@property (nonatomic, copy) NSString *locationCity;
@property (nonatomic, copy) CityBlock block;

@end
