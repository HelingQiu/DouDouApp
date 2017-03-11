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
#import <BaiduMapAPI_Utils/BMKNavigation.h>
#import <BaiduMapAPI_Utils/BMKOpenRoute.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "FirstAnnotation.h"
#import "FirstAnnotationView.h"
#import "RoadViewController.h"
#import "LocationCityViewController.h"
#import "SearchParkingViewController.h"

@interface FindParkingViewController ()<BMKMapViewDelegate,UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UITextFieldDelegate>
{
    BMKGeoCodeSearch* _geocodesearch;
    NSString *_locationCity;
}
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) UIButton *cityButton;
@property (nonatomic, strong) MapCarParkingCell *parkingView;

@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, assign) CLLocationCoordinate2D locationPt;

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
    
//    [self getNearByParkingData];
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
    
    _locationCity = @"深圳";
    self.cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cityButton setFrame:CGRectMake(5, self.rightBtn.y, 60, 30)];
    [self.cityButton setTitle:_locationCity forState:UIControlStateNormal];
    [self.cityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.cityButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [self.cityButton setBackgroundColor:kHexColor(kColor_Mian)];
    [self.cityButton addTarget:self action:@selector(cityAction:) forControlEvents:UIControlEventTouchUpInside];
    [naviView addSubview:self.cityButton];
    
    UITextField *searchField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.cityButton.frame) + 10, self.rightBtn.y, self.navigationController.navigationBar.width - 180, 30)];
    [searchField setPlaceholder:@"停车场名字、地点"];
    [searchField setBackgroundColor:[UIColor whiteColor]];
    searchField.clipsToBounds = YES;
    searchField.layer.cornerRadius = 6;
    searchField.returnKeyType = UIReturnKeySearch;
    searchField.delegate = self;
    [naviView addSubview:searchField];
    
    UIView *viewBg = [[UIView alloc] initWithFrame:(CGRect){0,0,25,30}];
    [viewBg setBackgroundColor:[UIColor clearColor]];
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:(CGRect){5, 5, 20, 20}];
    [leftView setImage:[UIImage imageNamed:@"find_parking_search"]];
    [viewBg addSubview:leftView];
    [searchField setLeftView:viewBg];
    [searchField setLeftViewMode:UITextFieldViewModeAlways];
    
    self.parkingView = [MapCarParkingCell createByNibFile];
    [self.parkingView setFrame:CGRectMake(15, mScreenHeight - 64 - 115 - 40, mScreenWidth - 30, 115)];
    [self.parkingView setBackgroundColor:[UIColor whiteColor]];
    self.parkingView.clipsToBounds = YES;
    self.parkingView.layer.cornerRadius = 8;
    self.parkingView.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    self.parkingView.layer.borderWidth = 0.5;
    [self.view addSubview:self.parkingView];
    
    __weak typeof(self) weakSelf = self;
    self.parkingView.roadBlock = ^(NearbyModel *model){
        RoadViewController *roadController = [[RoadViewController alloc] init];
        roadController.startPt = weakSelf.locationPt;
        
        CLLocationCoordinate2D coor1;
        coor1.latitude = 39.90868;
        coor1.longitude = 116.204;
        roadController.endPt = coor1;
        [weakSelf.navigationController pushViewController:roadController animated:YES];
    };
    
    self.parkingView.dirBlock = ^(NearbyModel *model) {
//        [weakSelf openNativeNaviWith:model];
//        [weakSelf openGaoDeNativeNaviWith:model];
        [weakSelf openSafariBaiDuMapWith:model];
    };
    
    self.isMapVisable = YES;
    
    _locService = [[BMKLocationService alloc] init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}

- (void)cityAction:(UIButton *)sender
{
    LocationCityViewController *cityController = [[LocationCityViewController alloc] init];
    cityController.locationCity = _locationCity;
    [self.navigationController pushViewController:cityController animated:YES];
    cityController.block = ^(NSString *city){
        [self.cityButton setTitle:city forState:UIControlStateNormal];
        //重新更新地图数据
        
    };
}

- (BMKMapView *)mapView
{
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight - 64)];
    _mapView.delegate = self;
    _mapView.zoomLevel = 17;
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
    _locService.delegate = self;
    _geocodesearch.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
}
#pragma mark - location
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    [_mapView setCenterCoordinate:userLocation.location.coordinate];
    
    _locationPt = userLocation.location.coordinate;
    
    //反向地理位置解析
    [self onClickReverseGeocode];
    
    BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc]init];
    pointAnnotation.coordinate = userLocation.location.coordinate;
    pointAnnotation.title = @"我的位置";
    [_mapView addAnnotation:pointAnnotation];
    
    [_locService stopUserLocationService];
    _mapView.showsUserLocation = NO;
    
    [self getNearByParkingData:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude] andLog:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude]];
}

- (void)onClickReverseGeocode
{
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = _locationPt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0) {
        
        NSString* titleStr;
        NSString* showmeg;
        titleStr = @"反向地理编码";
        showmeg = result.addressDetail.city;
        
        showmeg = [showmeg stringByReplacingOccurrencesOfString:@"市" withString:@""];
        _locationCity = showmeg;
        
        [self.cityButton setTitle:showmeg forState:UIControlStateNormal];
    }
}

#pragma mark --
// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //动画annotation
    NSString *AnnotationViewID = @"AnimatedAnnotation";
    FirstAnnotationView *annotationView = nil;
    if (annotationView == nil) {
        annotationView = [[FirstAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    [annotationView.annotationImageView setImage:[UIImage imageNamed:@"member_stop"]];
//    ActuallyModel *model = [(FirstAnnotation *)annotation model];
//    annotationView.model = model;
//    
//    MapPaopaoView *paopaoView = [[MapPaopaoView alloc] initWithFrame:CGRectMake(0, 0, 200, 100) model:model];
//    annotationView.paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:paopaoView];
    
    return annotationView;
    
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

- (void)getNearByParkingData:(NSString *)latitude andLog:(NSString *)longitude
{
    [[DouDouNetworking sharedInstance] getDataFromParams:nil forUrl:@"http://api.map.baidu.com/geosearch/v3/nearby?ak=npdMeCxvlXIA3Ll24yUTf3vwkepDEC7c&mcode=com.DouDouStopCar&geotable_id=164548&location=114.067626,22.626419" isJson:YES isAuthorizationHeader:NO headerParamers:nil finished:^(NSDictionary *data) {
        NSLog(@"parking :%@",data);
    } failed:^(NSString *error) {
        
    }];
    /*
    NSDictionary *params = @{@"latitude":@"22.626419",
                             @"longitude":@"114.067626",
                             @"keyword":@"阳光"};
    [FindParkingVM getNearByParkingWithParameter:params completion:^(BOOL finish, id obj) {
        if (finish) {
            self.dataSource = [obj copy];
            
            [self.dataSource enumerateObjectsUsingBlock:^(NearbyModel *obj, NSUInteger idx, BOOL * stop) {
                FirstAnnotation* item = [[FirstAnnotation alloc]init];
                item.coordinate = CLLocationCoordinate2DMake(obj.latitude.floatValue, obj.longitude.floatValue);
                item.title = obj.name;
                [_mapView addAnnotation:item];
            }];
            
            if (!self.tableView) {
                [self.tableView reloadData];
            }
        }
    }];
     */
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
            [self openBaiDuNativeNaviWith:model];
        }else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
            [self openGaoDeNativeNaviWith:model];
        }else{
            //打开浏览器导航
            
        }
    };
    return cell;
}

#pragma mark - 打开百度客户端导航
- (void)openBaiDuNativeNaviWith:(NearbyModel *)model
{
    //初始化调启导航时的参数管理类
    BMKNaviPara* para = [[BMKNaviPara alloc]init];
    //初始化起点节点
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    //指定起点经纬度
    CLLocationCoordinate2D coor1;
    coor1.latitude = 39.90868;
    coor1.longitude = 116.204;
    start.pt = coor1;
    //指定起点名称
    start.name = @"我的位置";
    //指定起点
    para.startPoint = start;
    
    //初始化终点节点
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    //指定终点经纬度
    CLLocationCoordinate2D coor2;
    coor2.latitude = 39.90868;
    coor2.longitude = 116.3956;
    end.pt = coor2;
    //指定终点名称
    end.name = @"天安门";
    //指定终点
    para.endPoint = end;
    
    //指定返回自定义scheme
    para.appScheme = @"DouDouStopCar://";
    
    //调启百度地图客户端导航
    [BMKNavigation openBaiduMapNavigation:para];
}

#pragma mark - 打开高德客户端导航
- (void)openGaoDeNativeNaviWith:(NearbyModel *)model
{
    //判断是否安装了高德地图，如果安装了高德地图，则使用高德地图导航
    CLLocationCoordinate2D coor1;
    coor1.latitude = 39.90868;
    coor1.longitude = 116.204;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])//
    {
        NSString *urlsting =[[NSString stringWithFormat:@"iosamap://navi?sourceApplication=豆豆停车&backScheme= &lat=%f&lon=%f&dev=0&style=2",coor1.latitude,coor1.longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication  sharedApplication]openURL:[NSURL URLWithString:urlsting]];
    }
}

- (void)openSafariBaiDuMapWith:(NearbyModel *)model
{
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    //跳转逻辑
    SearchParkingViewController *searchController = [[SearchParkingViewController alloc] init];
    [self.navigationController pushViewController:searchController animated:YES];
    
    return NO;
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
