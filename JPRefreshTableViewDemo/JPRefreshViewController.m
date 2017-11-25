//
//  JPRefreshViewController.m
//  JPRefreshTableViewDemo
//
//  Created by Keep丶Dream on 2017/10/16.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "JPRefreshViewController.h"
#import "JPRefreshTableView.h"
#import "JPRefreshPlaceHolderView.h"

@interface JPRefreshViewController ()<JPRefreshTableViewDataSource,JPRefreshTableViewDelegate,UITableViewDataSource,UITableViewDelegate>
/** placeHolder */
@property(nonatomic,strong) JPRefreshPlaceHolderView *placeHolderView;
@end

@implementation JPRefreshViewController
{
    JPRefreshTableView  *_tableView;
    NSMutableArray      *_dataArray;
}

- (JPRefreshPlaceHolderView *)placeHolderView{
    
    if (!_placeHolderView) {
        
        _placeHolderView = [[JPRefreshPlaceHolderView alloc] initWithPlaceHolderImage:[UIImage imageNamed:@"tututu"] PlaceHolderTip:@"~测试测试~"];
    }
    return _placeHolderView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"代码创建TableView";
    
    _tableView = [[JPRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    _tableView.refreshDataSource = self;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
    
    _dataArray = [NSMutableArray array];
//    for (int i = 0; i < 20; i++) {
//        NSString *str = [NSString stringWithFormat:@"死数据--%d",i];
//        [_dataArray addObject:str];
//    }
    [_tableView jp_reloadData];
}


//代理 刷新回调
- (void)tableView:(JPRefreshTableView *)tablView refreshType:(JPRefreshType)refreshType {
    
    if (refreshType == JPRefreshType_Header) {
        [self p_RefreshHeader];
    }else {
        [self p_RefreshFooter];
    }
}

//数据 隐藏刷新
- (JPHiddenRefresh)hiddenRefreshInTableView:(JPRefreshTableView *)tablView {
    //隐藏头部刷新
    return JPHiddenRefresh_None;
}

- (UIView *)setPlaceHolderViewInTableView:(JPRefreshTableView *)tableView {
    
    self.placeHolderView.placeHolderTip = @"~改变文字~";
    return self.placeHolderView;
}

#pragma mark -下拉/上拉
- (void)p_RefreshHeader {
    
    [_dataArray insertObject:@"下拉--新数据" atIndex:0];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView.mj_header endRefreshing];
        [_tableView jp_reloadData];
    });
}

- (void)p_RefreshFooter {
    
    [_dataArray addObject:@"上拉--新数据"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView.mj_footer endRefreshing];
        [_tableView jp_reloadData];
    });
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

@end
