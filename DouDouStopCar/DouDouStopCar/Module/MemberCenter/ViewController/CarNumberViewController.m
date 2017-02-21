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

@interface CarNumberViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CarNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的车辆";
    
    [self.view addSubview:self.tableView];
    [self setConfigView];
}

- (UITableView *)tableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight - 64 - 60) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return _tableView;
}

- (void)setConfigView
{
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

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarNumberCell *cell = [CarNumberCell cellForTableView:tableView];
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
