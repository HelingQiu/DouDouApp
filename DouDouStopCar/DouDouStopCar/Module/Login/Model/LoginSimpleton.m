//
//  LoginSimpleton.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/25.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "LoginSimpleton.h"

@implementation LoginSimpleton

static LoginSimpleton *shareInstance = nil;


+ (LoginSimpleton *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        //判断是否登录
        [self isLogin];
    }
    return self;
}

/**
 *  判断是否已登录
 */
- (void)isLogin
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken]) {
        
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
        NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouPassWord];
        NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouUserId];
        self.user.token = token;
        self.user.password = password;
        self.user.userId = userId;
        if (![CommonUtils isBlankString:userId] && ![CommonUtils isBlankString:token]) {
            self.isLogined = YES;
        }else{
            self.isLogined = NO;
        }
    }else{
        self.isLogined = NO;
    }
}

@end
