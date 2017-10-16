//
//  JPRefreshTableView.m
//  JPRefreshTableViewDemo
//
//  Created by Keep丶Dream on 2017/10/16.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "JPRefreshTableView.h"


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


@end
