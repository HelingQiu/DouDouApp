//
//  CarNumberViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/21.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "CarNumberViewController.h"
#import "CarNumberCell.h"
#import "DouDouButton.h"
#import "AddCarNumberViewController.h"
#import "MemberCenterVM.h"
#import "ParkingRecordModel.h"

@interface CarNumberViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation CarNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的车辆";
    
    [self setConfigView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getCarListData];
}

- (void)setConfigView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight - 64 - 60) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_tableView];
    
    DouDouButton *button = [DouDouButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, mScreenHeight - 60 - 64, mScreenWidth, 60)];
    [button setImageViewRect:CGRectMake(mScreenWidth/2 - 60, 15, 30, 30)];
    [button setImage:[UIImage imageNamed:@"wallet"] forState:UIControlStateNormal];
    [button setTitleLabelRect:CGRectMake(mScreenWidth/2 - 20, 15, 80, 30)];
    [button setTitle:@"添加车牌" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(addCarNumberAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)addCarNumberAction
{
    AddCarNumberViewController *addCarController = [[AddCarNumberViewController alloc] init];
    [self.navigationController pushViewController:addCarController animated:YES];
}

- (void)getCarListData
{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouUserId];
    NSDictionary *params = @{@"userId":userId?:@""};
    [MemberCenterVM getCarListWithParameter:params completion:^(BOOL finish, id obj) {
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarNumberCell *cell = [CarNumberCell cellForTableView:tableView];
    PlateNumberModel *model = [self.dataSource objectAtIndex:indexPath.section];
    [cell refreshDataWith:model];
    
    MGSwipeButton *fixButton = [MGSwipeButton buttonWithTitle:@"修改" backgroundColor:[UIColor lightGrayColor] callback:^BOOL(MGSwipeTableCell *sender) {
        
        AddCarNumberViewController *addCarController = [[AddCarNumberViewController alloc] init];
        addCarController.model = model;
        [self.navigationController pushViewController:addCarController animated:YES];
        
        return YES;
    }];
    
    MGSwipeButton *deleteButton = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor] callback:^BOOL(MGSwipeTableCell *sender) {
        
        NSDictionary *params = @{@"plateNumber":model.plateNumber};
        [MemberCenterVM deleteCarNumberWithParameter:params completion:^(BOOL finish, id obj) {
            if (finish) {
                [self getCarListData];
            }
        }];
        
        return YES;
    }];
    
    cell.rightButtons = @[fixButton,
                          deleteButton];
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
