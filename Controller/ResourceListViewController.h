//
//  ResourceListViewController.h
//  ResourceSelectDemo
//
//  Created by 思 彭 on 16/9/18.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ResourceListViewController;
@class ResourceListModel;

@protocol ResourceListViewControllerDelegate <NSObject>

// 选中文件
- (void)resourceListViewController:(ResourceListViewController *)viewController didSelectFileWithResourceListFileModel:(ResourceListModel *)fileModel;

// 选中文件夹
- (void)resourceListViewController:(ResourceListViewController *)viewController didSelectFolderWithResourceListFolderModel:(ResourceListModel *)folerModel;

@end

@interface ResourceListViewController : UIViewController

@property (nonatomic, assign) BOOL isRoot;
@property (nonatomic, strong) ResourceListModel *resourceListFolderModel;/**< 文件夹model*/
@property (nonatomic, weak) id<ResourceListViewControllerDelegate>delegate;

- (void)reloadData;
- (void)requestThenReloadDataWithSearchWord:(NSString *)searchWord;
- (void)createFolderWithFolderName:(NSString *)folderName folderDesc:(NSString *)folderDesc;

@end
