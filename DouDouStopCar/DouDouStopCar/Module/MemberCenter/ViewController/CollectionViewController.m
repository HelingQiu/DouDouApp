//
//  CollectionViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/20.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionCell.h"
#import "MemberCenterVM.h"
#import "ParkingRecordModel.h"

@interface CollectionViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation CollectionViewController

+ (instancetype)createByNibFile{
    
    return [[UIStoryboard storyboardWithName:@"MemberCenter" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"CollectionVC"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的收藏";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getMyCollectionListData];
}

- (void)getMyCollectionListData
{
    NSDictionary *params = @{@"page":@"1"};
    [MemberCenterVM getMyCollectionListWithParameter:params completion:^(BOOL finish, id obj) {
        if (finish) {
            self.dataSource = [obj copy];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = [CollectionCell cellForTableView:tableView];
    
    CollectionModel *model = [self.dataSource objectAtIndex:indexPath.section];
    [cell refreshDataWith:model];
    cell.block = ^(){
        //取消收藏
        NSDictionary *params = @{@"parkingId":model.parkingId};
        [MemberCenterVM deleteMyCollectionListWithParameter:params completion:^(BOOL finish, id obj) {
            if (finish) {
                [self performSelector:@selector(getMyCollectionListData) withObject:nil afterDelay:1.3];
            }
        }];
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
