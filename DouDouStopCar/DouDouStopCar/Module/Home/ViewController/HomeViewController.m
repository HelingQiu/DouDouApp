//
//  HomeViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/19.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "HomeViewController.h"
#import "JJSAdsView.h"
#import "NewsViewController.h"
#import "HomeVM.h"
#import "AdsDataModel.h"
#import "FindParkingViewController.h"

@interface HomeViewController ()

@property (strong, nonatomic) JJSAdsView *adsView;//banner图
@property (nonatomic, strong) NSArray *imgArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"豆豆停车";
    [self.backBtn setHidden:YES];
    
    [self getAdsData];
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

//获取广告图片
- (void)getAdsData
{
    [HomeVM getAdsDataWithParameter:nil completion:^(BOOL finish, id obj) {
        if (finish) {
            self.imgArray = [obj copy];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];
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
        if (self.adsView) {
            [self.adsView removeFromSuperview];
        }
        self.adsView = [[JJSAdsView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 160) animationDuration:5 pagesCount:self.imgArray.count?:1];
        self.adsView.contentMode = UIViewContentModeScaleToFill;
        
        __weak typeof(self) weakSelf = self;
        self.adsView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
            CGRect frame = (CGRect){
                .origin.x = 0,
                .origin.y = 0,
                .size.width =  mScreenWidth,
                .size.height = 160
            };
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
            
            if (weakSelf.imgArray.count > pageIndex) {
                AdsDataModel *model = [weakSelf.imgArray objectAtIndex:pageIndex];
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:model.adUrl] placeholderImage:[UIImage imageNamed:@"image_banner_default"] options:SDWebImageAllowInvalidSSLCertificates];
            }
            
            
            return imageView;
        };
        self.adsView.totalPagesCount = ^NSInteger(void){
            
            return [weakSelf.imgArray count]?:1;
            
        };
        self.adsView.ClickActionBlock = ^(NSInteger index){
            AdsDataModel *model = [weakSelf.imgArray objectAtIndex:index];
            
            NewsViewController *newsContrller = [[NewsViewController alloc] init];
            newsContrller.urlstring = model.adLinkUrl;
            newsContrller.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:newsContrller animated:YES];
            
        };
        [cell.contentView insertSubview:self.adsView atIndex:0];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES];
    if (indexPath.section == 1)
    {
        FindParkingViewController *parkingController = [[FindParkingViewController alloc] init];
        [self.navigationController pushViewController:parkingController animated:YES];
    }
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
