//
//  LoginVM.h
//  DouDouStopCar
//
//  Created by Rainer on 17/2/20.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginVM : NSObject

//登录
+ (void)loginWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

//发送验证码
+ (void)sendCodeWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

//注册
+ (void)registWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

//忘记密码
+ (void)findPasswordWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

@end
