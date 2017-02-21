//
//  NewsViewController.m
//  CancerExpertsStudio_Paitent
//
//  Created by Rainer on 17/1/11.
//  Copyright © 2017年 KMHealthCloud Co.ltd. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSURLRequest *request;
@property (assign, nonatomic) BOOL authenticated;
@property (nonatomic, strong) NSURLConnection *urlConnection;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initilizeCustomView];
    
    [CommonUtils showHUDWithWaitingMessage:nil];
    
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    
    self.request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlstring]];
    [self.webView loadRequest:self.request];
}

- (void)initilizeCustomView
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight - 64)];
    [self.view addSubview:self.webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [CommonUtils hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [CommonUtils hideHUD];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSLog(@"Did start loading: %@ auth:%d", [[request URL] absoluteString], _authenticated);
    
    if (!_authenticated) {
        
        _authenticated = NO;
        
        _urlConnection = [[NSURLConnection alloc] initWithRequest:_request delegate:self];
        
        [_urlConnection start];
        
        return NO;
    }
    return YES;
}

#pragma mark - NURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;
{
    NSLog(@"WebController Got auth challange via NSURLConnection");
    
    if ([challenge previousFailureCount] == 0)
    {
        _authenticated = YES;
        
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
        
    } else
    {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

// We use this method is to accept an untrusted site which unfortunately we need to do, as our PVM servers are self signed.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
{
    NSLog(@"WebController received response via NSURLConnection");
    
    // remake a webview call now that authentication has passed ok.
    _authenticated = YES;
    [self.webView loadRequest:_request];
    
    // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
    [_urlConnection cancel];
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
