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

@interface JPRefreshPlaceHolderView ()

/** imageV */
@property(nonatomic,strong) UIImageView *imageV;
/** tip */
@property(nonatomic,strong) UILabel *tipLabel;

@end

@implementation JPRefreshPlaceHolderView

- (instancetype)initWithPlaceHolderImage:(UIImage *)placeHolderImage PlaceHolderTip:(NSString *)placeHolderTip {
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        self.placeHolderImage = placeHolderImage;
        self.placeHolderTip = placeHolderTip;
        [self p_AddViewsWithImage:placeHolderImage tip:placeHolderTip];
        
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self p_AddViewsWithImage:nil tip:@""];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    
    [super setFrame:frame];
    
    CGFloat kWidth = frame.size.width;
    CGFloat kHeight = frame.size.height;
    
    self.imageV.frame = CGRectMake(0, 0, kImageW, kImageH);
    self.imageV.center =CGPointMake(kWidth/2, kHeight/2-kImageH/2);
    self.tipLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageV.frame),kWidth, 30);
    if (self.placeHolderImage == nil) {
        self.tipLabel.center =CGPointMake(kWidth/2, kHeight/2);
    }

}

#pragma mark -views
- (void)p_AddViewsWithImage:(UIImage *)placeHolderImage tip:(NSString *)placeHolderTip {
    
    UIImageView * imageV = [[UIImageView alloc] init];
    imageV.image = placeHolderImage;
    [self addSubview:imageV];
    self.imageV = imageV;
    if (placeHolderImage == nil) {
        imageV.hidden = YES;
    }
    
    UILabel * tipLabel = [[UILabel alloc] init];
    [self addSubview:tipLabel];
    tipLabel.font = [UIFont systemFontOfSize:15];
    tipLabel.textColor = [UIColor blackColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = (placeHolderTip.length) ? placeHolderTip : @"暂无数据~";
    self.tipLabel = tipLabel;
}


- (void)setPlaceHolderTip:(NSString *)placeHolderTip {
    
    _placeHolderTip = placeHolderTip;
    self.tipLabel.text = placeHolderTip;
}

- (void)setPlaceHolderImage:(UIImage *)placeHolderImage {
    
    _placeHolderImage = placeHolderImage;
    self.imageV.image = placeHolderImage;
}

@end
