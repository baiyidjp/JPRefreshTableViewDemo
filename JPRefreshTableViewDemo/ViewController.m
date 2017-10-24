//
//  ViewController.m
//  JPRefreshTableViewDemo
//
//  Created by Keep丶Dream on 2017/10/16.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "ViewController.h"
#import "JPRefreshTableView.h"
#import "JPRefreshViewController.h"

@interface ViewController ()<JPRefreshTableViewDelegate,JPRefreshTableViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet JPRefreshTableView *tableView;

@end

@implementation ViewController
{
    NSMutableArray  *_dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //通过xib
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.refreshDelegate = self;
    self.tableView.refreshDataSource = self;
    
    _dataArray = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        NSString *str = [NSString stringWithFormat:@"死数据--%d",i];
        [_dataArray addObject:str];
    }
    [self.tableView jp_reloadData];
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
    
    return JPHiddenRefresh_None;
}

#pragma mark -下拉/上拉
- (void)p_RefreshHeader {
    
    [_dataArray insertObject:@"下拉--新数据" atIndex:0];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView jp_reloadData];
    });
}

- (void)p_RefreshFooter {
    
    [_dataArray addObject:@"上拉--新数据"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
        [self.tableView jp_reloadData];
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

- (IBAction)rightItemClick:(id)sender {
    
    [self.navigationController pushViewController:[[JPRefreshViewController alloc] init] animated:YES];
}

@end
