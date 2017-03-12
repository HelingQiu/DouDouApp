//
//  SearchParkingViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/3/7.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "SearchParkingViewController.h"
#import "NearByParkingListCell.h"
#import "FindParkingVM.h"

@interface SearchParkingViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation SearchParkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self setConfigView];
}

- (void)setConfigView
{
    UIView *naviView = [[UIView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    naviView.backgroundColor = kHexColor(kColor_Mian);
    self.navigationItem.titleView = naviView;
    
    NSLog(@"nav width - %f", self.navigationController.navigationBar.frame.size.width); // 宽度
    UITextField *searchField = [[UITextField alloc] initWithFrame:CGRectMake(20, 7, self.navigationController.navigationBar.width - 100, 30)];
    [searchField setPlaceholder:@"停车场名字、地点"];
    [searchField setBackgroundColor:[UIColor whiteColor]];
    searchField.clipsToBounds = YES;
    searchField.layer.cornerRadius = 6;
    searchField.returnKeyType = UIReturnKeyDone;
    searchField.delegate = self;
    [searchField becomeFirstResponder];
    [searchField addTarget:self action:@selector(textDidChangeValue:) forControlEvents:UIControlEventEditingChanged];
    [naviView addSubview:searchField];
    
    UIView *viewBg = [[UIView alloc] initWithFrame:(CGRect){0,0,25,30}];
    [viewBg setBackgroundColor:[UIColor clearColor]];
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:(CGRect){5, 5, 20, 20}];
    [leftView setImage:[UIImage imageNamed:@"find_parking_search"]];
    [viewBg addSubview:leftView];
    [searchField setLeftView:viewBg];
    [searchField setLeftViewMode:UITextFieldViewModeAlways];
}

- (void)getNearByParkingData:(NSString *)keyword
{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouUserId];
    NSDictionary *params = @{@"latitude":[NSNumber numberWithDouble:self.locationPt.latitude],
                             @"longitude":[NSNumber numberWithDouble:self.locationPt.longitude],
                             @"keyword":keyword,
                             @"city":_locationCity?:@"",
                             @"userId":userId?:@"",
                             @"isBook":@"",
                             @"province":@""};
    [FindParkingVM getNearByParkingWithParameter:params completion:^(BOOL finish, id obj) {
        if (finish) {
            self.dataSource = [obj copy];
            if (self.tableView) {
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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NearbyModel *model = [self.dataSource objectAtIndex:indexPath.row];
    if (self.block) {
        self.block(model);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -
- (void)textDidChangeValue:(UITextField *)textField
{
    [self getNearByParkingData:textField.text];
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
