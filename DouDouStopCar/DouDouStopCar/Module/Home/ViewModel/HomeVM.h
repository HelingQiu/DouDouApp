//
//  HomeVM.h
//  DouDouStopCar
//
//  Created by Rainer on 17/2/21.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeVM : NSObject

//广告
+ (void)getAdsDataWithParameter:(NSDictionary *)parameter completion:(CompletionWithObjectBlock)completion;

@end
