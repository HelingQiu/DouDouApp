//
//  DouDouLoginViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/8.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "DouDouLoginViewController.h"
#import "LoginVM.h"

@interface DouDouLoginViewController ()

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *phoneField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *lines;

@end

@implementation DouDouLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setConfig];
    [self.backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)goBack:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)setConfig
{
    [self.phoneField setValue:kHexColor(kColor_Gray) forKeyPath:@"_placeholderLabel.textColor"];
    [self.phoneField setValue:[UIFont systemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
    
    [self.passwordField setValue:kHexColor(kColor_Gray) forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordField setValue:[UIFont systemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
    
    [self.loginButton setBackgroundColor:kHexColor(kColor_Mian)];
    [self.forgetButton setTitleColor:kHexColor(kColor_Gray) forState:UIControlStateNormal];
    [self.registerButton setTitleColor:kHexColor(kColor_Gray) forState:UIControlStateNormal];
    [self.lines enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setBackgroundColor:kHexColor(kColor_Gray)];
    }];
}

- (IBAction)loginAction:(UIButton *)sender {
    
    if ([CommonUtils isBlankString:self.phoneField.text]) {
        [CommonUtils showHUDWithMessage:@"请输入手机号" autoHide:YES];
        return;
    }
    if (![CommonUtils isMobileNumber:self.phoneField.text]) {
        [CommonUtils showHUDWithMessage:@"请输入正确的手机号" autoHide:YES];
        return;
    }
    if ([CommonUtils isBlankString:self.passwordField.text]) {
        [CommonUtils showHUDWithMessage:@"请输入密码" autoHide:YES];
        return;
    }
    
    NSDictionary *params = @{@"userId":self.phoneField.text,
                             @"password":[self.passwordField.text MD5],
                             @"deviceType":@"1",
                             @"deviceType":@"2"};
    
    [LoginVM loginWithParameter:params completion:^(BOOL finish, id obj) {
        if (finish) {
            //登录成功
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
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
