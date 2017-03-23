//
//  UserInfoViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/3/22.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserHeadCell.h"
#import "UserContentCell.h"

typedef NS_ENUM(NSUInteger, UserInfoType) {
    UserInfoHeader = 0,
    UserInfoName = 1,
    UserInfoPhone = 2,
    UserInfoPassword = 3,
    UserInfoLogout = 4,
};
@interface UserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"账号资料";
    
    [self initilizeData];
    [self setConfigView];
}

- (void)initilizeData
{
    self.dataSource = [NSMutableArray array];
    [self.dataSource addObject:@{@"title":@"头像",@"type":@(UserInfoHeader)}];
    [self.dataSource addObject:@{@"title":@"手机",@"type":@(UserInfoName)}];
    [self.dataSource addObject:@{@"title":@"昵称",@"type":@(UserInfoPhone)}];
    [self.dataSource addObject:@{@"title":@"修改密码",@"type":@(UserInfoPassword)}];
    [self.dataSource addObject:@{@"title":@"退出账号",@"type":@(UserInfoLogout)}];
}

- (void)setConfigView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight - 64 - 60) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoutButton setFrame:CGRectMake(15, mScreenHeight - 64 - 54, mScreenWidth - 30, 40)];
    [logoutButton setBackgroundColor:kHexColor(kColor_Mian)];
    [logoutButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutButton setTitle:@"退出账号" forState:UIControlStateNormal];
    logoutButton.layer.cornerRadius = 4;
    [logoutButton addTarget:self action:@selector(logoutAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];
}

- (void)logoutAction:(UIButton *)sender
{
    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"确定退出当前账号？" cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{
        
    }] otherButtonItems:[RIButtonItem itemWithLabel:@"确定" action:^{
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kDouDouToken];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kDouDouPassWord];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController popViewControllerAnimated:YES];
    }], nil] show];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *body = [self.dataSource objectAtIndex:indexPath.row];
    NSInteger type = [[body objectForKey:@"type"] integerValue];
    if (type == UserInfoHeader) {
        return 88;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *body = [self.dataSource objectAtIndex:indexPath.row];
    NSInteger type = [[body objectForKey:@"type"] integerValue];
    if (type == UserInfoHeader) {
        UserHeadCell *cell = [UserHeadCell cellWithTableView:tableView];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.labTitle setText:[body objectForKey:@"title"]];
        [cell.headView sd_setImageWithURL:[NSURL URLWithString:self.model.portraitUrl] placeholderImage:[UIImage imageNamed:@"member_head_default"] options:SDWebImageAllowInvalidSSLCertificates];
        return cell;
    }
    
    UserContentCell *cell = [UserContentCell cellWithTableView:tableView];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.labTitle setText:[body objectForKey:@"title"]];
    switch (type) {
        case UserInfoName:
        {
            cell.contentField.enabled = NO;
            [cell.contentField setText:self.model.name];
        }
            break;
        case UserInfoPhone:
        {
            cell.contentField.enabled = NO;
            
            [cell.contentField setText:self.model.mobile];
            
        }
            break;
        case UserInfoPassword:
        {
            cell.contentField.enabled = NO;
            
        }
            break;
        case UserInfoLogout:
        {
            cell.contentField.enabled = NO;
        }
            break;
        
        default:
            break;
    }
    return cell;
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
