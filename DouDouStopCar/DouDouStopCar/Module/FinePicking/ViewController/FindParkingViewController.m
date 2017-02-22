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

@interface FindParkingViewController ()<BMKMapViewDelegate>

@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) UIButton *cityButton;
@property (nonatomic, strong) MapCarParkingCell *parkingView;
@end

@implementation FindParkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.mapView];
    [self setNavigationView];
}

- (void)setNavigationView
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 7, 30, 30);
    [rightBtn setImage:[UIImage imageNamed:@"find_parking_right"] forState:UIControlStateNormal];
    [rightBtn setBackgroundColor:kHexColor(kColor_Mian)];
    [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIView *naviView = [[UIView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    naviView.backgroundColor = kHexColor(kColor_Mian);
    self.navigationItem.titleView = naviView;
    
    self.cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cityButton setFrame:CGRectMake(5, rightBtn.y, 60, 30)];
    [self.cityButton setTitle:@"深圳" forState:UIControlStateNormal];
    [self.cityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.cityButton setBackgroundColor:kHexColor(kColor_Mian)];
    [naviView addSubview:self.cityButton];
    
    NSLog(@"nav width - %f", self.navigationController.navigationBar.frame.size.width); // 宽度
    UITextField *searchField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.cityButton.frame) + 10, rightBtn.y, self.navigationController.navigationBar.width - 180, 30)];
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
}

- (BMKMapView *)mapView
{
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight - 64)];
    _mapView.delegate = self;
    return _mapView;
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
