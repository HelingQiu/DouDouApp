//
//  DepositViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/26.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "DepositViewController.h"
#import "OBShapedButton.h"

@interface DepositViewController ()

@end

@implementation DepositViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"提现";
    [self setRightButton];
    [self setConfigView];
}

- (void)setRightButton
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 7, 80, 30);
    [rightButton setTitle:@"提现记录" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:kFontSize(14)];
    [rightButton setBackgroundColor:kHexColor(kColor_Mian)];
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setConfigView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight)];
    scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:scrollView];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 123.3)];
    [backView setBackgroundColor:kHexColor(kColor_Mian)];
    [scrollView addSubview:backView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(mScreenWidth/2 - 44.7/2, 20, 44.7, 53.3)];
    [imgView setImage:[UIImage imageNamed:@"deposit_card"]];
    [backView addSubview:imgView];
    
    UILabel *labTip = [[UILabel alloc] initWithFrame:CGRectMake(mScreenWidth/2 - 44.7/2 - 40, 123.3 - 30, 40, 15)];
    [labTip setText:@"余额"];
    [labTip setFont:kFontSize(15)];
    [labTip setTextColor:[UIColor whiteColor]];
    [backView addSubview:labTip];
    
    CGFloat moneyWidth = [CommonUtils widthForString:@"0.00" Font:kFontSize(33) andWidth:mScreenWidth];
    UILabel *labMoney = [[UILabel alloc] initWithFrame:CGRectMake(mScreenWidth/2 - 44.7/2, 123.3 - 45, moneyWidth, 33)];
    [labMoney setText:@"0.00"];
    [labMoney setFont:kFontSize(33)];
    [labMoney setTextColor:[UIColor whiteColor]];
    [backView addSubview:labMoney];
    
    UILabel *labUnit = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labMoney.frame) + 5, 123.3 - 30, 20, 15)];
    [labUnit setText:@"元"];
    [labUnit setFont:kFontSize(15)];
    [labUnit setTextColor:[UIColor whiteColor]];
    [backView addSubview:labUnit];
    
    CGFloat itemY = CGRectGetMaxY(backView.frame) + 15;
    CGFloat itemWidth = (mScreenWidth - 30 - 20)/3 + 10;
    CGFloat itemHeight = 33;
    
    OBShapedButton *aliyButton = [OBShapedButton buttonWithType:UIButtonTypeCustom];
    [aliyButton setFrame:CGRectMake(15, itemY, itemWidth, itemHeight)];
    [aliyButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [aliyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [aliyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [aliyButton setTitle:@"支付宝" forState:UIControlStateNormal];
    [aliyButton setBackgroundImage:[UIImage imageNamed:@"deposit_sharpbutton_unselected"] forState:UIControlStateNormal];
    [aliyButton setBackgroundImage:[UIImage imageNamed:@"deposit_sharpbutton_selected"] forState:UIControlStateSelected];
    [aliyButton setSelected:YES];
    [scrollView addSubview:aliyButton];
    
    OBShapedButton *wxButton = [OBShapedButton buttonWithType:UIButtonTypeCustom];
    [wxButton setFrame:CGRectMake(CGRectGetMaxX(aliyButton.frame) - 5, itemY, itemWidth, itemHeight)];
    [wxButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [wxButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [wxButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [wxButton setTitle:@"微信" forState:UIControlStateNormal];
    [wxButton setBackgroundImage:[UIImage imageNamed:@"deposit_sharpbutton_unselected"] forState:UIControlStateNormal];
    [wxButton setBackgroundImage:[UIImage imageNamed:@"deposit_sharpbutton_selected"] forState:UIControlStateSelected];
    [scrollView addSubview:wxButton];
    
    OBShapedButton *cardButton = [OBShapedButton buttonWithType:UIButtonTypeCustom];
    [cardButton setFrame:CGRectMake(CGRectGetMaxX(wxButton.frame) - 5, itemY, itemWidth, itemHeight)];
    [cardButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [cardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [cardButton setTitle:@"银行卡" forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[UIImage imageNamed:@"deposit_sharpbutton_unselected"] forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[UIImage imageNamed:@"deposit_sharpbutton_selected"] forState:UIControlStateSelected];
    [scrollView addSubview:cardButton];
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
