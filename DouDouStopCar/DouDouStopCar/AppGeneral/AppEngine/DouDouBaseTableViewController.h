//
//  DouDouBaseTableViewController.h
//  DouDouStopCar
//
//  Created by Rainer on 17/2/7.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DouDouBaseTableViewController : UITableViewController

@property (nonatomic, strong) UIButton *backBtn;

+ (instancetype)creatByNib;

@end
