//
//  AddResourceFolderController.m
//  ResourceSelectDemo
//
//  Created by 思 彭 on 16/9/18.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "AddResourceFolderController.h"
#define k_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define k_ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface AddResourceFolderController ()<UITextFieldDelegate>
{
    UITextField *textTF;
}

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation AddResourceFolderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"创建文件夹";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self createUI];
    [self createSubmitBtn];
}

#pragma mark - 创建UI
- (void)createUI {
    
    textTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, k_ScreenWidth - 40, 50)];
    textTF.placeholder = @"请输入新创建文件夹名称";
    textTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textTF.layer.borderWidth = .5;
    textTF.layer.cornerRadius = 5;
    textTF.delegate = self;
    [self.view addSubview:textTF];
}

- (void)createSubmitBtn {
    //添加提交按钮
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(CGRectGetMinX(textTF.frame), CGRectGetMaxY(textTF.frame) + 30, k_ScreenWidth - 40, 30);
    submitButton.backgroundColor = [UIColor blueColor];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}

- (void)submitClick{
    
    NSLog(@"提交");
    if (textTF.text == nil) {
        NSLog(@"你还没有输入文件夹名称哟...");
        return;
    }
    if (self.block) {
        self.block(textTF.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
