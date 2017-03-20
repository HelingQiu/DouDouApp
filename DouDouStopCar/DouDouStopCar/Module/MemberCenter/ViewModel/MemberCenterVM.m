//
//  MemberCenterVM.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/24.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "MemberCenterVM.h"
#import "ParkingRecordModel.h"
#import "PersonModel.h"

@implementation MemberCenterVM

+ (void)getPersonInfoWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    NSDictionary *params = @{@"token":token?:@""};
    [[DouDouNetworking sharedInstance] requestDataFromWSWithParams:parameter forPath:GetPersonInfoApi isJson:YES isPrivate:NO isAuthorizationHeader:YES headerParamers:params finished:^(NSDictionary *data) {
        NSLog(@"person info:%@",data);
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            PersonModel *model = [PersonModel mj_objectWithKeyValues:[data objectForKey:@"data"]];
            completion(YES, model);
        }else{
            completion(NO,[data objectForKey:@"resultMsg"]);
        }
    } failed:^(NSString *error) {
        completion(NO, error);
    }];
}

+ (void)getParkingRecordWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [CommonUtils showHUDWithWaitingMessage:nil];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    NSDictionary *params = @{@"token":token?:@""};
    [[DouDouNetworking sharedInstance] requestDataFromWSWithParams:parameter forPath:GetParkingRecordApi isJson:YES isPrivate:NO isAuthorizationHeader:YES headerParamers:params finished:^(NSDictionary *data) {
        NSLog(@"parking record:%@",data);
        [CommonUtils hideHUD];
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
            NSArray *dataArray = [[data objectForKey:@"data"] objectForKey:@"list"];
            [dataArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ParkingRecordModel *model = [ParkingRecordModel mj_objectWithKeyValues:obj];
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

+ (void)getCarListWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [CommonUtils showHUDWithWaitingMessage:nil];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    NSDictionary *params = @{@"token":token?:@""};
    [[DouDouNetworking sharedInstance] getDataFromParams:parameter forUrl:GetCarListApi isJson:YES isAuthorizationHeader:YES headerParamers:params finished:^(NSDictionary *data) {
        NSLog(@"car list:%@",data);
        [CommonUtils hideHUD];
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
            NSArray *dataArray = [[data objectForKey:@"data"] objectForKey:@"list"];
            [dataArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                PlateNumberModel *model = [PlateNumberModel mj_objectWithKeyValues:obj];
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

+ (void)addCarNumberWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [CommonUtils showHUDWithWaitingMessage:nil];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    NSDictionary *params = @{@"token":token?:@""};
    [[DouDouNetworking sharedInstance] requestDataFromWSWithParams:parameter forPath:AddCarApi isJson:YES isPrivate:NO isAuthorizationHeader:YES headerParamers:params finished:^(NSDictionary *data) {
        [CommonUtils hideHUD];
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(YES,[data objectForKey:@"resultMsg"]);
        }else{
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(NO,[data objectForKey:@"resultMsg"]);
        }
    } failed:^(NSString *error) {
        completion(NO, error);
        [CommonUtils changeHUDMessage:error];
    }];
}

+ (void)getRechargeListWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [CommonUtils showHUDWithWaitingMessage:nil];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    NSDictionary *params = @{@"token":token?:@""};
    [[DouDouNetworking sharedInstance] requestDataFromWSWithParams:parameter forPath:GetRechargeApi isJson:YES isPrivate:NO isAuthorizationHeader:YES headerParamers:params finished:^(NSDictionary *data) {
        NSLog(@"recharge list:%@",data);
        [CommonUtils hideHUD];
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
            NSArray *dataArray = [[data objectForKey:@"data"] objectForKey:@"list"];
            [dataArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                RechargeModel *model = [RechargeModel mj_objectWithKeyValues:obj];
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

+ (void)getWalletRecordWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [CommonUtils showHUDWithWaitingMessage:nil];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    NSDictionary *params = @{@"token":token?:@""};
    [[DouDouNetworking sharedInstance] requestDataFromWSWithParams:parameter forPath:GetWalletRecordApi isJson:YES isPrivate:NO isAuthorizationHeader:YES headerParamers:params finished:^(NSDictionary *data) {
        NSLog(@"wallet record:%@",data);
        [CommonUtils hideHUD];
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            completion(YES,data);
        }else{
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(NO,[data objectForKey:@"resultMsg"]);
        }
    } failed:^(NSString *error) {
        completion(NO, error);
        [CommonUtils changeHUDMessage:error];
    }];
}

+ (void)rechargeListWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [CommonUtils showHUDWithWaitingMessage:nil];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    NSDictionary *params = @{@"token":token?:@""};
    [[DouDouNetworking sharedInstance] requestDataFromWSWithParams:parameter forPath:RechargeApi isJson:YES isPrivate:NO isAuthorizationHeader:YES headerParamers:params finished:^(NSDictionary *data) {
        NSLog(@"recharge :%@",data);
        [CommonUtils hideHUD];
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            completion(YES,data);
        }else{
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(NO,[data objectForKey:@"resultMsg"]);
        }
    } failed:^(NSString *error) {
        completion(NO, error);
        [CommonUtils changeHUDMessage:error];
    }];
}

+ (void)depositWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [CommonUtils showHUDWithWaitingMessage:nil];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    NSDictionary *params = @{@"token":token?:@""};
    [[DouDouNetworking sharedInstance] requestDataFromWSWithParams:parameter forPath:WithDrawsCashApi isJson:YES isPrivate:NO isAuthorizationHeader:YES headerParamers:params finished:^(NSDictionary *data) {
        NSLog(@"deposit :%@",data);
        [CommonUtils hideHUD];
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            completion(YES,data);
        }else{
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(NO,[data objectForKey:@"resultMsg"]);
        }
    } failed:^(NSString *error) {
        completion(NO, error);
        [CommonUtils changeHUDMessage:error];
    }];
}

+ (void)getMyCollectionListWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [CommonUtils showHUDWithWaitingMessage:nil];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    NSDictionary *params = @{@"token":token?:@""};
    [[DouDouNetworking sharedInstance] requestDataFromWSWithParams:parameter forPath:GetMyCollectionApi isJson:YES isPrivate:NO isAuthorizationHeader:YES headerParamers:params finished:^(NSDictionary *data) {
        NSLog(@"collection list :%@",data);
        [CommonUtils hideHUD];
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            NSArray *dataArray = [[data objectForKey:@"data"] objectForKey:@"list"];
            NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
            [dataArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CollectionModel *model = [CollectionModel mj_objectWithKeyValues:obj];
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

+ (void)addMyCollectionWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [CommonUtils showHUDWithWaitingMessage:nil];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    NSDictionary *params = @{@"token":token?:@""};
    [[DouDouNetworking sharedInstance] requestDataFromWSWithParams:parameter forPath:AddMyCollectionApi isJson:YES isPrivate:NO isAuthorizationHeader:YES headerParamers:params finished:^(NSDictionary *data) {
        NSLog(@"add collection :%@",data);
        [CommonUtils hideHUD];
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(YES,data);
        }else{
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(NO,[data objectForKey:@"resultMsg"]);
        }
    } failed:^(NSString *error) {
        completion(NO, error);
        [CommonUtils changeHUDMessage:error];
    }];
}

+ (void)deleteMyCollectionListWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [CommonUtils showHUDWithWaitingMessage:nil];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    NSDictionary *params = @{@"token":token?:@""};
    [[DouDouNetworking sharedInstance] requestDataFromWSWithParams:parameter forPath:DeleteMyCollectionApi isJson:YES isPrivate:NO isAuthorizationHeader:YES headerParamers:params finished:^(NSDictionary *data) {
        NSLog(@"delete collection :%@",data);
        [CommonUtils hideHUD];
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(YES,data);
        }else{
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(NO,[data objectForKey:@"resultMsg"]);
        }
    } failed:^(NSString *error) {
        completion(NO, error);
        [CommonUtils changeHUDMessage:error];
    }];
}

+ (void)getMonthCardListWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [CommonUtils showHUDWithWaitingMessage:nil];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    NSDictionary *params = @{@"token":token?:@""};
    [[DouDouNetworking sharedInstance] requestDataFromWSWithParams:parameter forPath:GetMonthCardListApi isJson:YES isPrivate:NO isAuthorizationHeader:YES headerParamers:params finished:^(NSDictionary *data) {
        NSLog(@"collection list :%@",data);
        [CommonUtils hideHUD];
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            NSArray *dataArray = [[data objectForKey:@"data"] objectForKey:@"list"];
            NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
            [dataArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MonthCardModel *model = [MonthCardModel mj_objectWithKeyValues:obj];
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

+ (void)feedbackWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [CommonUtils showHUDWithWaitingMessage:nil];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    NSDictionary *params = @{@"token":token?:@""};
    [[DouDouNetworking sharedInstance] requestDataFromWSWithParams:parameter forPath:FeedbackApi isJson:YES isPrivate:NO isAuthorizationHeader:YES headerParamers:params finished:^(NSDictionary *data) {
        NSLog(@"feedback :%@",data);
        [CommonUtils hideHUD];
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(YES,[data objectForKey:@"resultMsg"]);
        }else{
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(NO,[data objectForKey:@"resultMsg"]);
        }
    } failed:^(NSString *error) {
        completion(NO, error);
        [CommonUtils changeHUDMessage:error];
    }];
}

+ (void)getRoleInfoWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [[DouDouNetworking sharedInstance] getDataFromParams:parameter forUrl:RoleInfoApi isJson:YES isAuthorizationHeader:NO headerParamers:nil finished:^(NSDictionary *data) {
        [CommonUtils hideHUD];
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(YES,data);
        }else{
            [CommonUtils changeHUDMessage:[data objectForKey:@"resultMsg"]];
            completion(NO,[data objectForKey:@"resultMsg"]);
        }
    } failed:^(NSString *error) {
        completion(NO, error);
        [CommonUtils changeHUDMessage:error];
    }];
}

+ (void)getCashRecordWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [CommonUtils showHUDWithWaitingMessage:nil];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    NSDictionary *params = @{@"token":token?:@""};
    [[DouDouNetworking sharedInstance] requestDataFromWSWithParams:parameter forPath:DepositCashRecordApi isJson:YES isPrivate:NO isAuthorizationHeader:YES headerParamers:params finished:^(NSDictionary *data) {
        NSLog(@"collection list :%@",data);
        [CommonUtils hideHUD];
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            NSArray *dataArray = [[data objectForKey:@"data"] objectForKey:@"list"];
            NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
            [dataArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CashRecordModel *model = [CashRecordModel mj_objectWithKeyValues:obj];
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

+ (void)getBillListRecordWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{
    [CommonUtils showHUDWithWaitingMessage:nil];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    NSDictionary *params = @{@"token":token?:@""};
    [[DouDouNetworking sharedInstance] requestDataFromWSWithParams:parameter forPath:ApplyBillRecordApi isJson:YES isPrivate:NO isAuthorizationHeader:YES headerParamers:params finished:^(NSDictionary *data) {
        NSLog(@"bill list :%@",data);
        [CommonUtils hideHUD];
        if ([[data objectForKey:@"resultCode"] integerValue] == 1) {
            NSArray *dataArray = [[data objectForKey:@"data"] objectForKey:@"list"];
            NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
            [dataArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ApplyBillModel *model = [ApplyBillModel mj_objectWithKeyValues:obj];
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

+ (void)applyBillWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion
{

}


@end
