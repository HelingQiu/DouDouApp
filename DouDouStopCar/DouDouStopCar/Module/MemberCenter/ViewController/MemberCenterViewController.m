//
//  MemberCenterViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/16.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "MemberCenterViewController.h"

@interface MemberCenterViewController ()

@end

@implementation MemberCenterViewController

+ (instancetype)createByNibFile{
    
    return [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MemberCenterVC"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的";
    self.tableView.tableFooterView = [UIView new];
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
