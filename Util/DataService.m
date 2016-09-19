//
//  DataService.m
//  WXMovie
//
//  Created by liuwei on 15/8/28.
//  Copyright (c) 2015年 wxhl. All rights reserved.
//

#import "DataService.h"


@implementation DataService

+ (id)loadDataWithJSONFileName:(NSString *)fileName {

    NSError *error;
    
    //1.读取JSON文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    
    //2.NSData类读取JSON文件内容
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    //3.解析
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    return result;

}

@end
