//
//  ViewController.m
//  ResourceSelectDemo
//
//  Created by 思 彭 on 16/9/18.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "ViewController.h"
#import "ResourceViewController.h"

#define k_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define k_ScreenHeight [UIScreen mainScreen].bounds.size.height
//蓝
#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/)\
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

#define F_BLUE RGBA(57, 116, 191, 1)

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Init

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.menuBGColor = [UIColor whiteColor];
//        self.menuViewStyle = WMMenuViewStyleLine;
//        self.menuItemWidth = k_ScreenWidth / 2;
//        self.progressColor = F_BLUE;
//        self.titleColorNormal = F_BLUE;
//        self.titleColorSelected = F_BLUE;
//        self.titleSizeNormal = 20;
//        self.menuHeight = 50;
//    }
//    return self;
//}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资料";
    self.navigationController.navigationBar.barTintColor = F_BLUE;
    self.menuBGColor = [UIColor whiteColor];
    self.menuViewStyle = WMMenuViewStyleLine;
    self.menuItemWidth = k_ScreenWidth / 2;
    self.progressColor = [UIColor blueColor];
    self.titleColorNormal = F_BLUE;
    self.titleColorSelected = F_BLUE;
    self.titleSizeNormal = 20;
    self.menuHeight = 50;
}

#pragma mark - 懒加载

- (NSArray *)titles{
    
    return @[@"全部资料",@"我的资料"];
}

#pragma mark - WMPageControllerDataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return self.titles.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    switch (index) {
        case 0: {
            ResourceViewController *allVC = [[ResourceViewController alloc] init];
            return allVC;
        }
            break;
        default: {
            ResourceViewController *mineVC = [[ResourceViewController alloc] init];
            return mineVC;
        }
            break;
    }
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {

    return self.titles[index];
}

//- (void)pageController:(WMPageController *)pageController lazyLoadViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
//    NSLog(@"%@", info);
//}

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
}



@end
