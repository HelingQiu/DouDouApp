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

@property (nonatomic, strong) NSArray *dataSource;

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
    
    [self getParkingRecord];
}

- (void)getParkingRecord
{
    NSDictionary *params = @{@"page":@"1"};
    [MemberCenterVM getParkingRecordWithParameter:params completion:^(BOOL finish, id obj) {
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
