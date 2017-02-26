//
//  AboutViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/20.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

+ (instancetype)createByNibFile{
    
    return [[UIStoryboard storyboardWithName:@"MemberCenter" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AboutVC"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"关于我们";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self addBottomView];
}

- (void)addBottomView
{
    UILabel *labContent = [[UILabel alloc] initWithFrame:CGRectMake(0, mScreenHeight - 64 - 15 - 12, mScreenWidth, 12)];
    [labContent setFont:kFontSize(10)];
    [labContent setText:@"版权所有 Copyright © 2014-2016 Ecaray. All Rights Reserved"];
    [labContent setTextColor:kHexColor(@"#bbbbbb")];
    [labContent setTextAlignment:NSTextAlignmentCenter];
    [self.tableView addSubview:labContent];
    
    UILabel *labCompany = [[UILabel alloc] initWithFrame:CGRectMake(0, mScreenHeight - 64 - 20 - 12 - 20, mScreenWidth, 20)];
    [labCompany setFont:kFontSize(16)];
    [labCompany setText:@"深圳市腾讯计算机服务有限公司"];
    [labCompany setTextColor:kHexColor(@"#000000")];
    [labCompany setTextAlignment:NSTextAlignmentCenter];
    [self.tableView addSubview:labCompany];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                //吐槽申诉
                
            }
                break;
            case 1:
            {
                //申领发票
                
            }
                break;
            case 2:
            {
                NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4001115130"];
                UIWebView * callWebview = [[UIWebView alloc] init];
                [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                [self.view addSubview:callWebview];
            }
                break;
            case 3:
            {
                //官网
                
            }
                break;
            default:
                break;
        }
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
