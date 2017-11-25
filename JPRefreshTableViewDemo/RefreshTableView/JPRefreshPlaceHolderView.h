//
//  JPRefreshPlaceHolderView.h
//  JPRefreshTableViewDemo
//
//  Created by Keep丶Dream on 2017/10/24.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPRefreshPlaceHolderView : UIView

- (instancetype)initWithPlaceHolderImage:(UIImage *)placeHolderImage PlaceHolderTip:(NSString *)placeHolderTip;

/** 占位图 */
@property(nonatomic,strong) UIImage *placeHolderImage;
/** tips */
@property(nonatomic,strong) NSString *placeHolderTip;


@end
