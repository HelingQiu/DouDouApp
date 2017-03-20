//
//  WalletViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/21.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "WalletViewController.h"
#import "DouDouButton.h"
#import "WalletRecordCell.h"
#import "MemberCenterVM.h"
#import "ParkingRecordModel.h"
#import "RechargeViewController.h"
#import "DepositViewController.h"

@interface WalletViewController ()

@property (nonatomic, copy) NSString *balance;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"钱包";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    self.balance = @"0";
    [self getWalletRecordData];
}

- (void)getWalletRecordData
{
    NSDictionary *params = @{@"page":@"1"};
    [MemberCenterVM getWalletRecordWithParameter:params completion:^(BOOL finish, id obj) {
        if (finish) {
            NSDictionary *data = obj;
            self.balance = [NSString stringWithFormat:@"%@",[[data objectForKey:@"data"] objectForKey:@"balance"]];
            NSArray *array = [[data objectForKey:@"data"] objectForKey:@"list"];
            [array enumerateObjectsUsingBlock:^(NSDictionary  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                WalletRecordModel *model = [WalletRecordModel mj_objectWithKeyValues:obj];
                [self.dataSource addObject:model];
            }];
            
            [self.tableView reloadData];
        }
    }];
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 234.6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 234.6)];
    [headView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 123.3)];
    [backView setBackgroundColor:kHexColor(kColor_Mian)];
    [headView addSubview:backView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(mScreenWidth/2 - 44.7/2, 20, 44.7, 53.3)];
    [imgView setImage:[UIImage imageNamed:@"wallet_default"]];
    [backView addSubview:imgView];
    
    UILabel *labTip = [[UILabel alloc] initWithFrame:CGRectMake(mScreenWidth/2 - 44.7/2 - 40, 123.3 - 30, 40, 15)];
    [labTip setText:@"余额"];
    [labTip setFont:kFontSize(15)];
    [labTip setTextColor:[UIColor whiteColor]];
    [backView addSubview:labTip];
    
    CGFloat moneyWidth = [CommonUtils widthForString:self.balance Font:kFontSize(33) andWidth:mScreenWidth];
    UILabel *labMoney = [[UILabel alloc] initWithFrame:CGRectMake(mScreenWidth/2 - 44.7/2, 123.3 - 45, moneyWidth, 33)];
    [labMoney setText:self.balance];
    [labMoney setFont:kFontSize(33)];
    [labMoney setTextColor:[UIColor whiteColor]];
    [backView addSubview:labMoney];
    
    UILabel *labUnit = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labMoney.frame) + 5, 123.3 - 30, 20, 15)];
    [labUnit setText:@"元"];
    [labUnit setFont:kFontSize(15)];
    [labUnit setTextColor:[UIColor whiteColor]];
    [backView addSubview:labUnit];
    
    UIImageView *btnImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(backView.frame), mScreenWidth, 61.3)];
    [btnImgView setImage:[UIImage imageNamed:@"wallet_btn_back"]];
    [backView addSubview:btnImgView];
    
    DouDouButton *leftButton = [DouDouButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, CGRectGetMaxY(backView.frame), mScreenWidth/2, 61.3)];
    [leftButton setImageViewRect:CGRectMake(20, 15, 16, 31)];
    [leftButton setTitleLabelRect:CGRectMake(51, 15, 50, 31)];
    [leftButton setImage:[UIImage imageNamed:@"wallet_recharge"] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [leftButton setTitle:@"充值" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(rechargeAction:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:leftButton];
    
    DouDouButton *rightButton = [DouDouButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(mScreenWidth/2, CGRectGetMaxY(backView.frame), mScreenWidth/2, 61.3)];
    [rightButton setImageViewRect:CGRectMake(20, 20, 26.7, 21.3)];
    [rightButton setTitleLabelRect:CGRectMake(71.7, 15, 50, 31)];
    [rightButton setImage:[UIImage imageNamed:@"wallet_deposite"] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [rightButton setTitle:@"提现" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(depositAction:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:rightButton];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(leftButton.frame) + 6, mScreenWidth, 44)];
    [titleView setBackgroundColor:[UIColor whiteColor]];
    [headView addSubview:titleView];
    
    UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, mScreenWidth - 30, 44)];
    [labTitle setFont:[UIFont boldSystemFontOfSize:16]];
    [labTitle setTextColor:[UIColor blackColor]];
    [labTitle setText:@"账单明细"];
    [titleView addSubview:labTitle];
    
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WalletRecordCell *cell = [WalletRecordCell cellForTableView:tableView];
    
    WalletRecordModel *model = [self.dataSource objectAtIndex:indexPath.row];
    [cell refreshDataWith:model];
    
    return cell;
}

- (void)rechargeAction:(UIButton *)sender
{
    RechargeViewController *rechargeController = [[RechargeViewController alloc] init];
    rechargeController.lastMoney = self.balance;
    [self.navigationController pushViewController:rechargeController animated:YES];
}

- (void)depositAction:(UIButton *)sender
{
    DepositViewController *depositController = [[DepositViewController alloc] init];
    depositController.lastMoney = self.balance;
    [self.navigationController pushViewController:depositController animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView)
    {
        CGFloat sectionHeaderHeight = 234.6; //sectionHeaderHeight
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
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
