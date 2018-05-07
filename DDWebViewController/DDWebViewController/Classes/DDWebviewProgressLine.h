//
//  WebviewProgressLine.h
//  PandaPay
//
//  Created by chendd on 2017/4/18.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDWebviewProgressLine : UIView
//进度条颜色
@property (nonatomic,strong) UIColor  *lineColor;

//开始加载
-(void)startLoadingAnimation;

//结束加载
-(void)endLoadingAnimation;
-(void)endLoadingAnimation:(void(^)(void))finishBlock;
@end
