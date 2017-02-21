//
//  StopRecordViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/20.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "StopRecordViewController.h"
#import "StopCarCell.h"

@interface StopRecordViewController ()

@end

@implementation StopRecordViewController

+ (instancetype)createByNibFile{
    
    return [[UIStoryboard storyboardWithName:@"MemberCenter" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"StopRecordVC"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"停车记录";
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StopCarCell *cell = [StopCarCell cellForTableView:tableView];
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
