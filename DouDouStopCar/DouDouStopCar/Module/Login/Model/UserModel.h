//
//  UserModel.h
//  DouDouStopCar
//
//  Created by Rainer on 17/2/20.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic , copy) NSString *userId;
@property (nonatomic , copy) NSString *password;
@property (nonatomic , copy) NSString *token;
@property (nonatomic ,assign) BOOL isLogin;

+ (UserModel *)sharedInstance;
- (void)reset;

@end
