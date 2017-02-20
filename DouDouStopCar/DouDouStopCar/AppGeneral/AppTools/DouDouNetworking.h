//
//  DouDouNetworking.h
//  DouDouStopCar
//
//  Created by Rainer on 17/2/20.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^KSFinishedBlock) (NSDictionary *data);
typedef void (^KSFailedBlock)   (NSString *error);
typedef void (^KSUploadProgress) (float progressValue);

@interface DouDouNetworking : NSObject

+ (id)sharedInstance;
+ (void)startMonitoringNetwork:(void (^)(NSString *message))completion;
+ (BOOL)isNetworkReachable;

/**
 *  Network Request Method(default is POST)
 */
@property (nonatomic , copy) NSString *httpMethod;


/**
 *  POST
 *
 *  @param params            参数
 *  @param path              请求地址
 *  @param isJson            是否是json格式
 *  @param isPrivate         是否是内部请求
 *  @param isAuthorization   是否需要授权验证
 *  @param headerParamers    请求头参数
 *  @param finished          请求完成
 *  @param failed            请求失败
 */
- (void)requestDataFromWSWithParams:(NSDictionary *)params
                            forPath:(NSString *)path
                             isJson:(BOOL)isJson
                          isPrivate:(BOOL)isPrivate
              isAuthorizationHeader:(BOOL)isAuthorization
                     headerParamers:(NSDictionary *)headerParamers
                           finished:(KSFinishedBlock)finished
                             failed:(KSFailedBlock)failed;


/**
 *  GET
 *
 *  @param params   参数
 *  @param url      请求地址
 *  @param isJson   是否是json格式
 *  @param isAuthorization   是否需要授权验证
 *  @param headerParamers    请求头参数
 *  @param finished 请求完成
 *  @param failed   请求失败
 *
 */
- (void)getDataFromParams:(NSDictionary *)params
                   forUrl:(NSString *)url
                   isJson:(BOOL)isJson
    isAuthorizationHeader:(BOOL)isAuthorization
           headerParamers:(NSDictionary *)headerParamers
                 finished:(KSFinishedBlock)finished
                   failed:(KSFailedBlock)failed;

/**
 *  POST
 *
 *  @param fileData         二进制数据
 *  @param path             请求地址
 *  @param photoKey         上传key
 *  @param fileName         文件名称
 *  @param params           参数
 *  @param uploadProgress   上传进度
 *  @param finished         请求完成
 *  @param failed           请求失败
 */
- (void)uploadFile:(NSData *)fileData path:(NSString *)path photoKey:(NSString *)photoKey fileName:(NSString *)fileName params:(NSDictionary *)params uploadProgress:(KSUploadProgress)uploadProgress finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed;

/**
 *  Cancel all request
 */
- (void)cancelAllRequest;

@end
