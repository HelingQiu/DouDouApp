//
//  MonthCardViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/21.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "MonthCardViewController.h"
#import "MonthCardCell.h"
#import "ChargeMonthViewController.h"
#import "MemberCenterVM.h"

@interface MonthCardViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation MonthCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"月卡";
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getMonthCardData];
}

- (void)getMonthCardData
{
    NSDictionary *params = @{@"page":@"1"};
    [MemberCenterVM getMonthCardListWithParameter:params completion:^(BOOL finish, id obj) {
        if (finish) {
            self.dataSource = [obj copy];
            [self.tableView reloadData];
        }
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
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MonthCardCell *cell = [MonthCardCell cellForTableView:tableView];
    
    MonthCardModel *model = [self.dataSource objectAtIndex:indexPath.row];
    [cell refreshDataWith:model];
    cell.block = ^(){
        //去充值
        ChargeMonthViewController *chargeController = [[ChargeMonthViewController alloc] init];
        [self.navigationController pushViewController:chargeController animated:YES];
    };
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
