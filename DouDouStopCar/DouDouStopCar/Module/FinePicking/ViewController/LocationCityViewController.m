//
//  LocationCityViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/24.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "LocationCityViewController.h"

@interface LocationCityViewController ()

@property (nonatomic, strong) NSArray *cityArray;

@end

@implementation LocationCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"选择城市";
    
    NSString *cityString = [[NSUserDefaults standardUserDefaults] objectForKey:kCityData];
    NSData *jsonData = [cityString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:nil];
    
    self.cityArray = [[dic objectForKey:@"data"] objectForKey:@"list"];//@[@"北京",@"上海",@"天津",@"重庆",@"苏州",@"厦门",@"昆明",@"乌鲁木齐",@"拉萨",@"呼和浩特",@"北京",@"北京",@"北京",@"北京",@"北京",@"北京",@"北京"];
    [self setConfigView];
}

- (void)setConfigView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight - 64)];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    UIView *container = [UIView new];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    UILabel *labTopTip = [[UILabel alloc] init];
    [labTopTip setTextColor:kHexColor(@"#aaaaaa")];
    [labTopTip setFont:[UIFont boldSystemFontOfSize:14]];
    [labTopTip setText:@"当前定位城市"];
    [container addSubview:labTopTip];
    [labTopTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(container.mas_top).with.mas_offset(30);
        make.left.equalTo(container.mas_left).with.mas_offset(15);
        make.width.mas_equalTo(mScreenWidth - 30);
        make.height.mas_equalTo(20);
    }];
    
    CGFloat itemWidth = (mScreenWidth - 60 - 45)/3;
    
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationBtn setTitle:self.locationCity forState:UIControlStateNormal];
    locationBtn.layer.cornerRadius = 4;
    [locationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [locationBtn setBackgroundColor:kHexColor(kColor_Mian)];
    [locationBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:locationBtn];
    [locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labTopTip.mas_bottom).with.mas_offset(15);
        make.left.equalTo(container.mas_left).with.mas_offset(30);
        make.width.mas_equalTo(itemWidth);
        make.height.mas_equalTo(30);
    }];
    
    UIView *line = [UIView new];
    [line setBackgroundColor:kHexColor(@"#eeeeee")];
    [container addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(locationBtn.mas_bottom).with.mas_offset(20);
        make.left.equalTo(container.mas_left).with.mas_offset(10);
        make.width.mas_equalTo(mScreenWidth - 20);
        make.height.mas_equalTo(2);
    }];
    
    UILabel *labMidTip = [[UILabel alloc] init];
    [labMidTip setTextColor:kHexColor(@"#aaaaaa")];
    [labMidTip setFont:[UIFont boldSystemFontOfSize:14]];
    [labMidTip setText:@"其他城市"];
    [container addSubview:labMidTip];
    [labMidTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_top).with.mas_offset(20);
        make.left.equalTo(container.mas_left).with.mas_offset(15);
        make.width.mas_equalTo(mScreenWidth - 30);
        make.height.mas_equalTo(20);
    }];
    
    [self.cityArray enumerateObjectsUsingBlock:^(NSDictionary *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSInteger indexH = idx / 3;
        NSInteger indexW = idx % 3;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:[obj objectForKey:@"city"] forState:UIControlStateNormal];
        button.layer.cornerRadius = 4;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:kHexColor(@"#eeeeee")];
        [button.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [button setTag:idx];
        [button addTarget:self action:@selector(cityAction:) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(labMidTip.mas_bottom).with.mas_offset(15 + 45 * indexH);
            make.left.equalTo(container.mas_left).with.mas_offset(30 + indexW * (itemWidth + 15));
            make.width.mas_equalTo(itemWidth);
            make.height.mas_equalTo(30);
        }];
        
        if (idx == self.cityArray.count - 1) {
            [container mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(button.mas_bottom).mas_offset(20);//这里放最后一个view 的底部
            }];
        }
    }];
}

- (void)cityAction:(UIButton *)sender
{
    NSInteger index = sender.tag;
    NSString *city = [[self.cityArray objectAtIndex:index] objectForKey:@"city"];
    if (self.block) {
        self.block(city);
        [self goback];
    }
}

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
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
