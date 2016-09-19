//
//  DataService.h
//  WXMovie
//
//  Created by liuwei on 15/8/28.
//  Copyright (c) 2015年 wxhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataService : NSObject


//根据传入的JSON文件名,解析JSON数据

+ (id)loadDataWithJSONFileName:(NSString *)fileName;
@end
