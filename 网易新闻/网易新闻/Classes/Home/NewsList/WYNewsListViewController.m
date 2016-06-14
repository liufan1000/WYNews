//
//  WYNewsListViewController.m
//  网易新闻
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "WYNewsListViewController.h"
#import "WYNewsListItem.h"
#import "WYNewsNormalCell.h"
#import "WYNewsExtraImagesCell.h"
#import <UIImageView+WebCache.h>

static NSString *normalCellId = @"normalCellId";
static NSString *extraCellId = @"extraCellId";

@interface WYNewsListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;

/**
 * 新闻列表数组
 */
@property (nonatomic, strong) NSMutableArray <WYNewsListItem *> *newsList;
@end

@implementation WYNewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 加载数据
- (void)loadData {
    
    [[CZNetworkManager sharedManager] newsListWithChannel:@"T1348649079062" start:0 completion:^(NSArray *array, NSError *error) {
        // 字典的数组 - 字典转`模型`
        NSLog(@"%@", array);
        
        // 字典转模型
        NSArray *list = [NSArray yy_modelArrayWithClass:[WYNewsListItem class] json:array];
        
        // 设置给 新闻数组
        self.newsList = [NSMutableArray arrayWithArray:list];
        
        // 刷新表格
        [self.tableView reloadData];
    }]; 
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 根据模型判断 cellId
    WYNewsListItem *model = _newsList[indexPath.row];
    
    NSString *cellId;
    
    if (model.imgextra.count > 0) {
        cellId = extraCellId;
    } else {
        cellId = normalCellId;
    }
    
    // TODO: 处理 Cell 的不同！
    WYNewsExtraImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    // 2. 设置数据
    cell.titleLabel.text = model.title;
    cell.sourceLabel.text = model.source;
    cell.replyLabel.text = @(model.replyCount).description;
    
    // 设置图片
    NSURL *imageURL = [NSURL URLWithString:model.imgsrc];
    [cell.iconView sd_setImageWithURL:imageURL];
    
    // 设置多图 － 如果没有不会进入循环
    NSInteger idx = 0;
    for (NSDictionary *dict in model.imgextra) {
        
        // 1. 获取url字符串
        NSURL *url = [NSURL URLWithString:dict[@"imgsrc"]];
        
        // 2. 设置图像
        UIImageView *iv = cell.extraIcon[idx++];
        
        [iv sd_setImageWithURL:url];
    }
    
    return cell;
}

#pragma mark - 设置界面
- (void)setupUI {
    
    UITableView *tv = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    [self.view addSubview:tv];
    
    // 自动布局
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 注册原型 cell
    [tv registerNib:[UINib nibWithNibName:@"WYNewsNormalCell" bundle:nil] forCellReuseIdentifier:normalCellId];
    [tv registerNib:[UINib nibWithNibName:@"WYNewsExtraImagesCell" bundle:nil] forCellReuseIdentifier:extraCellId];
    
    // 设置自动行高
    tv.estimatedRowHeight = 100;
    tv.rowHeight = UITableViewAutomaticDimension;
    
    // 设置数据源和代理
    tv.dataSource = self;
    tv.delegate = self;
    
    // 记录成员变量
    _tableView = tv;
}

@end
