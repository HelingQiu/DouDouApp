//
//  AddCarNumberViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/2/21.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "AddCarNumberViewController.h"
#import "CustomCollectionView.h"
#import "MemberCenterVM.h"

@interface AddCarNumberViewController ()<UITextFieldDelegate>
{
    NSString *_carNumStr;
    UIView *_carCardView;
}
@property (nonatomic, strong) NSMutableArray *labelArray;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) UIView *selectView;
@property (nonatomic, strong) CustomCollectionView *customView;
@end

@implementation AddCarNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.model) {
        self.navigationItem.title = @"修改车牌";
    }else{
        self.navigationItem.title = @"添加车牌";
    }
    
    _labelArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    _carNumStr = self.model.plateNumber;
    [self addCarView];
    [self setSubmitButton];
}

- (void)setSubmitButton
{
    CGFloat width = (mScreenWidth - 30)/7.0;
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setFrame:CGRectMake(15, width + 70, mScreenWidth - 30, 40)];
    submitButton.layer.cornerRadius = 4;
    [submitButton setBackgroundColor:kHexColor(kColor_Mian)];
    
    if (self.model) {
        [submitButton setTitle:@"修改车牌" forState:UIControlStateNormal];
    }else{
        [submitButton setTitle:@"绑定车牌" forState:UIControlStateNormal];
    }
    
    [submitButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}

- (void)submitAction:(UIButton *)sender
{
    if (_carNumStr.length == 7) {
        if (self.model) {
            //修改车牌
            NSDictionary *params = @{@"plateNumber":self.model.plateNumber?:@"",
                                     @"newPlateNumber":_carNumStr};
            [MemberCenterVM changeCarNumberWithParameter:params completion:^(BOOL finish, id obj) {
                if (finish) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }else{
            //绑定车牌
            NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:kDouDouUserId];
            NSDictionary *params = @{@"userId":userId?:@"",
                                     @"plateNumber":_carNumStr};
            
            [MemberCenterVM addCarNumberWithParameter:params completion:^(BOOL finish, id obj) {
                if (finish) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }
        
    }else{
        [CommonUtils showHUDWithMessage:@"请输入正确车牌号" autoHide:YES];
        return;
    }
}

- (void)addCarView
{
    CGFloat width = (mScreenWidth - 30)/7.0;
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(15, 30, mScreenWidth - 30, width)];
//    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderColor = [kHexColor(kColor_Mian) CGColor];
    bgView.layer.borderWidth = 1.0f;
    [self.view addSubview:bgView];
    _carCardView = bgView;
    
    [self createCustomView];
    
    for (NSInteger i = 0; i < 7; i ++) {
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(width *i, 0, width, width)];
        textLabel.tag = i;
        textLabel.textAlignment = NSTextAlignmentCenter;
        [_carCardView addSubview:textLabel];
        
        if (self.model) {
            NSString *temp = [self.model.plateNumber substringWithRange:NSMakeRange(i,1)];
            textLabel.text = temp;
        }else{
            if (i == 0) {
                textLabel.text = @"京";
            }
        }
        
        if ( i!= 6) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(textLabel.frame) - 1, 0, 1, width)];
            lineView.backgroundColor = kHexColor(kColor_Gray);
            [textLabel addSubview:lineView];
        }
        
        UITapGestureRecognizer *tapLabel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLabelClick:)];
        textLabel.userInteractionEnabled = YES;
        tapLabel.numberOfTapsRequired = 1;
        [textLabel addGestureRecognizer:tapLabel];
        
        [_labelArray addObject:textLabel];
    }
    
    _selectView = [[UIView alloc]initWithFrame:CGRectMake(2, 2, width - 4, width - 4)];
    _selectView.layer.borderColor = [kHexColor(@"#ffba07") CGColor];
    _selectView.layer.masksToBounds = YES;
    _selectView.layer.borderWidth = 1.0;
//    _selectView.layer.cornerRadius = 5;
    
    [_carCardView addSubview:_selectView];
    
    
    if (self.model) {
        [_selectView setFrame:CGRectMake(2 + width * 6,2, width - 4, width - 4)];
    }
}
- (void)tapLabelClick:(UITapGestureRecognizer *)tap{
    
    CGFloat width = (mScreenWidth - 30)/7.0;
    
    NSInteger index = tap.view.tag;
    UILabel *label = (UILabel *)tap.view;
    [UIView animateWithDuration:0.35 animations:^{
        _selectView.frame = CGRectMake(label.frame.origin.x + 2, 2, width - 4, width - 4);
    }];
    [self selectTabelWithIndex:index];
}
- (void)selectTabelWithIndex:(NSInteger)index{
    _selectIndex = index;
    _selectView.hidden = NO;
    
    [_customView changeDataSourceWithIndex:index];
    [UIView animateWithDuration:0.35 animations:^{
        _customView.frame = CGRectMake(0, (mScreenHeight - _customView.height - 64), mScreenWidth, _customView.height);
    }];
}

- (void)createCustomView{
    CGFloat width = (mScreenWidth - 30)/7.0;
    
    CustomCollectionView *customView = [[CustomCollectionView alloc]initWithFrame:CGRectMake(0, mScreenHeight, mScreenWidth, 0)];
    [self.view addSubview:customView];
    _customView = customView;
    
    __weak typeof(self) weakSelf = self;
    _customView.selectBlock = ^(NSString *selectValue){
        UILabel *selectLabel = (UILabel *)weakSelf.labelArray[weakSelf.selectIndex];
        selectLabel.text = selectValue;
        if (weakSelf.selectIndex == 6) {
            weakSelf.selectIndex = 6;
            BOOL isHaveEmpty =  [weakSelf checkAllLabelHaveValue];
            if (!isHaveEmpty) {
                weakSelf.selectView.hidden = YES;
                [UIView animateWithDuration:0.35 animations:^{
                    weakSelf.customView.frame = CGRectMake(0, mScreenHeight, mScreenWidth, weakSelf.customView.height);
                }];
            }
            
        }else{
            weakSelf.selectIndex ++;
            UILabel *nextLabel = weakSelf.labelArray[weakSelf.selectIndex];
            [UIView animateWithDuration:0.35 animations:^{
                weakSelf.selectView.frame = CGRectMake(nextLabel.x + 2, 2, width - 4, width - 4);
            }];
            [weakSelf.customView changeDataSourceWithIndex:weakSelf.selectIndex];
            [UIView animateWithDuration:0.35 animations:^{
                weakSelf.customView.frame = CGRectMake(0, (mScreenHeight - 64 - weakSelf.customView.height), mScreenWidth, weakSelf.customView.height);
            }];
        }
        [weakSelf getCarNum];
    };
    _customView.deleteBlock = ^(){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.selectView.hidden = NO;
        UILabel *selectLabel = (UILabel *)strongSelf.labelArray[strongSelf.selectIndex];
        selectLabel.text = @"";
        if (strongSelf.selectIndex == 0) {
            strongSelf.selectIndex = 0;
        }else
            strongSelf.selectIndex --;
        
        UILabel *nextLabel = strongSelf.labelArray[strongSelf.selectIndex];
        [UIView animateWithDuration:0.35 animations:^{
            strongSelf.selectView.frame = CGRectMake(nextLabel.x + 2 , 2, width - 4, width - 4);
        }];
        [strongSelf.customView changeDataSourceWithIndex:strongSelf.selectIndex];
        [UIView animateWithDuration:0.35 animations:^{
            strongSelf.customView.frame = CGRectMake(0, mScreenHeight -strongSelf.customView.height - 64, mScreenWidth, strongSelf.customView.height);
        }];
        [strongSelf getCarNum];
        
    };
//    _customView.sureBlock = ^(){
//        [UIView animateWithDuration:0.35 animations:^{
//            _customView.frame = CGRectMake(0, (KHeight - 64), KWidth, _customView.height);
//        }];
//    };
    if (self.model) {
        [self selectTabelWithIndex:6];
    }else{
        
        [self selectTabelWithIndex:0];
    }
    
}

- (NSString *)getCarNum
{
    _carNumStr = @"";
    BOOL isHaveEmpety = NO;
    for (NSInteger i = 0; i < _labelArray.count; i ++) {
        UILabel *label = [_labelArray objectAtIndex:i];
        if ([self isBlankString:label.text]) {
            isHaveEmpety = YES;
        }
        _carNumStr = [_carNumStr stringByAppendingString:[self getStringByString:label.text]];
    }
    NSLog(@"%@",_carNumStr);
    return _carNumStr;
}

-  (NSString *)getStringByString:(NSString*)str
{
    if (str == nil || [str isKindOfClass:[NSNull class]]) {
        return @"";
    }else
        return str;
}

- (BOOL)checkAllLabelHaveValue
{
    BOOL haveEmpty = NO;
    for (NSInteger i = 0; i < _labelArray.count; i ++) {
        UILabel *label = [_labelArray objectAtIndex:i];
        if ([self isBlankString:label.text]) {
            haveEmpty = YES;
            break;
        }
    }
    return haveEmpty;
}
- (BOOL) isBlankString:(NSString *)string {
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    if ([string isEqualToString:@""] || string == nil || string == NULL || [string isEqualToString :@"null" ]|| [string isEqualToString:@"<null>"]) {
        
        return YES;
        
    }
    
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
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
