//
//  AppDefine.h
//  DouDouStopCar
//
//  Created by Rainer on 17/2/7.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#ifndef AppDefine_h
#define AppDefine_h

#define kHexColor(HexString) [UIColor colorForHexString:HexString]
#define kFontSize(fontSize) [UIFont systemFontOfSize:fontSize]
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define mNavBarHeight         44
#define mTabBarHeight         50
#define mScreenWidth          ([UIScreen mainScreen].bounds.size.width)
#define mScreenHeight         ([UIScreen mainScreen].bounds.size.height)
// 按钮字体颜色
#define kBtnTitleNormalColor [UIColor colorWithRed:0.200 green:0.200 blue:0.200 alpha:1]
#define kBtnTitleHighlightColor  [UIColor colorWithRed:0.800 green:0.800 blue:0.800 alpha:1]

#endif /* AppDefine_h */