//
//  ParkingRecordModel.h
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/25.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlateNumberModel;
@interface ParkingRecordModel : NSObject

@property (nonatomic, copy) NSString *parkingName;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *inDate;
@property (nonatomic, copy) NSString *outDate;
@property (nonatomic, assign) NSInteger payType;
@property (nonatomic, copy) NSString *plateNumber;

@end

@interface PlateNumberModel : NSObject

@property (nonatomic, copy) NSString *plateNumber;
@property (nonatomic, copy) NSString *area;

@end

@interface RechargeModel : NSObject

@property (nonatomic, assign) NSInteger couponType;//0 优惠券，1,停车卷
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, assign) NSInteger status;//0:未使用 1:已使用
@property (nonatomic, copy) NSString *url;

@end

@interface WalletRecordModel : NSObject

@property (nonatomic, assign) NSInteger consumeType;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *recordDate;

@end

@interface CollectionModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *parkingId;

@end

@interface MonthCardModel : NSObject

@property (nonatomic, copy) NSString *parkingName;
@property (nonatomic, copy) NSString *plateNumber;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, copy) NSString *price;

@end

@interface CashRecordModel : NSObject

@property (nonatomic, assign) NSInteger payType;
@property (nonatomic, copy) NSString *cash;
@property (nonatomic, copy) NSString *payName;
@property (nonatomic, copy) NSString *payAccount;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, assign) NSInteger state;

@end

@interface ApplyBillModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *cash;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, assign) NSInteger state;

@end




