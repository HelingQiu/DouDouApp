//
//  MemberCenterVM.h
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/24.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberCenterVM : NSObject

//个人信息
+ (void)getPersonInfoWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

//停车记录
+ (void)getParkingRecordWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

//获取绑定车辆
+ (void)getCarListWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

//添加车牌
+ (void)addCarNumberWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

//获取优惠劵
+ (void)getRechargeListWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

//获取消费明细
+ (void)getWalletRecordWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

@end
