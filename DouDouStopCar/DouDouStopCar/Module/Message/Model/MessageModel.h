//
//  MessageModel.h
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/28.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic, assign) NSInteger inOrOutType;
@property (nonatomic, copy) NSString *inOrOutDate;
@property (nonatomic, copy) NSString *plateNumber;
@property (nonatomic, copy) NSString *parkAddress;

@end
