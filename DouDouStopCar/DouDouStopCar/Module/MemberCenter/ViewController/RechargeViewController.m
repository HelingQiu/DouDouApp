//
//  RechargeViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/26.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "RechargeViewController.h"
#import "DouDouButton.h"
#import "MemberCenterVM.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#define Tag_Btn 2346
@interface RechargeViewController ()

@property (nonatomic, strong) UITextField *amountField;
@property (nonatomic, strong) UIButton *aliyRightButton;
@property (nonatomic, strong) UIButton *wxRightButton;

@end

@implementation RechargeViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kAlipayNoti object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kWeixinNoti object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"充值";
    [self setConfigView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alipaySuccess:) name:kAlipayNoti object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weixinSuccess:) name:kWeixinNoti object:nil];
}

- (void)setConfigView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight - 64 - 70)];
    scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:scrollView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 207)];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [scrollView addSubview:topView];
    
    UILabel *labTip = [[UILabel alloc] initWithFrame:CGRectMake(mScreenWidth/2 - 44.7/2 - 40, 63 - 15, 40, 15)];
    [labTip setText:@"余额"];
    [labTip setFont:kFontSize(15)];
    [labTip setTextColor:[UIColor blackColor]];
    [topView addSubview:labTip];
    
    CGFloat moneyWidth = [CommonUtils widthForString:@"0.00" Font:[UIFont boldSystemFontOfSize:33] andWidth:mScreenWidth];
    UILabel *labMoney = [[UILabel alloc] initWithFrame:CGRectMake(mScreenWidth/2 - 44.7/2, 32, moneyWidth, 33)];
    [labMoney setText:@"0.00"];
    [labMoney setFont:[UIFont boldSystemFontOfSize:33]];
    [labMoney setTextColor:kHexColor(@"#ffba07")];
    [topView addSubview:labMoney];
    
    UILabel *labUnit = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labMoney.frame) + 5, 63 - 15, 20, 15)];
    [labUnit setText:@"元"];
    [labUnit setFont:kFontSize(15)];
    [labUnit setTextColor:[UIColor blackColor]];
    [topView addSubview:labUnit];
    
    self.amountField = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(labMoney.frame) + 30, mScreenWidth - 30, 40)];
    [self.amountField setPlaceholder:@"请输入充值金额"];
    [self.amountField setFont:[UIFont boldSystemFontOfSize:17]];
    [self.amountField setValue:kHexColor(kColor_Text) forKeyPath:@"_placeholderLabel.textColor"];
    [self.amountField setValue:[UIFont boldSystemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
    [self.amountField setTextAlignment:NSTextAlignmentCenter];
    [self.amountField setKeyboardType:UIKeyboardTypeDecimalPad];
    [topView addSubview:self.amountField];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.amountField.frame), mScreenWidth - 30, 10)];
    [imgView setImage:[UIImage imageNamed:@"recharge_field_back"]];
    [topView addSubview:imgView];
    
    NSArray *array = @[@"50元",@"100元",@"200元",@"500元"];
    
    CGFloat itemY = CGRectGetMaxY(imgView.frame) + 15;
    CGFloat itemWidth = (mScreenWidth - (array.count + 1) * 15)/array.count;
    CGFloat itemHeight = 32;
    
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(itemWidth * idx + (idx + 1) * 15, itemY, itemWidth, itemHeight)];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"recharge_button_back"] forState:UIControlStateNormal];
        [btn setTag:Tag_Btn + idx];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:btn];
    }];
    
    UILabel *labMid = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(topView.frame) + 30 - 13, mScreenWidth - 30, 26)];
    [labMid setFont:[UIFont boldSystemFontOfSize:20]];
    [labMid setText:@"支付方式"];
    [labMid setTextColor:[UIColor blackColor]];
    [scrollView addSubview:labMid];
    
    UIView *midView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame) + 60, mScreenWidth, 134)];
    [midView setBackgroundColor:[UIColor whiteColor]];
    [scrollView addSubview:midView];
    
    
    self.aliyRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.aliyRightButton setFrame:CGRectMake(mScreenWidth - 33, 66.5/2 - 9, 18, 18)];
    [self.aliyRightButton setImage:[UIImage imageNamed:@"recharge_unselected"] forState:UIControlStateNormal];
    [self.aliyRightButton setImage:[UIImage imageNamed:@"recharge_selected"] forState:UIControlStateSelected];
    self.aliyRightButton.selected = YES;
    [midView addSubview:self.aliyRightButton];
    
    DouDouButton *aliyButton = [DouDouButton buttonWithType:UIButtonTypeCustom];
    [aliyButton setFrame:CGRectMake(0, 0, mScreenWidth, 66.5)];
    [aliyButton setImageViewRect:CGRectMake(15, 66.5/2 - 13, 26, 26)];
    [aliyButton setTitleLabelRect:CGRectMake(56, 66.5/2 - 13, 100, 26)];
    [aliyButton setImage:[UIImage imageNamed:@"recharge_aliy_pay"] forState:UIControlStateNormal];
    [aliyButton setTitle:@"支付宝" forState:UIControlStateNormal];
    [aliyButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [aliyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [aliyButton addTarget:self action:@selector(aliyAction:) forControlEvents:UIControlEventTouchUpInside];
    [midView addSubview:aliyButton];
    
    [midView addSubview:[CommonUtils getSeparator:kHexColor(kColor_Gray) frame:CGRectMake(0, 66.5, mScreenWidth, 1)]];
    
    self.wxRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.wxRightButton setFrame:CGRectMake(mScreenWidth - 33, 67.5 + 66.5/2 - 9, 18, 18)];
    [self.wxRightButton setImage:[UIImage imageNamed:@"recharge_unselected"] forState:UIControlStateNormal];
    [self.wxRightButton setImage:[UIImage imageNamed:@"recharge_selected"] forState:UIControlStateSelected];
    [midView addSubview:self.wxRightButton];
    
    DouDouButton *wxButton = [DouDouButton buttonWithType:UIButtonTypeCustom];
    [wxButton setFrame:CGRectMake(0, 67.5, mScreenWidth, 66.5)];
    [wxButton setImageViewRect:CGRectMake(15, 66.5/2 - 13, 26, 26)];
    [wxButton setTitleLabelRect:CGRectMake(56, 66.5/2 - 13, 100, 26)];
    [wxButton setImage:[UIImage imageNamed:@"recharge_wx_pay"] forState:UIControlStateNormal];
    [wxButton setTitle:@"微信支付" forState:UIControlStateNormal];
    [wxButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [wxButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [wxButton addTarget:self action:@selector(wxAction:) forControlEvents:UIControlEventTouchUpInside];
    [midView addSubview:wxButton];
    
    [scrollView setContentSize:CGSizeMake(0, CGRectGetMaxY(midView.frame) + 20)];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, mScreenHeight - 64 - 70, mScreenWidth, 70)];
    [bottomView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bottomView];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setFrame:CGRectMake(15, 15, mScreenWidth - 30, 40)];
    [submitButton setBackgroundColor:kHexColor(kColor_Mian)];
    [submitButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton setTitle:@"立即充值" forState:UIControlStateNormal];
    submitButton.layer.cornerRadius = 4;
    [submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:submitButton];
}

- (void)btnAction:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    switch (tag) {
        case Tag_Btn:
            self.amountField.text = @"50";
            break;
        case Tag_Btn + 1:
            self.amountField.text = @"100";
            break;
        case Tag_Btn + 2:
            self.amountField.text = @"200";
            break;
        case Tag_Btn + 3:
            self.amountField.text = @"500";
            break;
        default:
            break;
    }
}

- (void)aliyAction:(UIButton *)sender
{
    [self.aliyRightButton setSelected:YES];
    [self.wxRightButton setSelected:NO];
}

- (void)wxAction:(UIButton *)sender
{
    [self.aliyRightButton setSelected:NO];
    [self.wxRightButton setSelected:YES];
}

- (void)submitAction:(UIButton *)sender
{
    NSString *money = @"0.01";//self.amountField.text;
    if ([CommonUtils isBlankString:money]) {
        [CommonUtils showHUDWithMessage:@"请输入充值金额" autoHide:YES];
        return;
    }
    NSString *paytype = @"1";
    if (self.wxRightButton.selected) {
        paytype = @"2";
    }
    NSString *businesstype = @"1";
    NSDictionary *params = @{@"payType":paytype,
                             @"money":money,
                             @"businessType":businesstype};
    [MemberCenterVM rechargeListWithParameter:params completion:^(BOOL finish, id obj) {
        if (finish) {
            //申请充值 成功后 调起支付宝或者微信
            NSString *orderString = [[obj objectForKey:@"data"] objectForKey:@"orderString"];
            
            //支付宝或者微信支付
            if ([paytype isEqualToString:@"1"]) {
                // NOTE: 调用支付结果开始支付
                [[AlipaySDK defaultService] payOrder:orderString fromScheme:kAppScheme callback:^(NSDictionary *resultDic) {
                    NSLog(@" wangye reslut = %@",resultDic);
                    
                    NSInteger resultStatus = [[resultDic objectForKey:@"resultStatus"] integerValue];
                    if (resultStatus == 9000) {
                        [[[UIAlertView alloc] initWithTitle:@"支付结果" message:@"支付成功！" cancelButtonItem:[RIButtonItem itemWithLabel:@"查看钱包" action:^{
                            [self.navigationController popViewControllerAnimated:YES];
                        }] otherButtonItems:nil, nil] show];
                    }else{
                        [[[UIAlertView alloc] initWithTitle:@"支付结果" message:@"支付失败！" cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{
                            
                        }] otherButtonItems:[RIButtonItem itemWithLabel:@"重新充值" action:^{
                            [self submitAction:nil];
                        }], nil] show];
                    }
                }];
            }else{
                PayReq *request = [[PayReq alloc] init];
                request.partnerId = @"10000100";
                request.prepayId = @"1101000000140415649af9fc314aa427";
                request.package = @"Sign=WXPay";
                request.nonceStr = @"a462b76e7436e98e0ed6e13c64b4fd1c";
                request.timeStamp = @"1397527777";
                request.sign = @"582282D72DD2B03AD892830965F428CB16E7A256";
                [WXApi sendReq:request];
            }
        }
    }];
}

//阿里支付成功
- (void)alipaySuccess:(NSNotification *)note
{
    NSLog(@"支付成功");
    NSDictionary *resultDict = [note object];
    NSInteger resultStatus = [[resultDict objectForKey:@"resultStatus"] integerValue];
    if (resultStatus == 9000) {
        [[[UIAlertView alloc] initWithTitle:@"支付结果" message:@"支付成功！" cancelButtonItem:[RIButtonItem itemWithLabel:@"查看钱包" action:^{
            [self.navigationController popViewControllerAnimated:YES];
        }] otherButtonItems:nil, nil] show];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"支付结果" message:@"支付失败！" cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{
            
        }] otherButtonItems:[RIButtonItem itemWithLabel:@"重新充值" action:^{
            [self submitAction:nil];
        }], nil] show];
    }
}

//微信支付成功
- (void)weixinSuccess:(NSNotification *)note
{
    PayResp *resp = [note object];
    if (resp.errCode == WXSuccess) {
        [[[UIAlertView alloc] initWithTitle:@"支付结果" message:@"支付成功！" cancelButtonItem:[RIButtonItem itemWithLabel:@"查看钱包" action:^{
            [self.navigationController popViewControllerAnimated:YES];
        }] otherButtonItems:nil, nil] show];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"支付结果" message:@"支付失败！" cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{
            
        }] otherButtonItems:[RIButtonItem itemWithLabel:@"重新充值" action:^{
            [self submitAction:nil];
        }], nil] show];
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
