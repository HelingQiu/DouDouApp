//
//  PrivilegeViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/21.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "PrivilegeViewController.h"

@interface PrivilegeViewController ()

@end

@implementation PrivilegeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"优惠劵",@"停车卷"]];
    self.navigationItem.titleView = segmentControl;
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
