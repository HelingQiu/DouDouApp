//
//  UserModel.h
//  DouDouStopCar
//
//  Created by Rainer on 17/2/20.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic , strong) NSString *userId;
@property (nonatomic , strong) NSString *password;
@property (nonatomic , strong) NSString *token;
//@property (nonatomic ,assign) BOOL isLogin;

//+ (UserModel *)sharedInstance;
//- (void)reset;

@end
