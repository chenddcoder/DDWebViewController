//
//  WebViewViewController.m
//  PandaPay
//
//  Created by chendd on 2017/4/18.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "DDWebViewController.h"
#import "DDWebviewProgressLine.h"
@interface DDWebViewController ()<UIWebViewDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIWebView *webView;
@property (nonatomic,strong) DDWebviewProgressLine  *progressLine;
@property (nonatomic,strong) UIBarButtonItem * backItem;
@property (nonatomic, strong) UIBarButtonItem * closeItem;
@property (nonatomic, assign) id<UIGestureRecognizerDelegate> delegate;
@end

@implementation DDWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.url=@"wap.baidu.com";
    
    if (![self.url hasPrefix:@"http://"]&&![self.url hasPrefix:@"https://"]&&
        ![self.url hasPrefix:@"/"]) {
        self.url=[NSString stringWithFormat:@"http://%@",self.url];
    }
    NSString *newString = [self.url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSURLRequest * request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:newString]];
    self.webView=[[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview: self.webView];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
    self.progressLine = [[DDWebviewProgressLine alloc] initWithFrame:CGRectMake(self.webView.frame.origin.x, self.webView.frame.origin.y, UIScreen.mainScreen.bounds.size.width, 3)];
    self.progressLine.lineColor = [UIColor colorWithRed:0 green:153.00/255 blue:1 alpha:1];
    [self.view addSubview:self.progressLine];
    [self addBackBtn];
    UITapGestureRecognizer * tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tapGesture];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    if (self.navigationController.viewControllers.count > 1) {
        // 记录系统返回手势的代理
        _delegate = self.navigationController.interactivePopGestureRecognizer.delegate;
        // 设置系统返回手势的代理为当前控制器
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

-(void)tap:(id)sender{
    self.webView.hidden=NO;
    [self.webView reload];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 设置系统返回手势的代理为我们刚进入控制器的时候记录的系统的返回手势代理
    self.navigationController.interactivePopGestureRecognizer.delegate = _delegate;
}
-(void)back:(id)sender{
//    NSLog(@"点击返回");
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        
    }else{
        [self.view resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)close:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.progressLine startLoadingAnimation];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.progressLine endLoadingAnimation];
    if ([webView canGoBack]) {
        [self addCloseBtn];
    }else{
        [self addBackBtn];
    }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"加载失败[%@]",error);
//    [Tool warning:@"加载失败" inView:self.view];
    [self.progressLine endLoadingAnimation];
    self.webView.hidden=YES;
}

-(void)addBackBtn{
    self.navigationItem.leftBarButtonItem =self.backItem;
}
-(void)addCloseBtn{
    self.navigationItem.leftBarButtonItems = @[self.backItem, self.closeItem];
}
- (UIBarButtonItem *)backItem
{
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] init];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        UIImage *image = [UIImage imageNamed:@"nav_back"];
        [btn setImage:image forState:UIControlStateNormal];
        [btn setTitle:NSLocalizedString(@"返回",@"") forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [btn sizeToFit];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        btn.frame = CGRectMake(0, 0, 54, 22);
        _backItem.customView = btn;
    }
    return _backItem;
}
- (UIBarButtonItem *)closeItem
{
    if (!_closeItem) {
        _closeItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"关闭",@"") style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
    }
    return _closeItem;
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer==self.navigationController.interactivePopGestureRecognizer) {
        if ([self.webView canGoBack]) {
            [self.webView goBack];
            return NO;
        }
        return self.navigationController.childViewControllers.count > 1;
    }
    return YES;
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
