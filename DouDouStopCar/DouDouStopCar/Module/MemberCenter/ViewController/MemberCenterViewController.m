//
//  MemberCenterViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/16.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "MemberCenterViewController.h"
#import "WalletViewController.h"
#import "PrivilegeViewController.h"
#import "MonthCardViewController.h"
#import "CarNumberViewController.h"
#import "StopRecordViewController.h"
#import "CollectionViewController.h"
#import "AboutViewController.h"

@interface MemberCenterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labPhone;

@property (weak, nonatomic) IBOutlet UILabel *labMoney;
@property (weak, nonatomic) IBOutlet UILabel *labLeft;
@property (weak, nonatomic) IBOutlet UILabel *labRight;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

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
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView setFrame:CGRectMake(0, 64, mScreenWidth, mScreenHeight - 49 - 64)];
    [[[UIApplication sharedApplication] keyWindow] setBackgroundColor:kHexColor(kColor_Back)];
}

- (IBAction)leftAction:(UIButton *)sender
{
    PrivilegeViewController *privilegeController = [[PrivilegeViewController alloc] init];
    [[self rdv_tabBarController] setTabBarHidden:YES];
    [self.navigationController pushViewController:privilegeController animated:YES];
}

- (IBAction)rightAction:(UIButton *)sender
{
    MonthCardViewController *monthController = [[MonthCardViewController alloc] init];
    [[self rdv_tabBarController] setTabBarHidden:YES];
    [self.navigationController pushViewController:monthController animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            WalletViewController *waletController = [[WalletViewController alloc] init];
            [self.navigationController pushViewController:waletController animated:YES];
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            CarNumberViewController *carnumberController = [[CarNumberViewController alloc] init];
            [self.navigationController pushViewController:carnumberController animated:YES];
        }else if (indexPath.row == 1) {
            StopRecordViewController *stopController = [StopRecordViewController createByNibFile];
            [self.navigationController pushViewController:stopController animated:YES];
        }else if (indexPath.row == 2) {
            CollectionViewController *stopController = [CollectionViewController createByNibFile];
            [self.navigationController pushViewController:stopController animated:YES];
        }else if (indexPath.row == 3) {
            AboutViewController *aboutController = [AboutViewController createByNibFile];
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
