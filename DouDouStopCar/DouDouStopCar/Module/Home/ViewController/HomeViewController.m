//
//  HomeViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/19.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"豆豆停车";
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 160;
    }else if (indexPath.section == 1) {
        return 80;
    }
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (indexPath.section == 0) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 160)];
        [imgView setImage:[UIImage imageNamed:@"home"]];
        [cell.contentView addSubview:imgView];
    }else if (indexPath.section == 1) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, mScreenWidth/2 - 20, 60)];
        [imgView setImage:[UIImage imageNamed:@"home1"]];
        [cell.contentView addSubview:imgView];
        
        UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(mScreenWidth/2 + 10, 10, mScreenWidth/2 - 20, 60)];
        [imgView2 setImage:[UIImage imageNamed:@"home2"]];
        [cell.contentView addSubview:imgView2];
    }else{
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 200)];
        [imgView setImage:[UIImage imageNamed:@"home3"]];
        [cell.contentView addSubview:imgView];
    }
    
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
