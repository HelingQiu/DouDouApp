//
//  StopRecordViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/20.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "StopRecordViewController.h"
#import "StopCarCell.h"
#import "MemberCenterVM.h"
#import "ParkingRecordModel.h"

@interface StopRecordViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger index;

@end

@implementation StopRecordViewController

+ (instancetype)createByNibFile{
    
    return [[UIStoryboard storyboardWithName:@"MemberCenter" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"StopRecordVC"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"停车记录";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.index = 0;
    self.dataSource = [NSMutableArray array];
    [self getParkingRecord];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.index = 0;
        [self getParkingRecord];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        [self getParkingRecord];
    }];
}

- (void)getParkingRecord
{
    NSDictionary *params = @{@"page":[NSNumber numberWithInteger:self.index]};
    [MemberCenterVM getParkingRecordWithParameter:params completion:^(BOOL finish, id obj) {
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
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StopCarCell *cell = [StopCarCell cellForTableView:tableView];
    
    ParkingRecordModel *model = [self.dataSource objectAtIndex:indexPath.row];
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
