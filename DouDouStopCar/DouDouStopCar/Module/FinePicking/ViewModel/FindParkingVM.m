//
//  FindParkingVM.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/23.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "FindParkingVM.h"
#import "NearbyModel.h"

@implementation FindParkingVM

+ (void)getNearByParkingWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [CommonUtils showHUDWithWaitingMessage:nil];
    [[DouDouNetworking sharedInstance] getDataFromParams:parameter forUrl:GetNearParkingApi isJson:YES isAuthorizationHeader:NO headerParamers:nil finished:^(NSDictionary *data) {
        [CommonUtils hideHUD];
        
        NSLog(@"near by parking %@",data);
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
            NSArray *dataArray = [[data objectForKey:@"data"] objectForKey:@"list"];
            [dataArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NearbyModel *model = [NearbyModel mj_objectWithKeyValues:obj];
                [resultArray addObject:model];
            }];
            
            completion(YES,resultArray);
        }else{
//            [CommonUtils showHUDWithMessage:[data objectForKey:@"resultMsg"] autoHide:YES];
            completion(NO,[data objectForKey:@"resultMsg"]);
        }
        
    } failed:^(NSString *error) {
        [CommonUtils hideHUD];
//        [CommonUtils showHUDWithMessage:error autoHide:YES];
        completion(NO,error);
    }];
}

+ (void)getCityDataWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [[DouDouNetworking sharedInstance] getDataFromParams:parameter forUrl:GetCityAndDistrictApi isJson:YES isAuthorizationHeader:NO headerParamers:nil finished:^(NSDictionary *data) {
        [CommonUtils hideHUD];
        
        NSLog(@"city: %@",data);
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            
            NSData *cityData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonStr = [[NSString alloc]initWithData:cityData encoding:NSUTF8StringEncoding];
            
            [CommonUtils storageDataWithObject:jsonStr Key:kCityData Completion:^(BOOL finish, id obj) {
                completion(YES,data);
            }];
            
        }else{
            completion(NO,[data objectForKey:@"resultMsg"]);
        }
        
    } failed:^(NSString *error) {
        completion(NO,error);
    }];
}

@end
