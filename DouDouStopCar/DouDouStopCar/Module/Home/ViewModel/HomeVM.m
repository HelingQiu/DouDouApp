//
//  HomeVM.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/21.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "HomeVM.h"
#import "AdsDataModel.h"

@implementation HomeVM

+ (void)getAdsDataWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [CommonUtils showHUDWithWaitingMessage:nil];
    [[DouDouNetworking sharedInstance] getDataFromParams:parameter forUrl:GetAdsApi isJson:YES isAuthorizationHeader:NO headerParamers:nil finished:^(NSDictionary *data) {
        [CommonUtils hideHUD];
        NSLog(@"get ads :%@",data);
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
            NSArray *dataArray = [[data objectForKey:@"data"] objectForKey:@"list"];
            [dataArray enumerateObjectsUsingBlock:^(NSDictionary  * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                AdsDataModel *model = [AdsDataModel mj_objectWithKeyValues:obj];
                [resultArray addObject:model];
            }];
            completion(YES,resultArray);
        }else{
            completion(NO,[data objectForKey:@"resultMsg"]);
        }
    } failed:^(NSString *error) {
        [CommonUtils hideHUD];
        completion(NO,error);
    }];
}

@end
