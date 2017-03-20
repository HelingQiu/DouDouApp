//
//  DepositViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/26.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "DepositViewController.h"
#import "OBShapedButton.h"
#import "MemberCenterVM.h"
#import "DepositRecordViewController.h"

@interface DepositViewController ()

@property (nonatomic, strong) OBShapedButton *aliyButton;
@property (nonatomic, strong) OBShapedButton *wxButton;
@property (nonatomic, strong) OBShapedButton *cardButton;

@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *acountField;
@property (nonatomic, strong) UITextField *moneyField;

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
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight - 64)];
    scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:scrollView];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 123.3)];
    [backView setBackgroundColor:kHexColor(kColor_Mian)];
    [scrollView addSubview:backView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(mScreenWidth/2 - 44.7/2, 20, 62, 53.3)];
    [imgView setImage:[UIImage imageNamed:@"deposit_card"]];
    [backView addSubview:imgView];
    
    UILabel *labTip = [[UILabel alloc] initWithFrame:CGRectMake(mScreenWidth/2 - 44.7/2 - 40, 123.3 - 30, 40, 15)];
    [labTip setText:@"余额"];
    [labTip setFont:kFontSize(15)];
    [labTip setTextColor:[UIColor whiteColor]];
    [backView addSubview:labTip];
    
    CGFloat moneyWidth = [CommonUtils widthForString:self.lastMoney Font:kFontSize(33) andWidth:mScreenWidth];
    UILabel *labMoney = [[UILabel alloc] initWithFrame:CGRectMake(mScreenWidth/2 - 44.7/2, 123.3 - 45, moneyWidth, 33)];
    [labMoney setText:self.lastMoney];
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
    
    self.aliyButton = [OBShapedButton buttonWithType:UIButtonTypeCustom];
    [self.aliyButton setFrame:CGRectMake(15, itemY, itemWidth, itemHeight)];
    [self.aliyButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [self.aliyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.aliyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.aliyButton setTitle:@"支付宝" forState:UIControlStateNormal];
    [self.aliyButton setBackgroundImage:[UIImage imageNamed:@"deposit_sharpbutton_unselected"] forState:UIControlStateNormal];
    [self.aliyButton setBackgroundImage:[UIImage imageNamed:@"deposit_sharpbutton_selected"] forState:UIControlStateSelected];
    [self.aliyButton setSelected:YES];
    [self.aliyButton addTarget:self action:@selector(aliyAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.aliyButton];
    
    self.wxButton = [OBShapedButton buttonWithType:UIButtonTypeCustom];
    [self.wxButton setFrame:CGRectMake(CGRectGetMaxX(self.aliyButton.frame) - 5, itemY, itemWidth, itemHeight)];
    [self.wxButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [self.wxButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.wxButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.wxButton setTitle:@"微信" forState:UIControlStateNormal];
    [self.wxButton setBackgroundImage:[UIImage imageNamed:@"deposit_sharpbutton_unselected"] forState:UIControlStateNormal];
    [self.wxButton setBackgroundImage:[UIImage imageNamed:@"deposit_sharpbutton_selected"] forState:UIControlStateSelected];
    [self.wxButton addTarget:self action:@selector(wxAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.wxButton];
    
    self.cardButton = [OBShapedButton buttonWithType:UIButtonTypeCustom];
    [self.cardButton setFrame:CGRectMake(CGRectGetMaxX(self.wxButton.frame) - 5, itemY, itemWidth, itemHeight)];
    [self.cardButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [self.cardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.cardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.cardButton setTitle:@"银行卡" forState:UIControlStateNormal];
    [self.cardButton setBackgroundImage:[UIImage imageNamed:@"deposit_sharpbutton_unselected"] forState:UIControlStateNormal];
    [self.cardButton setBackgroundImage:[UIImage imageNamed:@"deposit_sharpbutton_selected"] forState:UIControlStateSelected];
    [self.cardButton addTarget:self action:@selector(cardAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.cardButton];
    
    [scrollView addSubview:[CommonUtils getSeparator:[UIColor lightGrayColor] frame:CGRectMake(0, CGRectGetMaxY(self.aliyButton.frame) + 15, mScreenWidth, 1)]];
    
    UIImageView *acountBackView = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.aliyButton.frame) + 30, mScreenWidth - 30, 106)];
    [acountBackView setImage:[UIImage imageNamed:@"deposit_field_back"]];
    [acountBackView setUserInteractionEnabled:YES];
    [scrollView addSubview:acountBackView];
    
    UILabel *labName = [[UILabel alloc] initWithFrame:CGRectMake(15, 53.0/2 - 10, 44, 20)];
    [labName setFont:[UIFont boldSystemFontOfSize:18]];
    [labName setText:@"姓名"];
    [labName setTextColor:[UIColor blackColor]];
    [acountBackView addSubview:labName];
    
    self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labName.frame) + 5, 53.0/2 - 10, mScreenWidth - 60 - CGRectGetMaxX(labName.frame) - 5, 20)];
    [self.nameField setPlaceholder:@"填写真实姓名"];
    [self.nameField setFont:[UIFont boldSystemFontOfSize:15]];
    [self.nameField setValue:kHexColor(kColor_Text) forKeyPath:@"_placeholderLabel.textColor"];
    [self.nameField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [self.nameField setTextColor:kHexColor(kColor_Text)];
    [acountBackView addSubview:self.nameField];
    
    [acountBackView addSubview:[CommonUtils getSeparator:[UIColor groupTableViewBackgroundColor] frame:CGRectMake(0, 52.5, mScreenWidth - 30, 0.5)]];
    
    UILabel *labAcount = [[UILabel alloc] initWithFrame:CGRectMake(15, 53 + 53.0/2 - 10, 44, 20)];
    [labAcount setFont:[UIFont boldSystemFontOfSize:18]];
    [labAcount setText:@"账号"];
    [labAcount setTextColor:[UIColor blackColor]];
    [acountBackView addSubview:labAcount];
    
    self.acountField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labAcount.frame) + 5, 53 + 53.0/2 - 10, mScreenWidth - 60 - CGRectGetMaxX(labAcount.frame) - 5, 20)];
    [self.acountField setPlaceholder:@"填写提现支付宝账号"];
    [self.acountField setFont:[UIFont boldSystemFontOfSize:15]];
    [self.acountField setValue:kHexColor(kColor_Text) forKeyPath:@"_placeholderLabel.textColor"];
    [self.acountField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [self.acountField setTextColor:kHexColor(kColor_Text)];
    [acountBackView addSubview:self.acountField];
    
    UIImageView *moneyBackView = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(acountBackView.frame) + 20, mScreenWidth - 30, 53)];
    [moneyBackView setUserInteractionEnabled:YES];
    [moneyBackView setImage:[UIImage imageNamed:@"deposit_field_back"]];
    [scrollView addSubview:moneyBackView];
    
    UILabel *labAmount = [[UILabel alloc] initWithFrame:CGRectMake(15, 53.0/2 - 10, 44, 20)];
    [labAmount setFont:[UIFont boldSystemFontOfSize:18]];
    [labAmount setText:@"金额"];
    [labAmount setTextColor:[UIColor blackColor]];
    [moneyBackView addSubview:labAmount];
    
    self.moneyField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labAmount.frame) + 5, 53.0/2 - 10, mScreenWidth - 60 - CGRectGetMaxX(labAmount.frame) - 5, 20)];
    [self.moneyField setPlaceholder:[NSString stringWithFormat:@"本次最多可提现%@元",self.lastMoney]];
    [self.moneyField setFont:[UIFont boldSystemFontOfSize:15]];
    [self.moneyField setValue:kHexColor(kColor_Text) forKeyPath:@"_placeholderLabel.textColor"];
    [self.moneyField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [self.moneyField setTextColor:kHexColor(kColor_Text)];
    [self.moneyField setKeyboardType:UIKeyboardTypeDecimalPad];
    [self.moneyField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [moneyBackView addSubview:self.moneyField];
    
    [scrollView addSubview:[CommonUtils getSeparator:[UIColor lightGrayColor] frame:CGRectMake(0, CGRectGetMaxY(moneyBackView.frame) + 20, mScreenWidth, 1)]];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setFrame:CGRectMake(15, CGRectGetMaxY(moneyBackView.frame) + 40, mScreenWidth - 30, 40)];
    submitButton.layer.cornerRadius = 4;
    [submitButton setBackgroundColor:kHexColor(kColor_Mian)];
    [submitButton setTitle:@"确认提现" forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:submitButton];
    
    UILabel *labBottomTip = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(submitButton.frame) + 20, mScreenWidth - 40, 72)];
    [labBottomTip setFont:kFontSize(13)];
    [labBottomTip setTextColor:kHexColor(kColor_Text)];
    [labBottomTip setNumberOfLines:0];
    [labBottomTip setText:@"温馨提示:\n1.车位收入需在停车场结算后才可提现\n2.提现金额小于200元，每次需缴纳5元手续费\n3.申请提现后，1-3个工作日可到账"];
    [scrollView addSubview:labBottomTip];
    
    [scrollView setContentSize:CGSizeMake(0, CGRectGetMaxY(labBottomTip.frame) + 20)];
}

- (void)rightAction
{
    DepositRecordViewController *depositController = [[DepositRecordViewController alloc] init];
    [self.navigationController pushViewController:depositController animated:YES];
}

- (void)aliyAction:(UIButton *)sender
{
    [self.aliyButton setSelected:YES];
    [self.wxButton setSelected:NO];
    [self.cardButton setSelected:NO];
    [self.acountField setPlaceholder:@"填写提现支付宝账号"];
}

- (void)wxAction:(UIButton *)sender
{
    [self.aliyButton setSelected:NO];
    [self.wxButton setSelected:YES];
    [self.cardButton setSelected:NO];
    [self.acountField setPlaceholder:@"填写提现微信账号"];
}

- (void)cardAction:(UIButton *)sender
{
    [self.aliyButton setSelected:NO];
    [self.wxButton setSelected:NO];
    [self.cardButton setSelected:YES];
    [self.acountField setPlaceholder:@"填写提现银行卡号"];
}

- (void)textValueChanged:(UITextField *)field
{
    CGFloat nowMoney = field.text.floatValue;
    CGFloat allMoney = self.lastMoney.floatValue;
    
    if ((nowMoney - allMoney) > 0) {
        [CommonUtils showHUDWithMessage:@"提现金额不能大于余额" autoHide:YES];
        field.text = @"";
    }
}

- (void)submitAction:(UIButton *)sender
{
    NSString *name = self.nameField.text;
    NSString *acount = self.acountField.text;
    NSString *money = self.moneyField.text;
    if ([CommonUtils isBlankString:name]) {
        [CommonUtils showHUDWithMessage:@"请输入真实姓名" autoHide:YES];
        return;
    }
    
    if ([CommonUtils isBlankString:acount]) {
        if (self.aliyButton.selected) {
            [CommonUtils showHUDWithMessage:@"请输入提现支付宝账号" autoHide:YES];
            return;
        }else if (self.wxButton.selected) {
            [CommonUtils showHUDWithMessage:@"请输入提现微信账号" autoHide:YES];
            return;
        }else{
            [CommonUtils showHUDWithMessage:@"请输入提现银行卡号" autoHide:YES];
            return;
        }
    }
    if ([CommonUtils isBlankString:money]) {
        [CommonUtils showHUDWithMessage:@"请输入提现金额" autoHide:YES];
        return;
    }
    
    NSString *type = @"1";
    if (self.wxButton.selected) {
        type = @"2";
    }else if (self.cardButton.selected) {
        type = @"3";
    }
    
    NSDictionary *params = @{@"payType":type,
                             @"payAccount":acount,
                             @"payName":name,
                             @"cash":money};
    [MemberCenterVM depositWithParameter:params completion:^(BOOL finish, id obj) {
        if (finish) {
            [[[UIAlertView alloc] initWithTitle:@"提现结果" message:@"提现申请成功，请等待审核！" cancelButtonItem:[RIButtonItem itemWithLabel:@"确定" action:^{
                [self.navigationController popViewControllerAnimated:YES];
            }] otherButtonItems:nil, nil] show];
        }
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
