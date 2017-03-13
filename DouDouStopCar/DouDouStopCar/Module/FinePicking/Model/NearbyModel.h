//
//  NearbyModel.h
//  DouDouStopCar
//
//  Created by Rainer on 17/2/23.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearbyModel : NSObject

@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *charge;
@property (nonatomic, copy) NSString *charge_desc;
@property (nonatomic, copy) NSString *charge_simple_desc;
@property (nonatomic, copy) NSString *month_card;
@property (nonatomic, copy) NSString *street_view;
@property (nonatomic, copy) NSString *available;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *book;
@property (nonatomic, copy) NSString *first_price;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *img_url;
@property (nonatomic, assign) NSInteger isCollection;
@property (nonatomic, copy) NSString *referencePrice;
@property (nonatomic, copy) NSString *priceRole;

@end
