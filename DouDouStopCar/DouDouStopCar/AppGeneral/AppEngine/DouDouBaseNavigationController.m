//
//  DouDouBaseNavigationController.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/17.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "DouDouBaseNavigationController.h"

@interface DouDouBaseNavigationController ()

@end

@implementation DouDouBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationBar setBarTintColor:kHexColor(kColor_Mian)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
