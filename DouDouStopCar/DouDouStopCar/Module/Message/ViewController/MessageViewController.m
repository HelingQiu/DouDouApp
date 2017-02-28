//
//  MessageViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/19.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "MessageVM.h"
#import "MessageModel.h"

@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation MessageViewController

+ (instancetype)createByNibFile{
    
    return [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MessageVC"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"消息";
    [self.backBtn setHidden:YES];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self getMessageListData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView setFrame:CGRectMake(0, 64, mScreenWidth, mScreenHeight - 49 - 64)];
    [[[UIApplication sharedApplication] keyWindow] setBackgroundColor:[UIColor whiteColor]];
}

- (void)getMessageListData
{
    NSDictionary *params = @{@"page":@"1"};
    [MessageVM getMessageListWithParameter:params completion:^(BOOL finish, id obj) {
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
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = [MessageTableViewCell cellForTableView:tableView];
    
    MessageModel *model = [self.dataSource objectAtIndex:indexPath.row];
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
