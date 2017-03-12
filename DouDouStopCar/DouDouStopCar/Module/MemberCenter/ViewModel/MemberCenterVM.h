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

/*
 获取消费明细
 */
+ (void)getWalletRecordWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

/*
 充值
 */
+ (void)rechargeListWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

//申请提现
+ (void)depositWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

//获取我的收藏列表
+ (void)getMyCollectionListWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

//取消收藏
+ (void)deleteMyCollectionListWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

//获取我的月卡数据
+ (void)getMonthCardListWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

//意见反馈
+ (void)feedbackWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

//获取规则信息
+ (void)getRoleInfoWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

@end
