//
//  DouDouNetworking.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/20.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "DouDouNetworking.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

@implementation DouDouNetworking
@synthesize httpMethod;

- (id)init {
    self = [super init];
    if (self) {
        self.httpMethod = @"POST";
    }
    return self;
}

+ (id)sharedInstance {
    static DouDouNetworking *sharedNetworking = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNetworking = [[self alloc] init];
    });
    return sharedNetworking;
}

+ (void)startMonitoringNetwork:(void (^)(NSString *))completion
{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString *message = nil;
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                message = [NSString stringWithFormat:@"当前网络不可用"];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                message = [NSString stringWithFormat:@"当前网络已切换为WiFi"];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                message = [NSString stringWithFormat:@"当前网络已切换为2G/3G/4G网络"];
                break;
            }
            default:
                break;
        }
        completion(message);
    }];
}

+ (BOOL)isNetworkReachable {
    return ((AFNetworkReachabilityManager *)[AFNetworkReachabilityManager sharedManager]).reachable;
}

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
                             failed:(KSFailedBlock)failed {
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer.timeoutInterval = 60;
    if (!isJson) {
        sessionManager.responseSerializer= [AFHTTPResponseSerializer serializer];
    } else {
        sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    if (isAuthorization) {
        
        if (headerParamers && [headerParamers isKindOfClass:[NSDictionary class]]) {
            [headerParamers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [sessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
            }];
        }
        
    }
    [sessionManager POST:[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (isJson) {
            if(isPrivate){
                if (((NSHTTPURLResponse *)task.response).statusCode == 200) {
                    if([responseObject isKindOfClass:[NSDictionary class]])
                    {
                        NSDictionary *resultDic = (NSDictionary *)responseObject;
                        if ([resultDic[@"resultCode"] integerValue] == 1) {
                            finished(resultDic);
                        } else {
                            failed(resultDic[@"resultMsg"]);
                        }
                    } else {
                        failed(@"服务器返回数据格式有误");
                    }
                } else {
                    failed(responseObject);
                }
            } else {
                if([responseObject isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *resultDic = (NSDictionary *)responseObject;
                    finished(resultDic);
                } else {
                    failed(@"服务器返回数据格式有误");
                }
            }
        } else {
            if (isPrivate) {
                NSError *error;
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject                                                                                         options:kNilOptions error:&error];
                if (!error) {
                    if (((NSHTTPURLResponse *)task.response).statusCode == 200) {
                        if ([resultDic[@"resultCode"] integerValue] == 1) {
                            finished(resultDic);
                        } else {
                            failed(resultDic[@"resultMsg"]);
                        }
                    } else {
                        failed(resultDic[@"resultMsg"]);
                    }
                } else {
                    failed(@"服务器返回数据格式有误");
                }
            } else {
                NSError *error;
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject                                                                                         options:kNilOptions error:&error];
                if (!error) {
                    finished(resultDic);
                } else {
                    failed(@"服务器返回数据格式有误");
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(error.code == NSURLErrorNotConnectedToInternet) {
            
            failed(@"网络不给力");
            
        } else {
            
            failed(@"服务器连接失败，请稍候再试");
            
        }
        
    }];
}

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
                   failed:(KSFailedBlock)failed {
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer.timeoutInterval = 60;
    if (!isJson) {
        sessionManager.responseSerializer= [AFHTTPResponseSerializer serializer];
    } else {
        sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    if (isAuthorization) {
        if (headerParamers && [headerParamers isKindOfClass:[NSDictionary class]]) {
            [headerParamers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [sessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
            }];
        }
    }
    [sessionManager GET:[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (isJson) {
            if (((NSHTTPURLResponse *)task.response).statusCode == 200) {
                if([responseObject isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary *resultDic = (NSDictionary *)responseObject;
                    if ([resultDic[@"resultCode"] integerValue] == 1 || [[resultDic objectForKey:@"status"] integerValue] == 0) {
                        finished(resultDic);
                    } else {
                        failed(resultDic[@"resultMsg"]?:@"请求出错");
                    }
                } else {
                    failed(@"服务器返回数据格式有误");
                }
                
            } else {
                failed(responseObject);
            }
        } else {
            NSError *error;
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject                                                                                         options:kNilOptions error:&error];
            if (!error) {
                if (((NSHTTPURLResponse *)task.response).statusCode == 200) {
                    if ([resultDic[@"resultCode"] integerValue] == 1) {
                        finished(resultDic);
                    } else {
                        failed(resultDic[@"resultMsg"]);
                    }
                } else {
                    failed(resultDic[@"resultMsg"]);
                }
            } else {
                failed(@"服务器返回数据格式有误");
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(error.code == NSURLErrorNotConnectedToInternet) {
            failed(@"网络不给力");
        } else {
            failed(@"服务器连接失败，请稍候再试");
        }
    }];
}

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
- (void)uploadFile:(NSData *)fileData path:(NSString *)path photoKey:(NSString *)photoKey fileName:(NSString *)fileName params:(NSDictionary *)params uploadProgress:(KSUploadProgress)uploadProgress finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed {
    NSString *mimeType = [self contentTypeForImageData:fileData];
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:self.httpMethod URLString:[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:fileData name:photoKey fileName:fileName mimeType:mimeType];
        
    } error:nil];
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [sessionManager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error == nil) {
            NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            result = [result stringByReplacingOccurrencesOfString:@"\\" withString:@""];
            
            result = [result substringFromIndex:1];
            result = [result substringToIndex:result.length - 1];
            
            NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];
            
            NSError *error;
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data                                                                                         options:kNilOptions error:&error];
            
            if (!error) {
                if (((NSHTTPURLResponse *)response).statusCode == 200) {
                    finished(resultDic);
                } else {
                    failed(nil);
                }
            } else {
                failed(nil);
            }
        }else{
            failed(@"网络不给力");
        }
    }];
    [uploadTask resume];
}

/**
 *  Cancel all request
 */
- (void)cancelAllRequest
{
    [[[AFHTTPSessionManager manager] operationQueue] cancelAllOperations];
}

- (NSString *)contentTypeForImageData:(NSData *)data
{
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
}

@end
