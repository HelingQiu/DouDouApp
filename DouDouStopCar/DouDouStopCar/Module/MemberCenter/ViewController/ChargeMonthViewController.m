//
//  ChargeMonthViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/27.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "ChargeMonthViewController.h"
#import "DouDouButton.h"

@interface ChargeMonthViewController ()

@property (nonatomic, strong) UIButton *packRightButton;
@property (nonatomic, strong) UIButton *aliyRightButton;
@property (nonatomic, strong) UIButton *wxRightButton;

@property (nonatomic, strong) UIButton *midButton;//充值月数
@property (nonatomic, strong) UILabel *labAmount;//底部金额

@property (nonatomic, assign) NSInteger monthCount;

@end

@implementation ChargeMonthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"月卡充值";
    self.monthCount = 1;
    [self setConfigView];
}

- (void)setConfigView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight - 64 - 76)];
    scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:scrollView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 193)];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [scrollView addSubview:topView];
    
    UILabel *labTopL = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 80, 16)];
    [labTopL setFont:[UIFont boldSystemFontOfSize:16]];
    [labTopL setText:@"月卡金额:"];
    [labTopL setTextColor:[UIColor blackColor]];
    [topView addSubview:labTopL];
    
    UILabel *labTopR = [[UILabel alloc] initWithFrame:CGRectMake(mScreenWidth - 15 - 25, 15, 25, 16)];
    [labTopR setFont:[UIFont boldSystemFontOfSize:14]];
    [labTopR setText:@"/月"];
    [labTopR setTextColor:[UIColor blackColor]];
    [topView addSubview:labTopR];
    
    UILabel *labTopM = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labTopL.frame) + 10, 15, mScreenWidth - CGRectGetMaxX(labTopL.frame) - 50, 16)];
    [labTopM setFont:[UIFont boldSystemFontOfSize:14]];
    [labTopM setText:@"100.00元"];
    [labTopM setTextAlignment:NSTextAlignmentRight];
    [labTopM setTextColor:kHexColor(@"#f67110")];
    [topView addSubview:labTopM];
    
    [topView addSubview:[CommonUtils getSeparator:[UIColor groupTableViewBackgroundColor] frame:CGRectMake(0, CGRectGetMaxY(labTopL.frame) + 14, mScreenWidth, 1)]];
    
    UILabel *labMonnum = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(labTopL.frame) + 25, 80, 40)];
    [labMonnum setFont:[UIFont boldSystemFontOfSize:16]];
    [labMonnum setText:@"充值月数:"];
    [labMonnum setTextColor:[UIColor blackColor]];
    [topView addSubview:labMonnum];
    
    CGFloat backWidth = mScreenWidth - 30 - labMonnum.width - 10;
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labMonnum.frame) + 10, CGRectGetMaxY(labTopL.frame) + 25, backWidth, 40)];
    [backView setImage:[UIImage imageNamed:@"month_btn_back"]];
    [backView setUserInteractionEnabled:YES];
    [topView addSubview:backView];
    
    CGFloat itemWidth = (mScreenWidth - 30 - labMonnum.width - 10)/3;
    UIButton *minButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [minButton setFrame:CGRectMake(0, 0, itemWidth, 40)];
    [minButton setTitle:@"➖" forState:UIControlStateNormal];
    [minButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [minButton addTarget:self action:@selector(minAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:minButton];
    
    self.midButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.midButton setFrame:CGRectMake(itemWidth + 2, 2, itemWidth - 4, 36)];
    [self.midButton setTitle:[NSString stringWithFormat:@"%ld",(long)self.monthCount] forState:UIControlStateNormal];
    [self.midButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.midButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.midButton setBackgroundImage:[UIImage imageNamed:@"month_btn_mid_back"] forState:UIControlStateNormal];
    [backView addSubview:self.midButton];
    
    UIButton *maxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [maxButton setFrame:CGRectMake(itemWidth * 2, 0, itemWidth, 40)];
    [maxButton setTitle:@"➕" forState:UIControlStateNormal];
    [maxButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [maxButton setBackgroundImage:[UIImage imageNamed:@"month_btn_right_back"] forState:UIControlStateNormal];
    [maxButton addTarget:self action:@selector(maxAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:maxButton];
    
    UILabel *labTime = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labMonnum.frame) + 10 + itemWidth, CGRectGetMaxY(backView.frame) + 5, itemWidth * 2, 14)];
    [labTime setFont:kFontSize(13)];
    [labTime setTextColor:kHexColor(kColor_Text)];
    [labTime setText:@"延至2017-02-17"];
    [topView addSubview:labTime];
    
    UILabel *labPayL = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(labTime.frame) + 25, 80, 16)];
    [labPayL setFont:[UIFont boldSystemFontOfSize:16]];
    [labPayL setText:@"需支付:"];
    [labPayL setTextColor:[UIColor blackColor]];
    [topView addSubview:labPayL];
    
    UILabel *labPayR = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labPayL.frame) + 10, CGRectGetMaxY(labTime.frame) + 25, mScreenWidth - CGRectGetMaxX(labPayL.frame) - 30, 16)];
    [labPayR setFont:[UIFont boldSystemFontOfSize:16]];
    [labPayR setText:@"100.00元"];
    [labPayR setTextAlignment:NSTextAlignmentRight];
    [labPayR setTextColor:kHexColor(@"#f67110")];
    [topView addSubview:labPayR];
    
    UILabel *labBottomTip = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(labPayR.frame) + 10, mScreenWidth - 30, 16)];
    [labBottomTip setFont:kFontSize(14)];
    [labBottomTip setTextColor:kHexColor(kColor_Text)];
    [labBottomTip setText:@"(原价:100元,减免10.0元)"];
    [labBottomTip setTextAlignment:NSTextAlignmentRight];
    [topView addSubview:labBottomTip];
    
    UILabel *labMid = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(topView.frame) + 23 - 8, mScreenWidth - 30, 16)];
    [labMid setFont:[UIFont boldSystemFontOfSize:16]];
    [labMid setText:@"钱包支付"];
    [labMid setTextColor:[UIColor blackColor]];
    [scrollView addSubview:labMid];
    
    UIView *midView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame) + 46, mScreenWidth, 67)];
    [midView setBackgroundColor:[UIColor whiteColor]];
    [scrollView addSubview:midView];
    
    self.packRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.packRightButton setFrame:CGRectMake(mScreenWidth - 33, 66.5/2 - 9, 18, 18)];
    [self.packRightButton setImage:[UIImage imageNamed:@"recharge_unselected"] forState:UIControlStateNormal];
    [self.packRightButton setImage:[UIImage imageNamed:@"recharge_selected"] forState:UIControlStateSelected];
    self.packRightButton.selected = YES;
    [midView addSubview:self.packRightButton];
    
    DouDouButton *packButton = [DouDouButton buttonWithType:UIButtonTypeCustom];
    [packButton setFrame:CGRectMake(0, 0, mScreenWidth, 66.5)];
    [packButton setImageViewRect:CGRectMake(15, 66.5/2 - 13, 26, 26)];
    [packButton setTitleLabelRect:CGRectMake(56, 66.5/2 - 13, mScreenWidth - 100, 26)];
    [packButton setImage:[UIImage imageNamed:@"month_wallet"] forState:UIControlStateNormal];
    [packButton setTitle:@"钱包（余额：1.00元）" forState:UIControlStateNormal];
    [packButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [packButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [packButton addTarget:self action:@selector(packAction:) forControlEvents:UIControlEventTouchUpInside];
    [midView addSubview:packButton];
    
    UILabel *labOther = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(midView.frame) + 23 - 8, mScreenWidth - 30, 16)];
    [labOther setFont:[UIFont boldSystemFontOfSize:16]];
    [labOther setText:@"其他支付"];
    [labOther setTextColor:[UIColor blackColor]];
    [scrollView addSubview:labOther];
    
    UIView *botView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(midView.frame) + 46, mScreenWidth, 134)];
    [botView setBackgroundColor:[UIColor whiteColor]];
    [scrollView addSubview:botView];
    
    self.aliyRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.aliyRightButton setFrame:CGRectMake(mScreenWidth - 33, 66.5/2 - 9, 18, 18)];
    [self.aliyRightButton setImage:[UIImage imageNamed:@"recharge_unselected"] forState:UIControlStateNormal];
    [self.aliyRightButton setImage:[UIImage imageNamed:@"recharge_selected"] forState:UIControlStateSelected];
    [botView addSubview:self.aliyRightButton];
    
    DouDouButton *aliyButton = [DouDouButton buttonWithType:UIButtonTypeCustom];
    [aliyButton setFrame:CGRectMake(0, 0, mScreenWidth, 66.5)];
    [aliyButton setImageViewRect:CGRectMake(15, 66.5/2 - 13, 26, 26)];
    [aliyButton setTitleLabelRect:CGRectMake(56, 66.5/2 - 13, 100, 26)];
    [aliyButton setImage:[UIImage imageNamed:@"recharge_aliy_pay"] forState:UIControlStateNormal];
    [aliyButton setTitle:@"支付宝" forState:UIControlStateNormal];
    [aliyButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [aliyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [aliyButton addTarget:self action:@selector(aliyAction:) forControlEvents:UIControlEventTouchUpInside];
    [botView addSubview:aliyButton];
    
    [botView addSubview:[CommonUtils getSeparator:kHexColor(kColor_Gray) frame:CGRectMake(0, 66.5, mScreenWidth, 1)]];
    
    self.wxRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.wxRightButton setFrame:CGRectMake(mScreenWidth - 33, 67.5 + 66.5/2 - 9, 18, 18)];
    [self.wxRightButton setImage:[UIImage imageNamed:@"recharge_unselected"] forState:UIControlStateNormal];
    [self.wxRightButton setImage:[UIImage imageNamed:@"recharge_selected"] forState:UIControlStateSelected];
    [botView addSubview:self.wxRightButton];
    
    DouDouButton *wxButton = [DouDouButton buttonWithType:UIButtonTypeCustom];
    [wxButton setFrame:CGRectMake(0, 67.5, mScreenWidth, 66.5)];
    [wxButton setImageViewRect:CGRectMake(15, 66.5/2 - 13, 26, 26)];
    [wxButton setTitleLabelRect:CGRectMake(56, 66.5/2 - 13, 100, 26)];
    [wxButton setImage:[UIImage imageNamed:@"recharge_wx_pay"] forState:UIControlStateNormal];
    [wxButton setTitle:@"微信支付" forState:UIControlStateNormal];
    [wxButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [wxButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [wxButton addTarget:self action:@selector(wxAction:) forControlEvents:UIControlEventTouchUpInside];
    [botView addSubview:wxButton];
    
    [scrollView setContentSize:CGSizeMake(0, CGRectGetMaxY(botView.frame) + 20)];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, mScreenHeight - 64 - 76, mScreenWidth, 76)];
    [bottomView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bottomView];
    
    UILabel *labReuslt = [[UILabel alloc] initWithFrame:CGRectMake(15, 18, 80, 40)];
    [labReuslt setFont:[UIFont boldSystemFontOfSize:16]];
    [labReuslt setText:@"应付总额:"];
    [labReuslt setTextColor:[UIColor blackColor]];
    [bottomView addSubview:labReuslt];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setFrame:CGRectMake(mScreenWidth - 135, 18, 120, 40)];
    [submitButton setBackgroundColor:kHexColor(kColor_Mian)];
    [submitButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton setTitle:@"立即充值" forState:UIControlStateNormal];
    submitButton.layer.cornerRadius = 4;
    [submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:submitButton];
    
    self.labAmount = [[UILabel alloc] initWithFrame:CGRectMake(90, 16, mScreenWidth - 30 - 90 - 125, 40)];
    [self.labAmount setFont:[UIFont boldSystemFontOfSize:18]];
    [self.labAmount setText:@"100.00元"];
    [self.labAmount setTextColor:kHexColor(@"#f67110")];
    [bottomView addSubview:self.labAmount];
}

- (void)minAction:(UIButton *)sender
{
    if (self.monthCount > 1) {
        self.monthCount --;
        [self.midButton setTitle:[NSString stringWithFormat:@"%ld",(long)self.monthCount] forState:UIControlStateNormal];
    }
}

- (void)maxAction:(UIButton *)sender
{
    self.monthCount ++;
    [self.midButton setTitle:[NSString stringWithFormat:@"%ld",(long)self.monthCount] forState:UIControlStateNormal];
}

- (void)packAction:(UIButton *)sender
{
    self.packRightButton.selected = YES;
    self.aliyRightButton.selected = NO;
    self.wxRightButton.selected = NO;
}

- (void)aliyAction:(UIButton *)sender
{
    self.packRightButton.selected = NO;
    self.aliyRightButton.selected = YES;
    self.wxRightButton.selected = NO;
}

- (void)wxAction:(UIButton *)sender
{
    self.packRightButton.selected = NO;
    self.aliyRightButton.selected = NO;
    self.wxRightButton.selected = YES;
}

- (void)submitAction:(UIButton *)sender
{

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
