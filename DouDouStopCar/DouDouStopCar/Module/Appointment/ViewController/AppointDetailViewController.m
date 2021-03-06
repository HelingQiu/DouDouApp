//
//  AppointDetailViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/3/6.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "AppointDetailViewController.h"
#import "DouDouButton.h"
@interface AppointDetailViewController ()
{
    UIImageView *_imgView;
    UILabel *_parkingName;
    UILabel *_totalCarNumber;
    UILabel *_emptyCarNumber;
    UILabel *_labLocation;
    UILabel *_labAmount;
    UITextField *_timeField;
    DouDouButton *_firstBtn;
    DouDouButton *_secondBtn;
    DouDouButton *_thirdBtn;
}


@end

@implementation AppointDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"预约车位";
    [self setConfigView];
}

- (void)setConfigView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight - 64 - 76)];
    scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:scrollView];
    
    UIView *container = [UIView new];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    _imgView = [[UIImageView alloc] init];
    [container addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(175);
    }];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:self.model.img_url] placeholderImage:[UIImage imageNamed:@"icon_park_default"] options:SDWebImageAllowInvalidSSLCertificates];
    
    _parkingName = [[UILabel alloc] init];
    [_parkingName setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [_parkingName setTextColor:[UIColor whiteColor]];
    [_parkingName setFont:[UIFont boldSystemFontOfSize:20]];
    [container addSubview:_parkingName];
    [_parkingName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_imgView.mas_bottom).with.offset(0);
        make.left.equalTo(_imgView.mas_left).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-55);
        make.height.mas_equalTo(30);
    }];
    [_parkingName setText:self.model.name];
    
    UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectButton setImage:[UIImage imageNamed:@"__icon_u22"] forState:UIControlStateNormal];
    [collectButton setImage:[UIImage imageNamed:@"__icon_u22_selected"] forState:UIControlStateSelected];
    [collectButton setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [collectButton addTarget:self action:@selector(collectAction:) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:collectButton];
    [collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_imgView.mas_bottom).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(- 15);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    if (![CommonUtils isBlankString:token]) {
        if (self.model.isCollection == 0) {
            collectButton.selected = NO;
        }else{
            collectButton.selected = YES;
        }
    }
    
    UIView *topView = [[UIView alloc] init];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [container addSubview:topView];
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
    _totalCarNumber.text = self.model.total;
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
    _emptyCarNumber.text = self.model.available;
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
        make.height.mas_equalTo(60);
    }];
    
    UILabel *labTypeTip = [[UILabel alloc] init];
    labTypeTip.font = [UIFont boldSystemFontOfSize:16];
    labTypeTip.textColor = kHexColor(kColor_Text);
    labTypeTip.text = @"位置";
    [midView addSubview:labTypeTip];
    [labTypeTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midView.mas_top).with.offset(0);
        make.left.equalTo(midView.mas_left).with.offset(15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(60);
    }];
    
    _labLocation = [[UILabel alloc] init];
    _labLocation.font = [UIFont boldSystemFontOfSize:16];
    _labLocation.textColor = [UIColor blackColor];
    _labLocation.text = self.model.address;
    _labLocation.adjustsFontSizeToFitWidth = YES;
    _labLocation.numberOfLines = 0;
    [midView addSubview:_labLocation];
    [_labLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midView.mas_top).with.offset(5);
        make.left.equalTo(labTypeTip.mas_right).with.offset(10);
        make.width.mas_equalTo(mScreenWidth - 113);
        make.height.mas_equalTo(50);
    }];
    
    UIImageView *locationView = [[UIImageView alloc] init];
    [locationView setImage:[UIImage imageNamed:@"appoint_location"]];
    [midView addSubview:locationView];
    [locationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(midView.mas_centerY).with.offset(0);
        make.right.equalTo(midView.mas_right).with.offset(-15);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(37);
    }];
    
    UILabel *labTime = [[UILabel alloc] init];
    [labTime setFont:[UIFont boldSystemFontOfSize:16]];
    [labTime setText:@"预约时间:"];
    [labTime setTextColor:[UIColor blackColor]];
    [container addSubview:labTime];
    [labTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midView.mas_bottom).with.offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    _timeField = [[UITextField alloc] init];
    [_timeField setPlaceholder:@"输入必须为15的整数，单位为分钟"];
    [_timeField setFont:[UIFont boldSystemFontOfSize:15]];
    [_timeField setValue:kHexColor(kColor_Text) forKeyPath:@"_placeholderLabel.textColor"];
    [_timeField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [_timeField setTextColor:kHexColor(kColor_Text)];
    [_timeField setKeyboardType:UIKeyboardTypeNumberPad];
    [_timeField addTarget:self action:@selector(textDidChangeValue:) forControlEvents:UIControlEventEditingChanged];
    [container addSubview:_timeField];
    [_timeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midView.mas_bottom).with.offset(30);
        make.left.equalTo(labTime.mas_right).with.offset(5);
        make.width.mas_equalTo(mScreenWidth - 35 - 80);
        make.height.mas_equalTo(30);
    }];
    
    UIView *line1 = [UIView new];
    [line1 setBackgroundColor:kHexColor(kColor_Text)];
    [container addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labTime.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.width.mas_equalTo(mScreenWidth);
        make.height.mas_equalTo(1);
    }];
    
    _firstBtn = [DouDouButton buttonWithType:UIButtonTypeCustom];
    [_firstBtn setImage:[UIImage imageNamed:@"appoint_unselected"] forState:UIControlStateNormal];
    [_firstBtn setImage:[UIImage imageNamed:@"appoint_selected"] forState:UIControlStateSelected];
    [_firstBtn setTitle:@"30分钟" forState:UIControlStateNormal];
    [_firstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_firstBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [_firstBtn addTarget:self action:@selector(firstAction:) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:_firstBtn];
    [_firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeField.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.width.mas_equalTo(mScreenWidth/3);
        make.height.mas_equalTo(30);
    }];
    [_firstBtn setImageViewRect:CGRectMake(mScreenWidth/6 - 33, 3.5, 23, 23)];
    [_firstBtn setTitleLabelRect:CGRectMake(mScreenWidth/6 - 8, 0, mScreenWidth/3 - mScreenWidth/6 + 8, 30)];
    
    _secondBtn = [DouDouButton buttonWithType:UIButtonTypeCustom];
    [_secondBtn setImage:[UIImage imageNamed:@"appoint_unselected"] forState:UIControlStateNormal];
    [_secondBtn setImage:[UIImage imageNamed:@"appoint_selected"] forState:UIControlStateSelected];
    [_secondBtn setTitle:@"60分钟" forState:UIControlStateNormal];
    [_secondBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_secondBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [_secondBtn addTarget:self action:@selector(secondAction:) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:_secondBtn];
    [_secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labTime.mas_bottom).with.offset(10);
        make.left.equalTo(_firstBtn.mas_right).with.offset(0);
        make.width.mas_equalTo(mScreenWidth/3);
        make.height.mas_equalTo(30);
    }];
    [_secondBtn setImageViewRect:CGRectMake(mScreenWidth/6 - 33, 3.5, 23, 23)];
    [_secondBtn setTitleLabelRect:CGRectMake(mScreenWidth/6 - 8, 0, mScreenWidth/3 - mScreenWidth/6 + 8, 30)];
    
    _thirdBtn = [DouDouButton buttonWithType:UIButtonTypeCustom];
    [_thirdBtn setImage:[UIImage imageNamed:@"appoint_unselected"] forState:UIControlStateNormal];
    [_thirdBtn setImage:[UIImage imageNamed:@"appoint_selected"] forState:UIControlStateSelected];
    [_thirdBtn setTitle:@"90分钟" forState:UIControlStateNormal];
    [_thirdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_thirdBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [_thirdBtn addTarget:self action:@selector(thirdAction:) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:_thirdBtn];
    [_thirdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labTime.mas_bottom).with.offset(10);
        make.left.equalTo(_secondBtn.mas_right).with.offset(0);
        make.width.mas_equalTo(mScreenWidth/3);
        make.height.mas_equalTo(30);
    }];
    [_thirdBtn setImageViewRect:CGRectMake(mScreenWidth/6 - 33, 3.5, 23, 23)];
    [_thirdBtn setTitleLabelRect:CGRectMake(mScreenWidth/6 - 8, 0, mScreenWidth/3 - mScreenWidth/6 + 8, 30)];
    
    UIView *line2 = [[UIView alloc] init];
    [line2 setBackgroundColor:kHexColor(kColor_Text)];
    [container addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstBtn.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.width.mas_equalTo(mScreenWidth);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *labTip1 = [[UILabel alloc] init];
    [labTip1 setFont:[UIFont boldSystemFontOfSize:15]];
    [labTip1 setText:@"注意:"];
    [labTip1 setTextColor:kHexColor(@"#ff0000")];
    [container addSubview:labTip1];
    [labTip1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).with.offset(20);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.width.mas_equalTo(mScreenWidth -30);
        make.height.mas_equalTo(15);
    }];
    
    NSString *tips = @"请在约定时间内，到达停车位，否则将自动取消您的车位。";
    CGFloat tipHeight = [CommonUtils heightForString:tips Font:[UIFont boldSystemFontOfSize:14] andWidth:mScreenWidth - 30];
    UILabel *labTip2 = [[UILabel alloc] init];
    [labTip2 setFont:[UIFont boldSystemFontOfSize:14]];
    [labTip2 setText:tips];
    [labTip2 setTextColor:kHexColor(@"#ff0000")];
    [container addSubview:labTip2];
    [labTip2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labTip1.mas_bottom).with.offset(2);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.leading.equalTo(scrollView.mas_leading).mas_offset(15);
        make.trailing.equalTo(scrollView.mas_trailing).mas_offset(20);
        make.width.mas_equalTo(mScreenWidth -30);
        make.height.mas_equalTo(tipHeight + 4);
    }];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(labTip2.mas_bottom).mas_offset(20);//这里放最后一个view 的底部
    }];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, mScreenHeight - 64 - 76, mScreenWidth, 76)];
    [bottomView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bottomView];
    
    UILabel *labReuslt = [[UILabel alloc] initWithFrame:CGRectMake(15, 18, 60, 40)];
    [labReuslt setFont:[UIFont boldSystemFontOfSize:16]];
    [labReuslt setText:@"预约费:"];
    [labReuslt setTextColor:[UIColor blackColor]];
    [bottomView addSubview:labReuslt];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setFrame:CGRectMake(mScreenWidth - 135, 18, 120, 40)];
    [submitButton setBackgroundColor:kHexColor(kColor_Mian)];
    [submitButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton setTitle:@"确定预约" forState:UIControlStateNormal];
    submitButton.layer.cornerRadius = 4;
    [submitButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:submitButton];
    
    _labAmount = [[UILabel alloc] initWithFrame:CGRectMake(90, 16, mScreenWidth - 30 - 90 - 125, 40)];
    [_labAmount setFont:[UIFont boldSystemFontOfSize:18]];
    [_labAmount setText:@"0.00元"];
    [_labAmount setTextColor:kHexColor(@"#f67110")];
    [bottomView addSubview:_labAmount];
}

- (void)collectAction:(UIButton *)sender
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouToken];
    if (![CommonUtils isBlankString:token]) {
        
        NSInteger isCollection = self.model.isCollection;
        NSDictionary *params = @{@"parkingId":self.model.uuid};
        if (isCollection == 0) {
            [MemberCenterVM addMyCollectionWithParameter:params completion:^(BOOL finish, id obj) {
                if (finish) {
                    sender.selected = YES;
                }
            }];
        }else{
            [MemberCenterVM deleteMyCollectionListWithParameter:params completion:^(BOOL finish, id obj) {
                if (finish) {
                    sender.selected = NO;
                }
            }];
        }
        
    }else{
    
    }
}

- (void)firstAction:(UIButton *)sender
{
    _firstBtn.selected = YES;
    _secondBtn.selected = NO;
    _thirdBtn.selected = NO;
    _timeField.text = @"30";
    
    CGFloat price = 30 * self.model.priceRole.floatValue;
    [_labAmount setText:[NSString stringWithFormat:@"%.2f元",price]];
}

- (void)secondAction:(UIButton *)sender
{
    _firstBtn.selected = NO;
    _secondBtn.selected = YES;
    _thirdBtn.selected = NO;
    _timeField.text = @"60";
    
    CGFloat price = 60 * self.model.priceRole.floatValue;
    [_labAmount setText:[NSString stringWithFormat:@"%.2f元",price]];
}

- (void)thirdAction:(UIButton *)sender
{
    _firstBtn.selected = NO;
    _secondBtn.selected = NO;
    _thirdBtn.selected = YES;
    _timeField.text = @"90";
    
    CGFloat price = 90 * self.model.priceRole.floatValue;
    [_labAmount setText:[NSString stringWithFormat:@"%.2f元",price]];
}

#pragma mark -
- (void)textDidChangeValue:(UITextField *)textField
{
    CGFloat price = self.model.priceRole.floatValue * textField.text.floatValue;
    [_labAmount setText:[NSString stringWithFormat:@"%.2f元",price]];
}

- (void)sureAction:(UIButton *)sender
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
