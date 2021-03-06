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
#import "AppointmentViewController.h"
#import "DouDouButton.h"

@interface HomeViewController ()
{
    UIScrollView *_scrollView;
}
@property (strong, nonatomic) JJSAdsView *adsView;//banner图
@property (nonatomic, strong) NSArray *imgArray;
@property (nonatomic, strong) NSArray *carArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"NOCARD";
    [self.backBtn setHidden:YES];
    
    self.carArray = @[@"粤L-15W85",@"粤L-5V790",@"粤L-2Y276"];
    [self setConfigView];
    [self getAdsData];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES];
}

- (void)setConfigView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight - 64 - 49)];
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    
    [self setupAdsView];
    
    CGFloat width = (mScreenWidth - 30)/2;
    CGFloat viewY = 160 + 14;
    CGFloat height = width/2.1;
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(10, viewY, width, height)];
    [leftButton setImage:[UIImage imageNamed:@"home_find_car"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:leftButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(10 + width + 10, viewY, width, height)];
    [rightButton setImage:[UIImage imageNamed:@"home_yy_car"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:rightButton];
    
    UIImageView *backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(leftButton.frame) + 10, mScreenWidth - 20, 280)];
    [backImgView setImage:[UIImage imageNamed:@"home_back_normal"]];
    [_scrollView addSubview:backImgView];
    
    [backImgView addSubview:[CommonUtils getSeparator:kHexColor(@"#6d97fd") frame:CGRectMake(0, 40, mScreenWidth - 20, 1)]];
    
    UIScrollView *carScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 41, mScreenWidth - 20, 320 - 51)];
    carScrollView.contentSize = CGSizeMake((mScreenWidth - 20) * 3, 0);
    carScrollView.pagingEnabled = YES;
    [backImgView addSubview:carScrollView];
    
    //三种情况 未登录 没有数据 有数据
    CGFloat itemWidth = (mScreenWidth - 20)/3;
    [self.carArray enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(itemWidth * idx, 0, itemWidth, 40)];
        [button setBackgroundImage:[CommonUtils imageWithColor:[UIColor whiteColor] Size:CGRectMake(0, 0, 1, 1)] forState:UIControlStateNormal];
        [button setBackgroundImage:[CommonUtils imageWithColor:kHexColor(kColor_Mian) Size:CGRectMake(0, 0, 1, 1)] forState:UIControlStateSelected];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:obj forState:UIControlStateNormal];
        [backImgView addSubview:button];
        
        if (idx == 0) {
            button.selected = YES;
        }
        
        UILabel *labTime = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, mScreenWidth - 64 - 10 - 10 - 10 - 20, 30)];
        [labTime setText:@"已泊时间：00：35"];
        [labTime setFont:[UIFont systemFontOfSize:16]];
        [carScrollView addSubview:labTime];
        
        UILabel *labPrice = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, mScreenWidth - 64 - 10 - 10 - 10 - 20, 30)];
        [labPrice setText:@"费     用：10元"];
        [labPrice setFont:[UIFont systemFontOfSize:16]];
        [carScrollView addSubview:labPrice];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(mScreenWidth - 10 - 64 - 40, 30, 64, 64)];
        [imageView setImage:[UIImage imageNamed:@"timer_normal"]];
        [carScrollView addSubview:imageView];
        
        CGFloat width = [CommonUtils widthForString:@"城市停车广场卧槽卧槽我草草" Font:[UIFont systemFontOfSize:16] andWidth:mScreenWidth - 40];
        UILabel *labParkName = [[UILabel alloc] initWithFrame:CGRectMake(mScreenWidth - 30 - width, CGRectGetMaxY(imageView.frame) + 15, width, 20)];
        [labParkName setFont:[UIFont systemFontOfSize:16]];
        [labParkName setText:@"城市停车广场卧槽卧槽我草草"];
        [labParkName setTextColor:[UIColor blackColor]];
        [carScrollView addSubview:labParkName];
        
        UIImageView *locView = [[UIImageView alloc] initWithFrame:CGRectMake(mScreenWidth - 30 - width - 15 , CGRectGetMaxY(imageView.frame) + 15, 12, 20)];
        [locView setImage:[UIImage imageNamed:@"home_loc"]];
        [carScrollView addSubview:locView];
        
        [carScrollView addSubview:[CommonUtils getSeparator:kHexColor(@"#6d97fd") frame:CGRectMake(0, CGRectGetMaxY(locView.frame) + 20, mScreenWidth - 20, 1)]];
        
        UILabel *labLockCar = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(locView.frame) + 50, 40, 30)];
        [labLockCar setTextColor:kHexColor(@"#6d97fd")];
        
    }];
    
    [_scrollView setContentSize:CGSizeMake(0, CGRectGetMaxY(leftButton.frame) + 10 + 330)];
}

- (void)setupAdsView
{
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
    
    [_scrollView addSubview:self.adsView];
}

//获取广告图片
- (void)getAdsData
{
    [HomeVM getAdsDataWithParameter:nil completion:^(BOOL finish, id obj) {
        if (finish) {
            self.imgArray = [obj copy];
            [self setupAdsView];
        }
    }];
}

- (void)leftAction:(UIButton *)sender
{
    FindParkingViewController *parkingController = [[FindParkingViewController alloc] init];
    [self.navigationController pushViewController:parkingController animated:YES];
}

- (void)rightAction:(UIButton *)sender
{
    AppointmentViewController *appointController = [[AppointmentViewController alloc] init];
    [self.navigationController pushViewController:appointController animated:YES];
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
