//
//  UserModel.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/20.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

static UserModel *sharedInstance = nil;
static NSString *userIdKey = @"userId";
static NSString *tokenKey = @"token";
static NSString *passwordKey = @"password";

+ (UserModel *)sharedInstance {
    
    if (sharedInstance == nil) {
        sharedInstance = [[UserModel alloc] init];
    }
    
    return sharedInstance;
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    UserModel *instance = [UserModel sharedInstance];
    
    [instance setUserId:[aDecoder decodeObjectForKey:userIdKey]];
    [instance setToken:[aDecoder decodeObjectForKey:tokenKey]];
    [instance setPassword:[aDecoder decodeObjectForKey:passwordKey]];
    
    return instance;
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    // Archive the singleton instance
    UserModel *instance = [UserModel sharedInstance];
    
    [aCoder encodeObject:instance.userId forKey:userIdKey];
    [aCoder encodeObject:instance.token forKey:tokenKey];
    [aCoder encodeObject:instance.password forKey:passwordKey];
    
}

- (void)reset
{
    self.userId = @"";
    self.password = @"";
    self.token = @"";
    self.isLogin = NO;
}

@end
