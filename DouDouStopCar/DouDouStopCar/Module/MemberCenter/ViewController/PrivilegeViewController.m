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

@interface PrivilegeViewController ()<RFSegmentViewDelegate>

@property (nonatomic, strong) RFSegmentView* segmentView;

@end

@implementation PrivilegeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.segmentView = [[RFSegmentView alloc] initWithFrame:CGRectMake(50, 7, mScreenWidth - 100, 30) items:@[@"优惠券",@"停车劵"]];
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
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 14;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 14)];
    [headView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(mScreenWidth - 70, 2, 10, 10)];
    [imgView setImage:[UIImage imageNamed:@"privilege_help"]];
    [headView addSubview:imgView];
    
    UILabel *labTip = [[UILabel alloc] initWithFrame:CGRectMake(mScreenWidth - 60, 0, 50, 14)];
    [labTip setFont:[UIFont systemFontOfSize:10]];
    [labTip setTextColor:kHexColor(@"#bbbbbb")];
    [labTip setText:@"使用规则"];
    [headView addSubview:labTip];
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PrivilegeCell *cell = [PrivilegeCell cellForTableView:tableView];
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
