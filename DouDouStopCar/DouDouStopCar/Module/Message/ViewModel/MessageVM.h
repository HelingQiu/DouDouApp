//
//  MessageVM.h
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/28.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageVM : NSObject

//获取消息列表
+ (void)getMessageListWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

@end
