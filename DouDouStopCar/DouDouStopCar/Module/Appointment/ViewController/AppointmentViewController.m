//
//  AppointmentViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/3/2.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "AppointmentViewController.h"
#import "CollectionCell.h"

@interface AppointmentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation AppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    [self setConfigView];
}

- (void)setConfigView
{
    UIView *naviView = [[UIView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    naviView.backgroundColor = kHexColor(kColor_Mian);
    self.navigationItem.titleView = naviView;
    
    NSLog(@"nav width - %f", self.navigationController.navigationBar.frame.size.width); // 宽度
    UITextField *searchField = [[UITextField alloc] initWithFrame:CGRectMake(20, 7, self.navigationController.navigationBar.width - 100, 30)];
    [searchField setPlaceholder:@"停车场名字、地点"];
    [searchField setBackgroundColor:[UIColor whiteColor]];
    searchField.clipsToBounds = YES;
    searchField.layer.cornerRadius = 6;
    searchField.returnKeyType = UIKeyboardTypeWebSearch;
    [naviView addSubview:searchField];
    
    UIView *viewBg = [[UIView alloc] initWithFrame:(CGRect){0,0,25,30}];
    [viewBg setBackgroundColor:[UIColor clearColor]];
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:(CGRect){5, 5, 20, 20}];
    [leftView setImage:[UIImage imageNamed:@"find_parking_search"]];
    [viewBg addSubview:leftView];
    [searchField setLeftView:viewBg];
    [searchField setLeftViewMode:UITextFieldViewModeAlways];
}

- (UITableView *)tableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, mScreenWidth, mScreenHeight - 64 - 44) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return _tableView;
}

#pragma mark - 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
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
