//
//  RoleInfoViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/3/12.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "RoleInfoViewController.h"
#import "MemberCenterVM.h"

@interface RoleInfoViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation RoleInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.roleType == 1) {
        self.navigationItem.title = @"协议规则";
    }else if (self.roleType == 2) {
        self.navigationItem.title = @"停车卷使用规则";
    }else{
        self.navigationItem.title = @"发票申领规则";
    }
    [self setConfigView];
    [self getRoleData];
}

- (void)setConfigView
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight - 64)];
    [self.view addSubview:self.webView];
}

- (void)getRoleData
{
    NSDictionary *params = @{@"roleType":[NSNumber numberWithInteger:self.roleType]};
    [MemberCenterVM getRoleInfoWithParameter:params completion:^(BOOL finish, id obj) {
        if (finish) {
            NSString *rolehtml = [[obj objectForKey:@"data"] objectForKey:@"html"];
            [self.webView loadHTMLString:rolehtml baseURL:nil];
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
