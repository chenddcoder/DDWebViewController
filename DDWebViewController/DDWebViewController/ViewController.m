//
//  ViewController.m
//  DDWebViewController
//
//  Created by 陈丁丁 on 2018/5/7.
//  Copyright © 2018年 陈丁丁. All rights reserved.
//

#import "ViewController.h"
#import "DDWebViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    DDWebViewController * webVC=[[DDWebViewController alloc]init];
    webVC.url=@"https://www.baidu.com";
    [self presentViewController:webVC animated:true completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
