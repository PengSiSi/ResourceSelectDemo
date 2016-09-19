//
//  ResourceListModel.h
//  ResourceSelectDemo
//
//  Created by 思 彭 on 16/9/18.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResourceListModel : NSObject

@property (copy, nonatomic) NSString *folderId;/**< 资源Id*/
@property (copy, nonatomic) NSString *folderName;/**< 资源名*/
@property (copy, nonatomic) NSString *courseId;/**< 资源重命名*/
@property (copy, nonatomic) NSString *date;/**< 日期*/


@end
