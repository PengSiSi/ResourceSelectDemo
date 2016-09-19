//
//  ResourceFileModel.h
//  ResourceSelectDemo
//
//  Created by 思 彭 on 16/9/18.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResourceFileModel : NSObject

@property (copy, nonatomic) NSString *resourceId;/**< 资源id*/
@property (copy, nonatomic) NSString *resourceName;/**< 资源名*/
@property (copy, nonatomic) NSString *resourceUseName;/**< 资源重用名*/
@property (copy, nonatomic) NSString *resourceUrl;/**< 资源地址*/
@property (copy, nonatomic) NSString *resourceTime;/**< 资源时间*/
@property (copy, nonatomic) NSString *checkType;/**< 审核状态 0:审核通过 1 待审核*/
@property (copy, nonatomic) NSString *resourceAuthor;/**< 发布人*/
@property (copy, nonatomic) NSString *type;/**< 资源类型 1文档 2视频 3图片 4其他*/
@property (copy, nonatomic) NSString *date;/**< 日期*/

@end
