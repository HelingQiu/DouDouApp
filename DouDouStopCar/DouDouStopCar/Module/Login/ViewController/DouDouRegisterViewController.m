//
//  DouDouRegisterViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/9.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "DouDouRegisterViewController.h"
#import "LoginVM.h"

@interface DouDouRegisterViewController ()
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *phoneField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *codeField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UIButton *registButton;
@property (weak, nonatomic) IBOutlet UIButton *policyButton;
@property (weak, nonatomic) IBOutlet UILabel *labPolicy;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *lines;


@property (nonatomic,assign) int countTime;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation DouDouRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setConfig];
}

- (void)setConfig
{
    [self.phoneField setValue:kHexColor(kColor_Gray) forKeyPath:@"_placeholderLabel.textColor"];
    [self.phoneField setValue:[UIFont systemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
    
    [self.codeField setValue:kHexColor(kColor_Gray) forKeyPath:@"_placeholderLabel.textColor"];
    [self.codeField setValue:[UIFont systemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
    
    [self.passwordField setValue:kHexColor(kColor_Gray) forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordField setValue:[UIFont systemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
    
    [self.codeButton setBackgroundColor:kHexColor(@"#fd6d73")];
    [self.registButton setBackgroundColor:kHexColor(kColor_Mian)];
    
    [self.lines enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setBackgroundColor:kHexColor(kColor_Gray)];
    }];
}

- (IBAction)codeAction:(UIButton *)sender {
    
    if ([CommonUtils isBlankString:self.phoneField.text]) {
        [CommonUtils showHUDWithMessage:@"请输入手机号" autoHide:YES];
        return;
    }
    if (![CommonUtils isMobileNumber:self.phoneField.text]) {
        [CommonUtils showHUDWithMessage:@"请输入正确的手机号" autoHide:YES];
        return;
    }
    
    _countTime = 59;
    [sender setTitle:[NSString stringWithFormat:@"%d秒",_countTime] forState:UIControlStateNormal];
    [self addTimer];
    
    NSDictionary *params = @{@"mobile":self.phoneField.text};
    [LoginVM sendCodeWithParameter:params completion:^(BOOL finish, id obj) {
        if (finish) {
            
        }
    }];
}

- (IBAction)selectAction:(UIButton *)sender {
}

- (IBAction)policyAction:(UITapGestureRecognizer *)sender {
}

- (IBAction)registAction:(UIButton *)sender {
    
    if ([CommonUtils isBlankString:self.phoneField.text]) {
        [CommonUtils showHUDWithMessage:@"请输入手机号" autoHide:YES];
        return;
    }
    if (![CommonUtils isMobileNumber:self.phoneField.text]) {
        [CommonUtils showHUDWithMessage:@"请输入正确的手机号" autoHide:YES];
        return;
    }
    
    if ([CommonUtils isBlankString:self.codeField.text]) {
        [CommonUtils showHUDWithMessage:@"请输入验证码" autoHide:YES];
        return;
    }
    
    if ([CommonUtils isBlankString:self.passwordField.text]) {
        [CommonUtils showHUDWithMessage:@"请输入密码" autoHide:YES];
        return;
    }
    
    NSDictionary *params = @{@"userId":self.phoneField.text,
                             @"checkCode":self.codeField.text,
                             @"password":[self.passwordField.text MD5]};
    
    [LoginVM registWithParameter:params completion:^(BOOL finish, id obj) {
        if (finish) {
            //注册成功
            
        }
    }];
}

- (void)addTimer{
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
}

-(void)countdown {
    
    _countTime --;
    if (_countTime == 0) {
        
        _countTime = 60;
        
        _codeButton.enabled = YES;
        [_codeButton setTitle:@"重新发送" forState:UIControlStateNormal];
        [self removeTimer];
        _timer = nil;
        
    }else if(self.countTime < 10){
        _codeButton.enabled = NO;
        [_codeButton setTitle:[NSString stringWithFormat:@"0%d秒",_countTime] forState:UIControlStateNormal];
        
    }else{
        _codeButton.enabled = NO;
        [_codeButton setTitle:[NSString stringWithFormat:@"%d秒",_countTime] forState:UIControlStateNormal];
    }
}

- (void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
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
