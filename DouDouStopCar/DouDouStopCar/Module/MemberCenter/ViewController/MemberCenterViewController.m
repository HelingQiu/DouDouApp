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
#import "MemberCenterVM.h"
#import "UserModel.h"
#import "DouDouBaseNavigationController.h"
#import "PersonModel.h"
#import "UserInfoViewController.h"

@interface MemberCenterViewController ()
{
    PersonModel *_personModel;
}

@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labPhone;
@property (weak, nonatomic) IBOutlet UILabel *labUnlogined;

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
    [[UINavigationBar appearance]  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO];
    [self setMemberData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView setFrame:CGRectMake(0, 64, mScreenWidth, mScreenHeight - 49 - 64)];
    [[[UIApplication sharedApplication] keyWindow] setBackgroundColor:kHexColor(kColor_Back)];
}

- (void)setMemberData
{
    [self getPersonInfo];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    if (![CommonUtils isBlankString:token]) {
        [self.labName setHidden:NO];
        [self.labPhone setHidden:NO];
        [self.labUnlogined setHidden:YES];
        [self.logoutButton setHidden:NO];
        [self getPersonInfo];
    }else{
        [self.labName setHidden:YES];
        [self.labPhone setHidden:YES];
        [self.labUnlogined setHidden:NO];
        [self.headView setImage:[UIImage imageNamed:@"member_head_default"]];
        [self.logoutButton setHidden:YES];
    }
}

- (void)getPersonInfo
{
    [MemberCenterVM getPersonInfoWithParameter:nil completion:^(BOOL finish, id obj) {
        if (finish) {
            _personModel = obj;
            [self.labName setHidden:NO];
            [self.labPhone setHidden:NO];
            [self.labUnlogined setHidden:YES];
            [self.logoutButton setHidden:NO];
            [self.labName setText:_personModel.name];
            [self.labPhone setText:_personModel.name];
            [self.labMoney setText:[NSString stringWithFormat:@"%@元",_personModel.balance]];
            [self.labLeft setText:[NSString stringWithFormat:@"%@张",_personModel.couponCount]];
            [self.labRight setText:[NSString stringWithFormat:@"%@张",_personModel.monthCardCount]];
            [self.headView sd_setImageWithURL:[NSURL URLWithString:_personModel.portraitUrl] placeholderImage:[UIImage imageNamed:@"member_head_default"]];
        }else{
//            [self.labName setHidden:YES];
//            [self.labPhone setHidden:YES];
//            [self.labUnlogined setHidden:NO];
//            [self.logoutButton setHidden:YES];
//            [self.headView setImage:[UIImage imageNamed:@"member_head_default"]];
        }
    }];
}

- (IBAction)leftAction:(UIButton *)sender
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    if (![CommonUtils isBlankString:token]) {
        PrivilegeViewController *privilegeController = [[PrivilegeViewController alloc] init];
        [self.navigationController pushViewController:privilegeController animated:YES];
    }else{
        DouDouBaseNavigationController *loginNavController =[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
        [self presentViewController:loginNavController animated:YES completion:^{
            
        }];
    }
}

- (IBAction)rightAction:(UIButton *)sender
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    if (![CommonUtils isBlankString:token]) {
        MonthCardViewController *monthController = [[MonthCardViewController alloc] init];
        [self.navigationController pushViewController:monthController animated:YES];
    }else{
        DouDouBaseNavigationController *loginNavController =[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
        [self presentViewController:loginNavController animated:YES completion:^{
            
        }];
    }
}

- (IBAction)logoutAction:(UIButton *)sender {
    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"确定退出当前账号？" cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{
        
    }] otherButtonItems:[RIButtonItem itemWithLabel:@"确定" action:^{
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kDouDouToken];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kDouDouPassWord];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.labName setHidden:YES];
        [self.labPhone setHidden:YES];
        [self.labUnlogined setHidden:NO];
        [self.logoutButton setHidden:YES];
        [self.headView setImage:[UIImage imageNamed:@"member_head_default"]];
        [self.labMoney setText:[NSString stringWithFormat:@"0元"]];
        [self.labLeft setText:[NSString stringWithFormat:@"0张"]];
        [self.labRight setText:[NSString stringWithFormat:@"0张"]];
    }], nil] show];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
            if (![CommonUtils isBlankString:token]) {
                UserInfoViewController *userController = [[UserInfoViewController alloc] init];
                userController.model = _personModel;
                [self.navigationController pushViewController:userController animated:YES];
            }else{
                DouDouBaseNavigationController *loginNavController =[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
                [self presentViewController:loginNavController animated:YES completion:^{
                    
                }];
            }
        }else if (indexPath.row == 1) {
            NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
            if (![CommonUtils isBlankString:token]) {
                WalletViewController *waletController = [[WalletViewController alloc] init];
                [self.navigationController pushViewController:waletController animated:YES];
            }else{
                DouDouBaseNavigationController *loginNavController =[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
                [self presentViewController:loginNavController animated:YES completion:^{
                    
                }];
            }
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
            if (![CommonUtils isBlankString:token]) {
                CarNumberViewController *carnumberController = [[CarNumberViewController alloc] init];
                [self.navigationController pushViewController:carnumberController animated:YES];
            }else{
                DouDouBaseNavigationController *loginNavController =[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
                [self presentViewController:loginNavController animated:YES completion:^{
                    
                }];
            }
            
        }else if (indexPath.row == 1) {
            NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
            if (![CommonUtils isBlankString:token]) {
                StopRecordViewController *stopController = [StopRecordViewController createByNibFile];
                [self.navigationController pushViewController:stopController animated:YES];
            }else{
                DouDouBaseNavigationController *loginNavController =[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
                [self presentViewController:loginNavController animated:YES completion:^{
                    
                }];
            }
            
        }else if (indexPath.row == 2) {
            NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
            if (![CommonUtils isBlankString:token]) {
                CollectionViewController *stopController = [CollectionViewController createByNibFile];
                [self.navigationController pushViewController:stopController animated:YES];
            }else{
                DouDouBaseNavigationController *loginNavController =[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
                [self presentViewController:loginNavController animated:YES completion:^{
                    
                }];
            }
            
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
