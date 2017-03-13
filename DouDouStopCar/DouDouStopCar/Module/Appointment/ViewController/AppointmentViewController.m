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
#import "FindParkingVM.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "NearbyModel.h"

@interface AppointmentViewController ()<UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate>
{
    DouDouButton *_cityButton;
    CitySelectView *_cityView;
    CLLocationCoordinate2D _locationPt;
    NSString *_locationCity;
}
@property (nonatomic, strong) BMKLocationService *locService;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation AppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, mScreenWidth, mScreenHeight - 64 - 44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self setConfigView];
    [self getCityData];
    
    _locationCity = @"";
    _locService = [[BMKLocationService alloc] init];
    _locService.delegate = self;
    [_locService startUserLocationService];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _locService.delegate = nil;
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    [_locService stopUserLocationService];
    
    _locationPt = userLocation.location.coordinate;
    [self getNearByParkingData:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude] andLog:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude]];
    
//    [self getNearByParkingData:@"22.626419" andLog:@"114.067626"];
}

- (void)getCityData
{
    [FindParkingVM getCityDataWithParameter:nil completion:^(BOOL finish, id obj) {
        
    }];
}

- (void)getNearByParkingData:(NSString *)latitude andLog:(NSString *)longitude
{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouUserId];
    NSDictionary *params = @{@"latitude":latitude,
                             @"longitude":longitude,
                             @"keyword":@"",
                             @"city":_locationCity?:@"",
                             @"userId":userId?:@"",
                             @"isBook":[NSNumber numberWithInteger:1],
                             @"district":@""};
    [FindParkingVM getNearByParkingWithParameter:params completion:^(BOOL finish, id obj) {
        if (finish) {
            self.dataSource = [obj copy];
            
            if (self.tableView) {
                [self.tableView reloadData];
            }
        }
    }];
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

- (void)cityAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        NSString *cityString = [[NSUserDefaults standardUserDefaults] objectForKey:kCityData];
        NSData *jsonData = [cityString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingAllowFragments
                                                              error:nil];
        
        NSArray *cityArray = [[dic objectForKey:@"data"] objectForKey:@"list"];
        [self.view addSubview:_cityView];
        
        [_cityView refreshDataWith:cityArray];
        __weak CitySelectView *weakCityView = _cityView;
        __weak DouDouButton *weakButton = _cityButton;
        _cityView.block = ^(NSString *city) {
            CGFloat itemWidth = [CommonUtils widthForString:city Font:[UIFont systemFontOfSize:18] andWidth:mScreenWidth];
            [weakButton setFrame:CGRectMake(20, 0, itemWidth + 18, 44)];
            [weakButton setImageViewRect:CGRectMake(weakButton.width - 18, 15, 16, 14)];
            [weakButton setTitleLabelRect:CGRectMake(0, 0, weakButton.width - 18, 44)];
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
    
    return self.dataSource.count;
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
    NearbyModel *model = [self.dataSource objectAtIndex:indexPath.section];
    [cell refreshDataWith:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NearbyModel *model = [self.dataSource objectAtIndex:indexPath.section];
    AppointDetailViewController *appointController = [[AppointDetailViewController alloc] init];
    appointController.model = model;
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
