//
//  PrivilegeViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/21.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "PrivilegeViewController.h"
#import "RFSegmentView.h"
#import "PrivilegeCell.h"
#import "MemberCenterVM.h"
#import "ParkingRecordModel.h"
#import "RoleInfoViewController.h"

@interface PrivilegeViewController ()<RFSegmentViewDelegate>

@property (nonatomic, strong) RFSegmentView* segmentView;

@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) NSMutableArray *leftArray;
@property (nonatomic, strong) NSMutableArray *rightArray;

@property (nonatomic, assign) NSInteger leftIndex;
@property (nonatomic, assign) NSInteger rightIndex;

@end

@implementation PrivilegeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.selectIndex = 0;
    self.leftIndex = 0;
    self.leftArray = [NSMutableArray array];
    
    self.rightIndex = 0;
    self.rightArray = [NSMutableArray array];
    
    [self getRechargeInfo];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.selectIndex == 0) {
            self.leftIndex = 0;
            [self getRechargeInfo];
        }else{
            self.rightIndex = 0;
            [self getStopCarchargeInfo];
        }
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.selectIndex == 0) {
            self.leftIndex ++;
            [self getRechargeInfo];
        }else{
            self.rightIndex ++;
            [self getStopCarchargeInfo];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.segmentView = [[RFSegmentView alloc] initWithFrame:CGRectMake(mScreenWidth/2 - 80, 7, 200, 30) items:@[@"优惠券",@"停车劵"]];
    self.segmentView.tintColor = kHexColor(@"#ffba07");
    self.segmentView.delegate = self;
    [self.navigationController.navigationBar addSubview:self.segmentView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.segmentView.delegate = nil;
    [self.segmentView removeFromSuperview];
}

- (void)segmentViewSelectIndex:(NSInteger)index
{
    NSLog(@"current index is %ld",(long)index);
    self.selectIndex = index;
    if (self.selectIndex == 1) {
        if (!self.rightArray.count) {
            [self getStopCarchargeInfo];
        }else{
            [self.tableView reloadData];
        }
    }else{
        [self.tableView reloadData];
    }
}

- (void)getRechargeInfo
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    NSDictionary *params = @{@"couponType":@"0",
                             @"page":[NSNumber numberWithInteger:self.leftIndex],
                             @"token":token};
    [MemberCenterVM getRechargeListWithParameter:params completion:^(BOOL finish, id obj) {
        if (finish) {
            NSArray *array = obj;
            if (self.leftIndex == 0) {
                self.leftArray = [array mutableCopy];
            }else{
                [self.leftArray addObjectsFromArray:array];
            }
            if (array.count == 0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)getStopCarchargeInfo
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    NSDictionary *params = @{@"couponType":@"1",
                             @"page":[NSNumber numberWithInteger:self.rightIndex],
                             @"token":token};
    [MemberCenterVM getRechargeListWithParameter:params completion:^(BOOL finish, id obj) {
        if (finish) {
            NSArray *array = obj;
            if (self.rightIndex == 0) {
                self.rightArray = [array mutableCopy];
            }else{
                [self.rightArray addObjectsFromArray:array];
            }
            if (array.count == 0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.selectIndex == 1) {
        return self.rightArray.count;
    }
    return self.leftArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.selectIndex == 0) {
        if (!self.leftArray.count) {
            return nil;
        }
    }
    if (self.selectIndex == 1) {
        if (!self.rightArray.count) {
            return nil;
        }
    }
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 30)];
    [headView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(mScreenWidth - 80, 7, 16, 16)];
    [imgView setImage:[UIImage imageNamed:@"privilege_help"]];
    [headView addSubview:imgView];
    
    UILabel *labTip = [[UILabel alloc] initWithFrame:CGRectMake(mScreenWidth - 60, 7, 50, 16)];
    [labTip setFont:[UIFont systemFontOfSize:12]];
    [labTip setTextColor:kHexColor(@"#bbbbbb")];
    [labTip setText:@"使用规则"];
    [labTip setUserInteractionEnabled:YES];
    [headView addSubview:labTip];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(usePolicyAction:)];
    [labTip addGestureRecognizer:recognizer];
    
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PrivilegeCell *cell = [PrivilegeCell cellForTableView:tableView];
    
    if (self.selectIndex == 0) {
        RechargeModel *model = [self.leftArray objectAtIndex:indexPath.row];
        [cell refreshDataWith:model];
    }else{
        RechargeModel *model = [self.rightArray objectAtIndex:indexPath.row];
        [cell refreshDataWith:model];
    }
    
    return cell;
}

//使用规则
- (void)usePolicyAction:(UITapGestureRecognizer *)recognizer
{
    RoleInfoViewController *roleController = [[RoleInfoViewController alloc] init];
    roleController.roleType = 2;
    [self.navigationController pushViewController:roleController animated:YES];
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
