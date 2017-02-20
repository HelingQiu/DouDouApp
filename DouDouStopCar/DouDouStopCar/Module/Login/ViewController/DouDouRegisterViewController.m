//
//  DouDouRegisterViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/9.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "DouDouRegisterViewController.h"

@interface DouDouRegisterViewController ()
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *phoneField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *codeField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UIButton *registButton;
@property (weak, nonatomic) IBOutlet UIButton *policyButton;
@property (weak, nonatomic) IBOutlet UILabel *labPolicy;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *lines;

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
}

- (IBAction)selectAction:(UIButton *)sender {
}

- (IBAction)policyAction:(UITapGestureRecognizer *)sender {
}

- (IBAction)registAction:(UIButton *)sender {
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
