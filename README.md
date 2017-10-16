# JPRefreshTableViewDemo
自带刷新控件的tableView   

- 将文件夹RefreshTableView拖入程序中(若已有MJRfresh则移除)   
- 让需要的tableView继承 JPRefreshTableView   
- 需要刷新回调请遵循 JPRefreshTableViewDelegate 代理 并调用代理方法   
- 需要隐藏头部或者底部刷新请遵循 JPRefreshTableViewDataSource 数据源 并返回需要隐藏的值   
- 其他具体使用请参考 viewController 代码
