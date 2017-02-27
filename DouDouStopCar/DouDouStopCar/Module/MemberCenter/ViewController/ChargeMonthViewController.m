//
//  ChargeMonthViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/27.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "ChargeMonthViewController.h"

@interface ChargeMonthViewController ()

@end

@implementation ChargeMonthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"月卡充值";
    [self setConfigView];
}

- (void)setConfigView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight)];
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
    [backView addSubview:minButton];
    
    UIButton *midButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [midButton setFrame:CGRectMake(itemWidth + 2, 2, itemWidth - 4, 36)];
    [midButton setTitle:@"1" forState:UIControlStateNormal];
    [midButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [midButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [midButton setBackgroundImage:[UIImage imageNamed:@"month_btn_mid_back"] forState:UIControlStateNormal];
    [backView addSubview:midButton];
    
    UIButton *maxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [maxButton setFrame:CGRectMake(itemWidth * 2, 0, itemWidth, 40)];
    [maxButton setTitle:@"➕" forState:UIControlStateNormal];
    [maxButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [maxButton setBackgroundImage:[UIImage imageNamed:@"month_btn_right_back"] forState:UIControlStateNormal];
    [backView addSubview:maxButton];
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
