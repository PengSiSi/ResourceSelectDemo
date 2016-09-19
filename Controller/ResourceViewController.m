//
//  ResourceViewController.m
//  ResourceSelectDemo
//
//  Created by 思 彭 on 16/9/18.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "ResourceViewController.h"
#import "ResourceListViewController.h"
#import "Masonry.h"
#import "UIView+AdjustFrame.h"
#import "DataService.h"
#import "ResourceListModel.h"
#import "SuspendButton.h"
#import "AddResourceFolderController.h"

#define k_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define k_ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ResourceViewController ()<UISearchBarDelegate,ResourceListViewControllerDelegate,UIAlertViewDelegate>


{
    //文件夹名称数组
    NSArray *folderNameArray;
}

@property (nonatomic, strong) NSMutableArray *levelPageStack;
@property (nonatomic, weak) UIView *topPathView;
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, strong) UINavigationController *tableNav;
@property (nonatomic, weak) ResourceListViewController *presentingResourceListViewController;
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic,strong) SuspendButton *suspendBtn;

@end

@implementation ResourceViewController

#pragma mark - base config

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self setInitialData];
    [self createContainerView];
    [self reloadTopPathView];
    [self reloadSearchBar];
    [self createSuspendBtn];
}

- (void)createSuspendBtn {
    //悬浮按钮
    _suspendBtn = [[SuspendButton alloc]initWithFrame:CGRectMake(k_ScreenWidth - 90,k_ScreenHeight - 170 ,50, 50)];
    _suspendBtn.hidden = YES;
    [_suspendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _suspendBtn.titleLabel.font = [UIFont systemFontOfSize:30];
     [_suspendBtn setTitle:@" + " forState:UIControlStateNormal];
     
    _suspendBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.suspendBtn];
    
    __weak typeof(self) weakSelf = self;
    [_suspendBtn setSuspendBtnClicked:^{
       
        UIActionSheet *addActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:weakSelf cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"创建文件夹", nil];
        addActionSheet.tag = 10;
        [addActionSheet showInView:weakSelf.view];

    }];
}

- (void)createContainerView {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(50);
    }];
    ResourceListViewController *tableVC = [[ResourceListViewController alloc] init];
    tableVC.delegate = self;
    tableVC.isRoot = YES;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tableVC];
    nav.navigationBar.hidden = YES;
    self.tableNav = nav;
    [self addChildViewController:nav];
    [view addSubview:nav.view];
    [nav.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    [tableVC reloadData];
    self.presentingResourceListViewController = tableVC;
    self.containerView = view;
}

- (void)reloadTopPathView{
    
    if (self.topPathView) {
        [self.topPathView removeFromSuperview];
        self.topPathView = nil;
    }
    // 没有则创建
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, k_ScreenWidth, 50)];
    scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    if (_levelPageStack.count) {
        CGFloat horizontialSpace = 20;
        // 创建按钮
        NSMutableArray *buttonArray = [NSMutableArray arrayWithCapacity:_levelPageStack.count];
        for (NSInteger i = 0; i < _levelPageStack.count; i++) {
            NSString *title = nil;
            NSString *levelPath = _levelPageStack[i];
            if ([levelPath isKindOfClass:[NSString class]]) {
                title = levelPath;
            }
            UIButton *button = [[UIButton alloc]init];
            button.tag = i;
            [button setTitle:title forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:18];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(levelButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
            [button sizeToFit];
            button.height = 50;
            // 创建 > 按钮
            if (buttonArray.count != 0) {
                UIButton *previousButton = buttonArray[i - 1];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8.5, 11)];
                imageView.image = [UIImage imageNamed:@"virtualroom_resource_choice_icon"];
                [scrollView addSubview:imageView];
                imageView.x = CGRectGetMaxX(previousButton.frame) + horizontialSpace;
                imageView.centerY = previousButton.centerY;
                button.x = CGRectGetMaxX(imageView.frame) + horizontialSpace;
                button.centerY = imageView.centerY;
            }
            [buttonArray addObject:button];
            [scrollView addSubview:button];
        }
        if (buttonArray.count) {
            UIButton *lastButton = buttonArray[buttonArray.count - 1];
            [self.view addSubview:scrollView];
            scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastButton.frame) + horizontialSpace, 50);
            if (scrollView.bounds.size.width < scrollView.contentSize.width) {
                scrollView.contentOffset = CGPointMake(scrollView.contentSize.width - scrollView.bounds.size.width, 0);
            }
            self.topPathView = scrollView;
        }
    }
}

- (void)reloadSearchBar{
    
    if (_levelPageStack.count == 1) {
        [self.searchBar removeFromSuperview];
        self.searchBar = nil;
        [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(50, 0, 0, 0));
        }];
    }
    else{
        if (self.searchBar) {
            self.searchBar.text = nil;
        }
        else {
            UISearchBar *searchBar = [[UISearchBar alloc] init];
            searchBar.delegate = self;
            [self.view addSubview:searchBar];
            self.searchBar = searchBar;
            [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.top.equalTo(self.view).offset(50);
                make.height.mas_equalTo(49);
            }];
            [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(50 + 49, 0, 0, 0));
            }];
      }
   }
}

- (void)setInitialData {
    if (!_levelPageStack) {
        _levelPageStack = [[NSMutableArray alloc] init];
        [_levelPageStack addObject:@"  学科"];
    }
    folderNameArray = [NSArray array];
}

- (void)levelButtonDidClicked: (UIButton *)button{
    
    NSInteger needPopCount = self.levelPageStack.count - 1 - button.tag;
    NSInteger vcCount = self.tableNav.viewControllers.count;
    if (vcCount > needPopCount) {
        UIViewController *vc = self.tableNav.viewControllers[vcCount - needPopCount - 1];
        self.presentingResourceListViewController = (ResourceListViewController *)vc;
        [self.tableNav popToViewController:vc animated:YES];
        while (needPopCount --) {
            [_levelPageStack removeLastObject];
        }
        [self reloadTopPathView];
        [self reloadSearchBar];
    }
}

#pragma mark - resourceListViewControllerDelegate

- (void)resourceListViewController:(ResourceListViewController *)viewController didSelectFolderWithResourceListFolderModel:(ResourceListModel *)folerModel{
    
    ResourceListViewController *tableVC = [[ResourceListViewController alloc] init];
    self.suspendBtn.hidden = NO;
    tableVC.resourceListFolderModel = folerModel;
    tableVC.delegate = self;
    self.presentingResourceListViewController = tableVC;
    [self.tableNav pushViewController:tableVC animated:YES];
    [_levelPageStack addObject:[folerModel folderName]];
    [self reloadTopPathView];
    [self reloadSearchBar];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.presentingResourceListViewController requestThenReloadDataWithSearchWord:searchBar.text];
    [self.searchBar endEditing:YES];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"创建文件夹"]) {
        NSLog(@"创建文件夹");
        AddResourceFolderController *folderVc = [[AddResourceFolderController alloc]init];
        folderVc.block = ^(NSString *folderTitle){
            [self.presentingResourceListViewController createFolderWithFolderName:folderTitle folderDesc:nil];
            
        };
        [self.navigationController pushViewController:folderVc animated:YES];
    }
}

@end
