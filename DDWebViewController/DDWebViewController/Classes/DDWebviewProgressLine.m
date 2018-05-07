//
//  WebviewProgressLine.m
//  PandaPay
//
//  Created by chendd on 2017/4/18.
//  Copyright © 2017年 icfcc. All rights reserved.
//

#import "DDWebviewProgressLine.h"
@implementation DDWebviewProgressLine
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    self.backgroundColor = lineColor;
}

-(void)startLoadingAnimation{
    self.hidden = NO;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 0, self.frame.size.height);
    
    __weak UIView *weakSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, UIScreen.mainScreen.bounds.size.width * 0.6, self.frame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, UIScreen.mainScreen.bounds.size.width * 0.8, self.frame.size.height);
        }];
    }];
    
    
}
-(void)endLoadingAnimation{
    [self endLoadingAnimation:nil];
}
-(void)endLoadingAnimation:(void(^)(void))finishBlock{
    __weak UIView *weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, UIScreen.mainScreen.bounds.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
        if (finishBlock) {
            finishBlock();
        }
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
