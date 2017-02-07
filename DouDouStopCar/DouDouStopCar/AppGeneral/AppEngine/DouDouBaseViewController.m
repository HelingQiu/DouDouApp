//
//  DouDouBaseViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/7.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "DouDouBaseViewController.h"

@interface DouDouBaseViewController ()

@end

@implementation DouDouBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(0, 0, 23, 23);
    self.backBtn.contentHorizontalAlignment = UIViewContentModeLeft;
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    // Replace backItem with real back button image
    [self.backBtn setImage:[UIImage imageNamed:@"topbtn_back"] forState:UIControlStateNormal];
    [self.backBtn setTitleColor:kBtnTitleNormalColor forState:UIControlStateNormal];
    self.backBtn.titleLabel.font = [UIFont systemFontOfSize:0];
    self.backBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [self.backBtn addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    self.backBtn.showsTouchWhenHighlighted = YES;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
}

+ (instancetype)creatByNib
{
    NSString *name = [NSString stringWithCString:object_getClassName(self) encoding:NSUTF8StringEncoding];
    return [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:name];
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
