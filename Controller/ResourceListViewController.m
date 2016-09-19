//
//  ResourceListViewController.m
//  ResourceSelectDemo
//
//  Created by 思 彭 on 16/9/18.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "ResourceListViewController.h"
#import "DataService.h"
#import "ResourceListModel.h"
#import "ResourceListTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "ResourceFileModel.h"

#import "Masonry.h"

#define k_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define k_ScreenHeight [UIScreen mainScreen].bounds.size.height

static NSString *const identifier = @"cell";

@interface ResourceListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger size;

@end

@implementation ResourceListViewController

// 这里写了的话,永远不会创建新的文件夹,因为视图出现的时候每次刷新都是加载的json文件的数据
//- (void)viewWillAppear:(BOOL)animated {
//    if (!_isRoot) {
//        [self requestDataThenRefresh];
//    }
//}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self createUI];
    [self requestDataThenRefresh];
}

- (void)createUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.bottom.mas_equalTo(self.view);
    }];
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,k_ScreenWidth , FLT_EPSILON)];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, k_ScreenWidth, FLT_EPSILON)];
    tableView.dataSource = self;
    tableView.delegate = self;
    [_tableView registerNib:[UINib nibWithNibName:@"ResourceListTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
}

// 获取班级学科文件夹
- (void)requestDataThenRefresh {
    
    if (self.isRoot) {
        
        NSDictionary *json = [DataService loadDataWithJSONFileName:@"subject"];
        NSLog(@"json--  %@",json);
        NSArray *jsonArray = json[@"list"];
        if (self.dataArray.count) {
            [self.dataArray removeAllObjects];
        }
        for (NSDictionary *dic in jsonArray) {
            ResourceListModel *model = [[ResourceListModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        [self reloadData];
    }
    else{
        
        NSDictionary *json = [DataService loadDataWithJSONFileName:@"subject1"];
        NSLog(@"json--  %@",json);
        NSArray *jsonArray = json[@"list"];
        if (self.dataArray.count) {
            [self.dataArray removeAllObjects];
        }
        for (NSDictionary *dic in jsonArray) {
            ResourceListModel *model = [[ResourceListModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        [self reloadData];
    }
}

- (void)requestThenReloadDataWithSearchWord:(NSString *)searchWord{
    
    NSLog(@"搜索...");
}

- (void)reloadData{
    
    [self.tableView reloadData];
}

- (void)createFolderWithFolderName:(NSString *)folderName folderDesc:(NSString *)folderDesc{
    
    ResourceListModel *model = [[ResourceListModel alloc]init];
    model.folderName = folderName;
    model.folderId = @"11";
    model.courseId = @"22";
    model.date = @"33";
    [self.dataArray addObject:model];
    NSLog(@"self.dataArray = %@",self.dataArray);
    [self reloadData];
}

#pragma mark - tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:identifier configuration:^(id cell) {
        [self configureResourceListTableViewCell:cell atIndexPath:indexPath];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20/2;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResourceListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [self configureResourceListTableViewCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(resourceListViewController:didSelectFolderWithResourceListFolderModel:)]) {
        [self.delegate resourceListViewController:self didSelectFolderWithResourceListFolderModel:self.dataArray[indexPath.section]];
    }
}

#pragma mark - cell样式
- (void)configureResourceListTableViewCell:(ResourceListTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.resourceListModel = self.dataArray[indexPath.section];
}

#pragma mark - 懒加载

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
