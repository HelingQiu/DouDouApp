//
//  FindParkingVM.h
//  DouDouStopCar
//
//  Created by Rainer on 17/2/23.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindParkingVM : NSObject

+ (void)getNearByParkingWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

//获取城市数据
+ (void)getCityDataWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

@end
