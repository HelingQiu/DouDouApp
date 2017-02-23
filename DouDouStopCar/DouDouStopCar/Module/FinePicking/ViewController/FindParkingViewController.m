//
//  FindParkingViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/22.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "FindParkingViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "MapCarParkingCell.h"
#import "FindParkingVM.h"
#import "NearByParkingListCell.h"
#import "NearbyModel.h"

@interface FindParkingViewController ()<BMKMapViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) UIButton *cityButton;
@property (nonatomic, strong) MapCarParkingCell *parkingView;

@property (nonatomic, assign) BOOL isMapVisable;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation FindParkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.mapView];
    [self setNavigationView];
    [self getNearByParkingData];
}

- (void)setNavigationView
{
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(0, 7, 25, 30);
    [self.rightBtn setImage:[UIImage imageNamed:@"find_parking_right"] forState:UIControlStateNormal];
    [self.rightBtn setBackgroundColor:kHexColor(kColor_Mian)];
    [self.rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIView *naviView = [[UIView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    naviView.backgroundColor = kHexColor(kColor_Mian);
    self.navigationItem.titleView = naviView;
    
    self.cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cityButton setFrame:CGRectMake(5, self.rightBtn.y, 60, 30)];
    [self.cityButton setTitle:@"深圳" forState:UIControlStateNormal];
    [self.cityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.cityButton setBackgroundColor:kHexColor(kColor_Mian)];
    [naviView addSubview:self.cityButton];
    
    NSLog(@"nav width - %f", self.navigationController.navigationBar.frame.size.width); // 宽度
    UITextField *searchField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.cityButton.frame) + 10, self.rightBtn.y, self.navigationController.navigationBar.width - 180, 30)];
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
    
    self.parkingView = [MapCarParkingCell createByNibFile];
    [self.parkingView setFrame:CGRectMake(30, mScreenHeight - 64 - 115 - 40, mScreenWidth - 60, 115)];
    [self.parkingView setBackgroundColor:[UIColor whiteColor]];
    self.parkingView.clipsToBounds = YES;
    self.parkingView.layer.cornerRadius = 8;
    self.parkingView.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    self.parkingView.layer.borderWidth = 0.5;
    [self.view addSubview:self.parkingView];
    
    self.isMapVisable = YES;
}

- (BMKMapView *)mapView
{
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight - 64)];
    _mapView.delegate = self;
    return _mapView;
}

- (UITableView *)tableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    return _tableView;
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

- (void)rightAction
{
    self.isMapVisable = !self.isMapVisable;
    
    if (!self.isMapVisable) {
        
        [self.rightBtn setImage:[UIImage imageNamed:@"find_parking_location"] forState:UIControlStateNormal];
        
        [UIView beginAnimations:@"doflip" context:nil];
        
        //设置时常
        
        [UIView setAnimationDuration:1];
        
        //设置动画淡入淡出
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        //设置代理
        
        [UIView setAnimationDelegate:self];
        
        //设置翻转方向
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:NO];
        
        //动画结束
        
        [UIView commitAnimations];
        
        [self.view addSubview:self.tableView];
    }else{
        [self.rightBtn setImage:[UIImage imageNamed:@"find_parking_right"] forState:UIControlStateNormal];
        
        [UIView beginAnimations:@"doflip" context:nil];
        
        //设置时常
        
        [UIView setAnimationDuration:1];
        
        //设置动画淡入淡出
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        //设置代理
        
        [UIView setAnimationDelegate:self];
        
        //设置翻转方向
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:NO];
        
        //动画结束
        
        [UIView commitAnimations];
        
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UITableView class]]) {
                [obj removeFromSuperview];
            }
        }];
    }
}

- (void)getNearByParkingData
{
    NSDictionary *params = @{@"latitude":@"22.61667",
                             @"longitude":@"114.06667",
                             @"keyword":@""};
    [FindParkingVM getNearByParkingWithParameter:params completion:^(BOOL finish, id obj) {
        if (finish) {
            self.dataSource = [obj copy];
            if (!self.tableView) {
                [self.tableView reloadData];
            }
        }
    }];
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearByParkingListCell *cell = [NearByParkingListCell cellForTableView:tableView];
    
    NearbyModel *model = [self.dataSource objectAtIndex:indexPath.row];
    [cell refreshWithData:model];
    cell.block = ^(){
        //导航
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"baidumap://map/navi?location=40.057023, 116.307852&src=push&type=BLK&src=com.DouDouStopCar"]];
        }
    };
    return cell;
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
