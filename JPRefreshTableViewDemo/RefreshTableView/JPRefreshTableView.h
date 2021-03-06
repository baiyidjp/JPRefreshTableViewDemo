//
//  JPRefreshTableView.h
//  JPRefreshTableViewDemo
//
//  Created by Keep丶Dream on 2017/10/16.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPRefreshPlaceHolderView.h"
#import "MJRefresh.h"

//刷新的状态 上拉/下拉
typedef NS_ENUM(NSInteger, JPRefreshType) {
    JPRefreshType_None,
    JPRefreshType_Header,//头部
    JPRefreshType_Footer//底部
};

//需要隐藏的刷新状态
typedef NS_ENUM(NSInteger, JPHiddenRefresh) {
    JPHiddenRefresh_None,
    JPHiddenRefresh_Header,//头部
    JPHiddenRefresh_Footer,//底部
    JPHiddenRefresh_All//头部加底部
};

@class JPRefreshTableView;
@protocol JPRefreshTableViewDelegate <NSObject>

/**
 JPRefreshTableViewDelegate
 
 @param tablView 带刷新控件的tableView
 @param refreshType 刷新回调的状态
 */
- (void)tableView:(JPRefreshTableView *)tablView refreshType:(JPRefreshType)refreshType;

@end

@protocol JPRefreshTableViewDataSource <NSObject>

@optional
/**
 JPRefreshTableViewDataSource
 
 @param tablView 带刷新控件的tableView
 @return 需要隐藏的刷新状态
 */
- (JPHiddenRefresh)hiddenRefreshInTableView:(JPRefreshTableView *)tablView;

/**
 返回自定义占位View
 自动处理适应tableView的frame
 
 @return view
 */
- (UIView *)setPlaceHolderViewInTableView:(JPRefreshTableView *)tableView;

@end


/**
 带MJ刷新控件的tableView 适用于代码创建和XIB创建
 */
@interface JPRefreshTableView : UITableView

/** delegate */
@property(nonatomic,weak) id<JPRefreshTableViewDelegate> refreshDelegate;

@property(nonatomic,weak) id<JPRefreshTableViewDataSource> refreshDataSource;

/** PlaceHolderView */
@property(nonatomic,strong) UIView *placeHolderView;

/**
 无数据加载占位图必须使用这个刷新
 */
- (void)jp_reloadData;

- (void)jp_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;

- (void)jp_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
@end
