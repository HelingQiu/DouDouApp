//
//  AppWebServiceUrl.h
//  DouDouStopCar
//
//  Created by Rainer on 17/2/20.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#ifndef AppWebServiceUrl_h
#define AppWebServiceUrl_h

//服务器地址
#define Host @"http://120.76.242.66:8080/DouDouService"

//接口地址

/*登录
 userId:
 用户名
 password:
 登录密码
 deviceType:
 登录类型：1.手机登录 2.微信登录
 deviceType:
 设备类型：1安卓，2苹果
 */
#define LoginApi [NSString stringWithFormat:@"%@%@",Host,@"/user/login"]

/*验证码
 mobile:
 required
 
 手机号
 */
#define SendCodeApi [NSString stringWithFormat:@"%@%@",Host,@"/user/sendCode"]

/*注册
 userId:
 用户名
 checkCode:
 验证码
 password:
 登录密码
 */
#define RegistApi [NSString stringWithFormat:@"%@%@",Host,@"/user/register"]

/*忘记密码
 userId:
 用户名
 checkCode:
 验证码
 newPassword:
 新密码
 */
#define FinePasswordApi [NSString stringWithFormat:@"%@%@",Host,@"/user/findPassword"]

/*
 获取广告图
 */
#define GetAdsApi [NSString stringWithFormat:@"%@%@",Host,@"/ad/adList"]

/*
 附近停车场
 */
#define GetNearParkingApi [NSString stringWithFormat:@"%@%@",Host,@"/parking/nearbyParking"]

/*
 个人信息
 */
#define GetPersonInfoApi [NSString stringWithFormat:@"%@%@",Host,@"/my/personInfo"]

/*
 停车记录
 */
#define GetParkingRecordApi [NSString stringWithFormat:@"%@%@",Host,@"/my/parkingRecordList"]

/*
 获取绑定车辆
 */
#define GetCarListApi [NSString stringWithFormat:@"%@%@",Host,@"/car/carList"]

/*
 添加车牌
 */
#define AddCarApi [NSString stringWithFormat:@"%@%@",Host,@"/car/addCar"]

/*
 获取优惠劵列表
 */
#define GetRechargeApi [NSString stringWithFormat:@"%@%@",Host,@"/conpon/recharge"]

/*
 消费明细
 */
#define GetWalletRecordApi [NSString stringWithFormat:@"%@%@",Host,@"/my/myWallet"]

/*
 充值
 */
#define RechargeApi [NSString stringWithFormat:@"%@%@",Host,@"/wallet/recharge"]

/*
 提现
 */
#define DepositApi [NSString stringWithFormat:@"%@%@",Host,@"/wallet/recharge"]

/*
 获取我的收藏列表
 */
#define GetMyCollectionApi [NSString stringWithFormat:@"%@%@",Host,@"/my/getMyCollection"]

/*
 添加收藏
 */
#define AddMyCollectionApi [NSString stringWithFormat:@"%@%@",Host,@"/my/addMyCollection"]

/*
 取消收藏
 */
#define DeleteMyCollectionApi [NSString stringWithFormat:@"%@%@",Host,@"/my/deleteMyCollection"]













#endif /* AppWebServiceUrl_h */
