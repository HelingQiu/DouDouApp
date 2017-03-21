//
//  ApplyBillViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/3/5.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "ApplyBillViewController.h"
#import "RFSegmentView.h"
#import "CarNumberCell.h"
#import "DouDouButton.h"
#import "SkyerCityPicker.h"
#import "RoleInfoViewController.h"
#import "CashOrPrivilCell.h"
#import "MemberCenterVM.h"

@interface ApplyBillViewController ()<RFSegmentViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) RFSegmentView* segmentView;
@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UIButton *areaButton;
@property (nonatomic, strong) UITextField *placeField;

@property (nonatomic, assign) CGFloat scrollHeight;
@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger index;

@end

@implementation ApplyBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setConfigView];
    
    self.index = 0;
    self.dataSource = [NSMutableArray array];
    
    [self getBillListRecordData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.index = 0;
        [self getBillListRecordData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        [self getBillListRecordData];
    }];
}

- (void)getBillListRecordData
{
    NSDictionary *params = @{@"page":[NSNumber numberWithInteger:self.index]};
    [MemberCenterVM getBillListRecordWithParameter:params completion:^(BOOL finish, id obj) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (finish) {
            NSArray *array = obj;
            if (self.index == 0) {
                self.dataSource = [array mutableCopy];
            }else{
                [self.dataSource addObjectsFromArray:array];
            }
            if (array.count == 0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.tableView reloadData];
        }
    }];
}

- (void)setConfigView
{
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight - 64 - 50)];
    self.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.scrollView setContentSize:CGSizeMake(mScreenWidth * 2, mScreenHeight - 64 - 50)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.scrollView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 70)];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [self.scrollView addSubview:topView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(mScreenWidth - 80, 8, 16, 16)];
    [imgView setImage:[UIImage imageNamed:@"privilege_help"]];
    [topView addSubview:imgView];
    
    UILabel *labTip = [[UILabel alloc] initWithFrame:CGRectMake(mScreenWidth - 60, 8, 60, 16)];
    [labTip setFont:[UIFont systemFontOfSize:13]];
    [labTip setTextColor:kHexColor(@"#bbbbbb")];
    [labTip setText:@"使用规则"];
    [labTip setUserInteractionEnabled:YES];
    [topView addSubview:labTip];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(usePolicyAction:)];
    [labTip addGestureRecognizer:recognizer];
    
    UILabel *labXM = [[UILabel alloc] initWithFrame:CGRectMake(15, 24, mScreenWidth - 30, 36)];
    [labXM setText:@"项目:停车费（0.00元）"];
    [labXM setFont:kFontSize(16)];
    [labXM setTextColor:[UIColor blackColor]];
    [topView addSubview:labXM];
    
    UIView *midView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame) + 24, mScreenWidth, 240)];
    [midView setBackgroundColor:[UIColor whiteColor]];
    [self.scrollView addSubview:midView];
    
    UILabel *labName = [[UILabel alloc] initWithFrame:CGRectMake(15, 60.0/2 - 10, 80, 20)];
    [labName setFont:[UIFont boldSystemFontOfSize:18]];
    [labName setText:@"姓名:"];
    [labName setTextColor:[UIColor blackColor]];
    [midView addSubview:labName];
    
    self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labName.frame) + 5, 60.0/2 - 10, mScreenWidth - 95 - CGRectGetMaxX(labName.frame) - 5, 20)];
//    [self.nameField setPlaceholder:@"填写姓名"];
    [self.nameField setFont:[UIFont boldSystemFontOfSize:15]];
    [self.nameField setValue:kHexColor(kColor_Text) forKeyPath:@"_placeholderLabel.textColor"];
    [self.nameField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [self.nameField setTextColor:kHexColor(kColor_Text)];
    [midView addSubview:self.nameField];
    
    UILabel *labPhone = [[UILabel alloc] initWithFrame:CGRectMake(15, 60 + 60.0/2 - 10, 80, 20)];
    [labPhone setFont:[UIFont boldSystemFontOfSize:18]];
    [labPhone setText:@"手机号:"];
    [labPhone setTextColor:[UIColor blackColor]];
    [midView addSubview:labPhone];
    
    self.phoneField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labPhone.frame) + 5, 60 + 60.0/2 - 10, mScreenWidth - 95 - CGRectGetMaxX(labPhone.frame) - 5, 20)];
//    [self.phoneField setPlaceholder:@"填写手机号"];
    [self.phoneField setFont:[UIFont boldSystemFontOfSize:15]];
    [self.phoneField setValue:kHexColor(kColor_Text) forKeyPath:@"_placeholderLabel.textColor"];
    [self.phoneField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [self.phoneField setTextColor:kHexColor(kColor_Text)];
    [self.phoneField setKeyboardType:UIKeyboardTypeNumberPad];
    [midView addSubview:self.phoneField];
    
    UILabel *labArea = [[UILabel alloc] initWithFrame:CGRectMake(15, 120 + 60.0/2 - 10, 80, 20)];
    [labArea setFont:[UIFont boldSystemFontOfSize:18]];
    [labArea setText:@"所在区域:"];
    [labArea setTextColor:[UIColor blackColor]];
    [midView addSubview:labArea];
    
    self.areaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.areaButton.frame = CGRectMake(CGRectGetMaxX(labArea.frame) + 5, 120 + 60.0/2 - 10, mScreenWidth - 95 - CGRectGetMaxX(labPhone.frame) - 15, 20);
    [self.areaButton.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [self.areaButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.areaButton setTitleColor:kHexColor(kColor_Text) forState:UIControlStateNormal];
    [self.areaButton addTarget:self action:@selector(pickAction:) forControlEvents:UIControlEventTouchUpInside];
    [midView addSubview:self.areaButton];
    
    UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(mScreenWidth - 15 - 10, 120 + 60.0/2 - 10, 12, 20)];
    [arrowView setImage:[UIImage imageNamed:@"bill_arrow"]];
    [midView addSubview:arrowView];
    
    UILabel *labPlace = [[UILabel alloc] initWithFrame:CGRectMake(15, 180 + 60.0/2 - 10, 80, 20)];
    [labPlace setFont:[UIFont boldSystemFontOfSize:18]];
    [labPlace setText:@"街道地址:"];
    [labPlace setTextColor:[UIColor blackColor]];
    [midView addSubview:labPlace];
    
    self.placeField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labPlace.frame) + 5, 180 + 60.0/2 - 10, mScreenWidth - 95 - CGRectGetMaxX(labPhone.frame) - 5, 20)];
    //    [self.phoneField setPlaceholder:@"填写手机号"];
    [self.placeField setFont:[UIFont boldSystemFontOfSize:15]];
    [self.placeField setValue:kHexColor(kColor_Text) forKeyPath:@"_placeholderLabel.textColor"];
    [self.placeField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [self.placeField setTextColor:kHexColor(kColor_Text)];
    [midView addSubview:self.placeField];
    
    UILabel *labX = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(midView.frame) + 20, 10, 10)];
    [labX setFont:kFontSize(13)];
    [labX setTextColor:kHexColor(@"#ffba07")];
    [labX setText:@"*"];
    [self.scrollView addSubview:labX];
    
    UILabel *labBottomTip = [[UILabel alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(midView.frame) + 20, mScreenWidth - 45, 32)];
    [labBottomTip setFont:kFontSize(13)];
    [labBottomTip setTextColor:kHexColor(kColor_Text)];
    [labBottomTip setNumberOfLines:0];
    [labBottomTip setText:@"申请发票采用邮寄方式送达,邮寄需到付自出,请正确填写收件信息,以确保您正常使用。"];
    [self.scrollView addSubview:labBottomTip];
    
    UILabel *labXX = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(labBottomTip.frame) + 10, 10, 10)];
    [labXX setFont:kFontSize(13)];
    [labXX setTextColor:kHexColor(@"#ffba07")];
    [labXX setText:@"*"];
    [self.scrollView addSubview:labXX];
    
    UILabel *labBottomTipS = [[UILabel alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(labBottomTip.frame) + 10, mScreenWidth - 45, 15)];
    [labBottomTipS setFont:kFontSize(13)];
    [labBottomTipS setTextColor:kHexColor(kColor_Text)];
    [labBottomTipS setNumberOfLines:0];
    [labBottomTipS setText:@"您的发票申请受理后,将于7个工作日寄出。"];
    [self.scrollView addSubview:labBottomTipS];
    
    self.scrollHeight = CGRectGetMaxY(labBottomTipS.frame) + 20;
    [self.scrollView setContentSize:CGSizeMake(mScreenHeight * 2, self.scrollHeight)];
    
    self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.submitButton setFrame:CGRectMake(15, mScreenHeight - 64 - 50, mScreenWidth - 30, 40)];
    [self.submitButton setBackgroundColor:kHexColor(kColor_Mian)];
    [self.submitButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submitButton setTitle:@"提交" forState:UIControlStateNormal];
    self.submitButton.layer.cornerRadius = 4;
    [self.submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitButton];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(mScreenWidth, 0, mScreenWidth, mScreenHeight - 64 - 60) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.scrollView addSubview:_tableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.segmentView = [[RFSegmentView alloc] initWithFrame:CGRectMake(mScreenWidth/2 - 80, 7, 200, 30) items:@[@"索取发票",@"历史开票"]];
    self.segmentView.tintColor = kHexColor(@"#ffba07");
    self.segmentView.delegate = self;
    [self.navigationController.navigationBar addSubview:self.segmentView];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.segmentView.delegate = nil;
    [self.segmentView removeFromSuperview];
}

- (void)segmentViewSelectIndex:(NSInteger)index
{
    NSLog(@"current index is %ld",(long)index);
    self.selectIndex = index;
    if (self.selectIndex == 1) {
        [self.submitButton setHidden:YES];
        [self.scrollView setFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight - 64)];
        [self.scrollView setContentOffset:CGPointMake(mScreenWidth, 0) animated:YES];
    }else{
        [self.submitButton setHidden:NO];
        [self.scrollView setFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight - 64 - 50)];
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void)submitAction:(UIButton *)sender
{
    NSString *name = self.nameField.text;
    NSString *phone = self.phoneField.text;
    NSString *place = self.areaButton.titleLabel.text;
    NSString *address = self.placeField.text;
    
    if ([CommonUtils isBlankString:name]) {
        [CommonUtils showHUDWithMessage:@"请输入姓名" autoHide:YES];
        return;
    }
    if ([CommonUtils isBlankString:phone]) {
        [CommonUtils showHUDWithMessage:@"请输入手机号" autoHide:YES];
        return;
    }
    if ([CommonUtils isBlankString:place]) {
        [CommonUtils showHUDWithMessage:@"请选择区域" autoHide:YES];
        return;
    }
    if ([CommonUtils isBlankString:address]) {
        [CommonUtils showHUDWithMessage:@"请输入街道地址" autoHide:YES];
        return;
    }
    
    NSDictionary *params = @{@"phone":phone,
                             @"cash":@"1",
                             @"name":name,
                             @"area":place,
                             @"address":address};
    [MemberCenterVM applyBillWithParameter:params completion:^(BOOL finish, id obj) {
        if (finish) {
            [CommonUtils showHUDWithMessage:@"发票申请成功" autoHide:YES];
        }
    }];
}

//使用规则
- (void)usePolicyAction:(UITapGestureRecognizer *)recognizer
{
    RoleInfoViewController *roleController = [[RoleInfoViewController alloc] init];
    roleController.roleType = 2;
    [self.navigationController pushViewController:roleController animated:YES];
}

- (void)pickAction:(UIButton *)sender
{
    __weak typeof(self) weakSelf = self;
    SkyerCityPicker *skyerCityPicker = [[SkyerCityPicker alloc] init];
    [skyerCityPicker cityPikerGetSelectCity:^(NSMutableDictionary *dicSelectCity) {
        NSLog(@"dicSelectCity=%@",dicSelectCity);
        
        NSString *address = [NSString stringWithFormat:@"%@%@%@",[dicSelectCity objectForKey:@"Province"],[dicSelectCity objectForKey:@"City"],[dicSelectCity objectForKey:@"District"]];
        [self.areaButton setTitle:address forState:UIControlStateNormal];
    }];
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
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CashOrPrivilCell *cell = [CashOrPrivilCell cellForTableView:tableView];
    ApplyBillModel *model = [self.dataSource objectAtIndex:indexPath.section];
    [cell refreshBillDataWith:model];
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
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
