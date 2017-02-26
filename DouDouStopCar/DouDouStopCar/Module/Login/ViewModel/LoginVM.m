//
//  LoginVM.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/20.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "LoginVM.h"
#import "UserModel.h"

@implementation LoginVM

+ (void)loginWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [CommonUtils showHUDWithWaitingMessage:@"登录中"];
    [[DouDouNetworking sharedInstance] requestDataFromWSWithParams:parameter forPath:LoginApi isJson:YES isPrivate:NO isAuthorizationHeader:NO headerParamers:nil finished:^(NSDictionary *data) {
        NSLog(@"login data:%@",data);
        
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            NSString *userId = [parameter objectForKey:@"userId"];
            NSString *password = [parameter objectForKey:@"password"];
            NSString *token = [[data objectForKey:@"data"] objectForKey:@"token"]?:@"";
            
            [[NSUserDefaults standardUserDefaults] setObject:userId forKey:kDouDouUserId];
            [[NSUserDefaults standardUserDefaults] setObject:password forKey:kDouDouPassWord];
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:kDouDouToken];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(YES, [data objectForKey:@"resultMsg"]);
            
        }else{
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(NO, data);
        }
        
    } failed:^(NSString *error) {
        [CommonUtils changeHUDMessage:error];
        completion(NO, error);
    }];
}

+ (void)sendCodeWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [[DouDouNetworking sharedInstance] requestDataFromWSWithParams:parameter forPath:SendCodeApi isJson:YES isPrivate:NO isAuthorizationHeader:NO headerParamers:nil finished:^(NSDictionary *data) {
        NSLog(@"sendCode data:%@",data);
        
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(YES, [data objectForKey:@"resultMsg"]);
            
        }else{
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(NO, data);
        }
        
    } failed:^(NSString *error) {
        [CommonUtils changeHUDMessage:error];
        completion(NO, error);
    }];
}

+ (void)registWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [CommonUtils showHUDWithWaitingMessage:@"注册中"];
    [[DouDouNetworking sharedInstance] requestDataFromWSWithParams:parameter forPath:RegistApi isJson:YES isPrivate:NO isAuthorizationHeader:NO headerParamers:nil finished:^(NSDictionary *data) {
        NSLog(@"regist data:%@",data);
        
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(YES, [data objectForKey:@"resultMsg"]);
            
        }else{
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(NO, data);
        }
        
    } failed:^(NSString *error) {
        [CommonUtils changeHUDMessage:error];
        completion(NO, error);
    }];
}

+ (void)findPasswordWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [CommonUtils showHUDWithWaitingMessage:@"提交中"];
    [[DouDouNetworking sharedInstance] requestDataFromWSWithParams:parameter forPath:FinePasswordApi isJson:YES isPrivate:NO isAuthorizationHeader:NO headerParamers:nil finished:^(NSDictionary *data) {
        NSLog(@"find pw data:%@",data);
        
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(YES, [data objectForKey:@"resultMsg"]);
            
        }else{
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(NO, data);
        }
        
    } failed:^(NSString *error) {
        [CommonUtils changeHUDMessage:error];
        completion(NO, error);
    }];
}

@end
