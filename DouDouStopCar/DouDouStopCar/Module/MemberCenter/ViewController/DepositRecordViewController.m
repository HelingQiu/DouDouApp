//
//  DepositRecordViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 17/3/20.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "DepositRecordViewController.h"
#import "CashOrPrivilCell.h"
#import "MemberCenterVM.h"
#import "ParkingRecordModel.h"

@interface DepositRecordViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger index;

@end

@implementation DepositRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"提现记录";
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.index = 0;
    self.dataSource = [NSMutableArray array];
    
    [self getDepositRecordData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.index = 0;
        [self getDepositRecordData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        [self getDepositRecordData];
    }];
}

- (void)getDepositRecordData
{
    NSDictionary *params = @{@"page":[NSNumber numberWithInteger:self.index]};
    [MemberCenterVM getCashRecordWithParameter:params completion:^(BOOL finish, id obj) {
        if (finish) {
            NSArray *array = obj;
            if (self.index == 0) {
                self.dataSource = [array mutableCopy];
            }else{
                [self.dataSource addObjectsFromArray:array];
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
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CashOrPrivilCell *cell = [CashOrPrivilCell cellForTableView:tableView];
    
    CashRecordModel *model = [self.dataSource objectAtIndex:indexPath.row];
    [cell refreshDataWith:model];
    
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
