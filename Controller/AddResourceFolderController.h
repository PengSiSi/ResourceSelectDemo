//
//  AddResourceFolderController.h
//  ResourceSelectDemo
//
//  Created by 思 彭 on 16/9/18.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddResourceFolderBlock)(NSString *folderString);

@interface AddResourceFolderController : UIViewController

@property (nonatomic,copy) AddResourceFolderBlock block; /*<#id#>*/

@end
