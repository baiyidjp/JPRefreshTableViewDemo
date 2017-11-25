//
//  JPRefreshTableView.m
//  JPRefreshTableViewDemo
//
//  Created by Keep丶Dream on 2017/10/16.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "JPRefreshTableView.h"
#import "JPRefreshPlaceHolderView.h"
#import <objc/runtime.h>

const char *placeHolderViewKey = "placeHolderViewKey";

@implementation JPRefreshTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        [self p_Setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self p_Setup];
    }
    return self;
}

#pragma mark -设置
- (void)p_Setup {
    
    self.estimatedRowHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = refreshHeader;
    
    MJRefreshAutoNormalFooter *refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    self.mj_footer = refreshFooter;
    
    
}

- (void)setRefreshDataSource:(id<JPRefreshTableViewDataSource>)refreshDataSource {
    
    _refreshDataSource = refreshDataSource;
    BOOL isHiddenHeader = NO;
    BOOL isHiddenFooter = NO;
    
    if ([refreshDataSource respondsToSelector:@selector(hiddenRefreshInTableView:)]) {
        
        JPHiddenRefresh refresh = [refreshDataSource hiddenRefreshInTableView:self];
        if (refresh == JPHiddenRefresh_All) {
            isHiddenFooter = YES;
            isHiddenHeader = YES;
        }else if (refresh == JPHiddenRefresh_Header) {
            isHiddenHeader = YES;
        }else if (refresh == JPHiddenRefresh_Footer) {
            isHiddenFooter = YES;
        }
    }
    if (isHiddenHeader) {
        [self.mj_header removeFromSuperview];
    }
    if (isHiddenFooter) {
        [self.mj_footer removeFromSuperview];
    }
}

#pragma mark -下拉/上拉
- (void)refreshHeader {
    
    if ([self.refreshDelegate respondsToSelector:@selector(tableView:refreshType:)]) {
        [self.refreshDelegate tableView:self refreshType:JPRefreshType_Header];
    }
}

- (void)refreshFooter {
    
    if ([self.refreshDelegate respondsToSelector:@selector(tableView:refreshType:)]) {
        [self.refreshDelegate tableView:self refreshType:JPRefreshType_Footer];
    }
    
}

- (void)jp_reloadData {
    
    [self reloadData];
    [self p_CheckDataSource];
}

- (UIView *)placeHolderView {
    
    return objc_getAssociatedObject(self, placeHolderViewKey);
}

- (void)setPlaceHolderView:(UIView *)placeHolderView {
    
    objc_setAssociatedObject(self, placeHolderViewKey, placeHolderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -监测是否为空数据源
- (void)p_CheckDataSource {
    
    BOOL isNoData = YES;
    
    id<UITableViewDataSource> source = self.dataSource;
    NSInteger sections = 1;
    if ([source respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [source numberOfSectionsInTableView:self];
    }
    for (NSInteger i = 0; i < sections ; i++) {
        NSInteger rows = [source tableView:self numberOfRowsInSection:i];
        if (rows) {
            isNoData = NO;
        }
    }
    //互斥的存在
    if (!isNoData != !self.placeHolderView) {
        
        if (isNoData) {
            if ([self.refreshDataSource respondsToSelector:@selector(setPlaceHolderViewInTableView:)]) {
                self.placeHolderView = [self.refreshDataSource setPlaceHolderViewInTableView:self];
            }else {
                self.placeHolderView = [[JPRefreshPlaceHolderView alloc] init];//自己写
            }
            self.placeHolderView.frame = self.frame;
            [self addSubview:self.placeHolderView];
        }else {
            [self.placeHolderView removeFromSuperview];
            self.placeHolderView = nil;
        }
    }else if (isNoData) {
        //永远保证占位View在最上层
        [self.placeHolderView removeFromSuperview];
        [self addSubview:self.placeHolderView];
    }
}


@end
