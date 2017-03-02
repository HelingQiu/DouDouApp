//
//  ParkingDetailViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/3/2.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "ParkingDetailViewController.h"

@interface ParkingDetailViewController ()
{
    UIImageView *_imgView;
    UILabel *_parkingName;
    UILabel *_totalCarNumber;
    UILabel *_emptyCarNumber;
    
    UILabel *_labType;
    UILabel *_labPrice;
    UILabel *_labLocation;
}

@end

@implementation ParkingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"停车场详情";
    [self setConfigView];
}

- (void)setConfigView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight - 64 - 44)];
    scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:scrollView];
    
    _imgView = [[UIImageView alloc] init];
    [scrollView addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView.mas_top).with.offset(0);
        make.left.equalTo(scrollView.mas_left).with.offset(0);
        make.right.equalTo(scrollView.mas_right).with.offset(0);
        make.height.mas_equalTo(175);
    }];
    [_imgView setImage:[UIImage imageNamed:@"home"]];
    
    _parkingName = [[UILabel alloc] init];
    [_parkingName setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [_parkingName setTextColor:[UIColor whiteColor]];
    [_parkingName setFont:[UIFont boldSystemFontOfSize:20]];
    [scrollView addSubview:_parkingName];
    [_parkingName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_imgView.mas_bottom).with.offset(0);
        make.left.equalTo(_imgView.mas_left).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-55);
        make.height.mas_equalTo(30);
    }];
    [_parkingName setText:@"kjfalfjl"];
    
    UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectButton setImage:[UIImage imageNamed:@"__icon_u22"] forState:UIControlStateNormal];
    [collectButton setImage:[UIImage imageNamed:@"__icon_u22_selected"] forState:UIControlStateSelected];
    [collectButton setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [scrollView addSubview:collectButton];
    [collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_imgView.mas_bottom).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(- 15);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    UIView *topView = [[UIView alloc] init];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [scrollView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgView.mas_bottom).with.offset(0);
        make.left.equalTo(scrollView.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(70);
    }];
    
    _totalCarNumber = [[UILabel alloc] init];
    _totalCarNumber.font = [UIFont boldSystemFontOfSize:20];
    _totalCarNumber.textColor = [UIColor blackColor];
    _totalCarNumber.textAlignment = NSTextAlignmentCenter;
    _totalCarNumber.text = @"380";
    [topView addSubview:_totalCarNumber];
    [_totalCarNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_top).with.offset(10);
        make.left.equalTo(topView.mas_left).with.offset(0);
        make.width.mas_equalTo(mScreenWidth/2);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *labTotal = [[UILabel alloc] init];
    labTotal.font = [UIFont boldSystemFontOfSize:16];
    labTotal.textColor = kHexColor(kColor_Text);
    labTotal.textAlignment = NSTextAlignmentCenter;
    labTotal.text = @"总车位";
    [topView addSubview:labTotal];
    [labTotal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_top).with.offset(40);
        make.left.equalTo(topView.mas_left).with.offset(0);
        make.width.mas_equalTo(mScreenWidth/2);
        make.height.mas_equalTo(20);
    }];
    
    _emptyCarNumber = [[UILabel alloc] init];
    _emptyCarNumber.font = [UIFont boldSystemFontOfSize:20];
    _emptyCarNumber.textColor = [UIColor blackColor];
    _emptyCarNumber.textAlignment = NSTextAlignmentCenter;
    _emptyCarNumber.text = @"367";
    [topView addSubview:_emptyCarNumber];
    [_emptyCarNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_top).with.offset(10);
        make.left.equalTo(_totalCarNumber.mas_right).with.offset(0);
        make.width.mas_equalTo(mScreenWidth/2);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *labEmpty = [[UILabel alloc] init];
    labEmpty.font = [UIFont boldSystemFontOfSize:16];
    labEmpty.textColor = kHexColor(kColor_Text);
    labEmpty.textAlignment = NSTextAlignmentCenter;
    labEmpty.text = @"空车位";
    [topView addSubview:labEmpty];
    [labEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_top).with.offset(40);
        make.left.equalTo(_totalCarNumber.mas_right).with.offset(0);
        make.width.mas_equalTo(mScreenWidth/2);
        make.height.mas_equalTo(20);
    }];
    
    [topView addSubview:[CommonUtils getSeparator:kHexColor(kColor_Text) frame:CGRectMake(mScreenWidth/2 - 0.5, 10, 1, 50)]];
    
    UIView *midView = [[UIView alloc] init];
    midView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:midView];
    [midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).with.offset(24);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.width.mas_equalTo(mScreenWidth);
        make.height.mas_equalTo(180);
    }];
    
    UILabel *labTypeTip = [[UILabel alloc] init];
    labTypeTip.font = [UIFont boldSystemFontOfSize:16];
    labTypeTip.textColor = kHexColor(kColor_Text);
    labTypeTip.text = @"类型";
    [midView addSubview:labTypeTip];
    [labTypeTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midView.mas_top).with.offset(0);
        make.left.equalTo(midView.mas_left).with.offset(15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(60);
    }];
    
    _labType = [[UILabel alloc] init];
    _labType.font = [UIFont boldSystemFontOfSize:16];
    _labType.textColor = [UIColor blackColor];
    _labType.text = @"收费停车场";
    _labType.numberOfLines = 0;
    [midView addSubview:_labType];
    [_labType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midView.mas_top).with.offset(5);
        make.left.equalTo(labTypeTip.mas_right).with.offset(10);
        make.width.mas_equalTo(mScreenWidth - 80);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *labPriceTip = [[UILabel alloc] init];
    labPriceTip.font = [UIFont boldSystemFontOfSize:16];
    labPriceTip.textColor = kHexColor(kColor_Text);
    labPriceTip.text = @"价格";
    [midView addSubview:labPriceTip];
    [labPriceTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midView.mas_top).with.offset(60);
        make.left.equalTo(midView.mas_left).with.offset(15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(60);
    }];
    
    _labPrice = [[UILabel alloc] init];
    _labPrice.font = [UIFont boldSystemFontOfSize:16];
    _labPrice.textColor = [UIColor blackColor];
    _labPrice.text = @"首3小时内5元每小时，之后每小时1元，全天最高25元";
    _labPrice.numberOfLines = 0;
    [midView addSubview:_labPrice];
    [_labPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midView.mas_top).with.offset(65);
        make.left.equalTo(labPriceTip.mas_right).with.offset(10);
        make.width.mas_equalTo(mScreenWidth - 80);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *labLocationTip = [[UILabel alloc] init];
    labLocationTip.font = [UIFont boldSystemFontOfSize:16];
    labLocationTip.textColor = kHexColor(kColor_Text);
    labLocationTip.text = @"位置";
    [midView addSubview:labLocationTip];
    [labLocationTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midView.mas_top).with.offset(120);
        make.left.equalTo(midView.mas_left).with.offset(15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(60);
    }];
    
    _labLocation = [[UILabel alloc] init];
    _labLocation.font = [UIFont boldSystemFontOfSize:16];
    _labLocation.textColor = [UIColor blackColor];
    _labLocation.text = @"广东省深圳市龙华新区龙冠一路";
    _labLocation.numberOfLines = 0;
    [midView addSubview:_labLocation];
    [_labLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midView.mas_top).with.offset(125);
        make.left.equalTo(labLocationTip.mas_right).with.offset(10);
        make.width.mas_equalTo(mScreenWidth - 80);
        make.height.mas_equalTo(50);
    }];
    
    [midView addSubview:[CommonUtils getSeparator:kHexColor(kColor_Text) frame:CGRectMake(0, 60, mScreenWidth, 0.5)]];
    [midView addSubview:[CommonUtils getSeparator:kHexColor(kColor_Text) frame:CGRectMake(0, 120, mScreenWidth, 0.5)]];
    
    [scrollView setContentSize:CGSizeMake(0, CGRectGetMaxY(midView.frame) + 20)];
    
    UIImageView *backView = [[UIImageView alloc] init];
    [backView setImage:[UIImage imageNamed:@"parking_detail_btn_back"]];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.width.mas_equalTo(mScreenWidth);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *roadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [roadButton setTitle:@"路线" forState:UIControlStateNormal];
    [roadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    roadButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:roadButton];
    [roadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.width.mas_equalTo(mScreenWidth/2);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *dirButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dirButton setTitle:@"导航" forState:UIControlStateNormal];
    [dirButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dirButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:dirButton];
    [dirButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(roadButton.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.width.mas_equalTo(mScreenWidth/2);
        make.height.mas_equalTo(44);
    }];
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
