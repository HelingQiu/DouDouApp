//
//  MemberCenterViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/16.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "MemberCenterViewController.h"
#import "StopRecordViewController.h"
#import "CollectionViewController.h"
#import "AboutViewController.h"

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
    [self.backBtn setHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView setFrame:CGRectMake(0, 64, mScreenWidth, mScreenHeight - 49 - 64)];
    [[[UIApplication sharedApplication] keyWindow] setBackgroundColor:kHexColor(kColor_Back)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            StopRecordViewController *stopController = [StopRecordViewController createByNibFile];
            stopController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:stopController animated:YES];
        }else if (indexPath.row == 2) {
            CollectionViewController *stopController = [CollectionViewController createByNibFile];
            [self.navigationController pushViewController:stopController animated:YES];
        }else if (indexPath.row == 3) {
            AboutViewController *aboutController = [AboutViewController createByNibFile];
            aboutController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutController animated:YES];
        }
    }
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
