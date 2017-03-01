//
//  RoadViewController.h
//  DouDouStopCar
//
//  Created by Rainer on 17/3/1.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "DouDouBaseViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface RoadViewController : DouDouBaseViewController
{
    BMKRouteSearch* _routesearch;
}
@property (nonatomic, assign) CLLocationCoordinate2D startPt;
@property (nonatomic, assign) CLLocationCoordinate2D endPt;

@end
