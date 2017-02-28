//
//  MessageVM.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/28.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "MessageVM.h"
#import "MessageModel.h"

@implementation MessageVM

+ (void)getMessageListWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    NSDictionary *params = @{@"token":token?:@""};
    [[DouDouNetworking sharedInstance] requestDataFromWSWithParams:parameter forPath:GetMessageListApi isJson:YES isPrivate:NO isAuthorizationHeader:YES headerParamers:params finished:^(NSDictionary *data) {
        NSLog(@"message list :%@",data);
        [CommonUtils hideHUD];
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            NSArray *dataArray = [[data objectForKey:@"data"] objectForKey:@"list"];
            NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
            [dataArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MessageModel *model = [MessageModel mj_objectWithKeyValues:obj];
                [resultArray addObject:model];
            }];
            completion(YES,resultArray);
        }else{
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(NO,[data objectForKey:@"resultMsg"]);
        }
    } failed:^(NSString *error) {
        completion(NO, error);
        [CommonUtils changeHUDMessage:error];
    }];
}

@end
