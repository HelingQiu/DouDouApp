//
//  LoginSimpleton.h
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/25.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface LoginSimpleton : NSObject

/**
 *  Description:是否已登录
 */
@property (nonatomic , assign) BOOL isLogined;

/**
 *  Description:用户数据
 */
@property (nonatomic , strong) UserModel *user;

+ (LoginSimpleton *)shareInstance;

@end
