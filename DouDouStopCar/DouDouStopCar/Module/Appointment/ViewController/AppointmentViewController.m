//
//  AppointmentViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/3/2.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "AppointmentViewController.h"
#import "CollectionCell.h"
#import "AppointmentTableViewCell.h"
#import "AppointDetailViewController.h"
#import "DouDouButton.h"
#import "CitySelectView.h"

@interface AppointmentViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    DouDouButton *_cityButton;
    CitySelectView *_cityView;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation AppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    [self setConfigView];
}

- (void)setConfigView
{
    UIView *naviView = [[UIView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    naviView.backgroundColor = kHexColor(kColor_Mian);
    self.navigationItem.titleView = naviView;
    
    UITextField *searchField = [[UITextField alloc] initWithFrame:CGRectMake(20, 7, self.navigationController.navigationBar.width - 100, 30)];
    [searchField setPlaceholder:@"停车场名字、地点"];
    [searchField setBackgroundColor:[UIColor whiteColor]];
    searchField.clipsToBounds = YES;
    searchField.layer.cornerRadius = 6;
    searchField.returnKeyType = UIKeyboardTypeWebSearch;
    [naviView addSubview:searchField];
    
    UIView *viewBg = [[UIView alloc] initWithFrame:(CGRect){0,0,25,30}];
    [viewBg setBackgroundColor:[UIColor clearColor]];
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:(CGRect){5, 5, 20, 20}];
    [leftView setImage:[UIImage imageNamed:@"find_parking_search"]];
    [viewBg addSubview:leftView];
    [searchField setLeftView:viewBg];
    [searchField setLeftViewMode:UITextFieldViewModeAlways];
    
    _cityButton = [DouDouButton buttonWithType:UIButtonTypeCustom];
    [_cityButton setFrame:CGRectMake(20, 0, 60, 44)];
    [_cityButton setImageViewRect:CGRectMake(_cityButton.width - 18, 15, 16, 14)];
    [_cityButton setTitleLabelRect:CGRectMake(0, 0, _cityButton.width - 18, 44)];
    [_cityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cityButton setTitleColor:kHexColor(@"#ffba07") forState:UIControlStateSelected];
    [_cityButton setImage:[UIImage imageNamed:@"parking_down_normal"] forState:UIControlStateNormal];
    [_cityButton setImage:[UIImage imageNamed:@"parking_down_selected"] forState:UIControlStateSelected];
    [_cityButton setTitle:@"附近" forState:UIControlStateNormal];
    [_cityButton addTarget:self action:@selector(cityAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cityButton];
    [self.view addSubview:[CommonUtils getSeparator:kHexColor(kColor_Text) frame:CGRectMake(0, 43.5, mScreenWidth, 0.5)]];
    
    _cityView = [[CitySelectView alloc] initWithFrame:CGRectMake(0, 44, mScreenWidth, mScreenHeight - 64 - 44)];
}

- (UITableView *)tableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, mScreenWidth, mScreenHeight - 64 - 44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return _tableView;
}

- (void)cityAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *plistPath = [bundle pathForResource:@"address" ofType:@"plist"];
        NSDictionary*addressDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        
        NSArray *province = [addressDic objectForKey:@"address"];
        [self.view addSubview:_cityView];
        
        [_cityView refreshDataWith:province];
        __weak CitySelectView *weakCityView = _cityView;
        __weak DouDouButton *weakButton = _cityButton;
        _cityView.block = ^(NSString *city) {
            CGFloat itemWidth = [CommonUtils widthForString:city Font:[UIFont systemFontOfSize:18] andWidth:mScreenWidth];
            [weakButton setFrame:CGRectMake(20, 0, 100, 44)];
            [sender setTitle:city forState:UIControlStateNormal];
            sender.selected = !sender.selected;
            [weakCityView removeFromSuperview];
        };
    }else{
        [_cityView removeFromSuperview];
    }
}

#pragma mark - 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppointmentTableViewCell *cell = [AppointmentTableViewCell cellForTableView:tableView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AppointDetailViewController *appointController = [[AppointDetailViewController alloc] init];
    [self.navigationController pushViewController:appointController animated:YES];
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
