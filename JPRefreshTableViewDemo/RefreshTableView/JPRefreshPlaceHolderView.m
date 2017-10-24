//
//  JPRefreshPlaceHolderView.m
//  JPRefreshTableViewDemo
//
//  Created by Keep丶Dream on 2017/10/24.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "JPRefreshPlaceHolderView.h"

//默认的title
static NSString *noneDataText = @"暂无数据";
static NSString *filedNetText = @"网络异常,点击屏幕重新加载";
//默认的图片名
static NSString *noneDataImageName = @"D_zanwushuju";
static NSString *filedNetImageName = @"D_wuwangluo";

//图片的宽高
static CGFloat kImageW = 80;
static CGFloat kImageH = 80;


@implementation JPRefreshPlaceHolderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self p_AddViews];
    }
    return self;
}

#pragma mark -views
- (void)p_AddViews {
    
    CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kImageW, kImageH)];
    CGPoint imageCenter = CGPointMake(kWidth/2, kHeight/2);
    imageV.center = imageCenter;
    imageV.image = [UIImage imageNamed:noneDataImageName];
    [self addSubview:imageV];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame),kWidth, 30)];
    [self addSubview:label];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = noneDataText;

}




@end
