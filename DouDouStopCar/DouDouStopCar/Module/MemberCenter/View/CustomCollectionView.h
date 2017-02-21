//
//  CustomCollectionView.h
//
//  Created by  on 16/11/3.
//  Copyright © 2016年 Tony. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef void(^SelectValue)(NSString *value);
typedef void(^DeleteValue)(void);
typedef void(^SureAddBlock)(void);

@interface CustomCollectionView : UIView

@property (nonatomic,copy)SelectValue selectBlock;
@property (nonatomic,copy)DeleteValue deleteBlock;
@property (nonatomic,copy)SureAddBlock sureBlock;

- (void)changeDataSourceWithIndex:(NSInteger)index;

@end
