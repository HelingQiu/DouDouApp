//
//  FeedbackViewController.m
//  DouDouStopCar
//
//  Created by Rainer on 2017/3/11.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "FeedbackViewController.h"
#import "JJSPlaceholderTextView.h"
#import "MemberCenterVM.h"

@interface FeedbackViewController ()<UITextViewDelegate>
{
    JJSPlaceholderTextView *_textView;
}
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的建议";
    [self setConfigView];
}

- (void)setConfigView
{
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    _textView = [[JJSPlaceholderTextView alloc] initWithFrame:CGRectMake(15.0f, 20.0f, mScreenWidth - 30, 200)];
    _textView.delegate = self;
    _textView.placeholder = @"终于等到你, 期待你的意见~~";
    _textView.placeholderColor = kHexColor(kColor_Text);
    [_textView setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_textView setAutocorrectionType:UITextAutocorrectionTypeNo];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.contentInset = UIEdgeInsetsMake(0,5,0,-5);
    _textView.returnKeyType = UIReturnKeyDone;
    //配合textview plackholder cololr
    _textView.textColor = kHexColor(kColor_Text);
    //真正textview text color
    _textView.realTextColor = [UIColor blackColor];
    [self.view addSubview:_textView];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setFrame:CGRectMake(15, CGRectGetMaxY(_textView.frame) + 40, mScreenWidth - 30, 40)];
    submitButton.layer.cornerRadius = 4;
    [submitButton setBackgroundColor:kHexColor(kColor_Mian)];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}

- (void)submitAction:(UIButton *)sender
{
    NSString *feedback = _textView.text;
    if ([CommonUtils isBlankString:feedback]) {
        [CommonUtils showHUDWithMessage:@"请输入您的建议" autoHide:YES];
        return;
    }
    
    NSDictionary *params = @{@"text":feedback};
    [MemberCenterVM feedbackWithParameter:params completion:^(BOOL finish, id obj) {
        if (finish) {
            [self performSelector:@selector(goback) withObject:nil afterDelay:1];
        }
    }];
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
