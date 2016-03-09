//
//  YZXiMaViewController.m
//  YZDisplayViewControllerDemo
//
//  Created by yz on 15/12/5.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "YZXiMaViewController.h"


#import "FullChildViewController.h"

@implementation YZXiMaViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Items";
    
    // 添加所有子控制器
    [self setUpAllViewController];

  
 
    
    // 设置标题字体
    /*
        方式一：
     self.titleFont = [UIFont systemFontOfSize:20];
     */
    // 推荐方式
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor,
                             UIColor *__autoreleasing *norColor,
                             UIColor *__autoreleasing *selColor,
                             UIFont *__autoreleasing *titleFont,
                             CGFloat *titleHeight) {
        
            // 设置标题字体
            *titleFont = [UIFont systemFontOfSize:20];
        
    }];
    
    // 设置下标
    /*
        方式一
     // 是否显示标签
     self.isShowUnderLine = YES;
     
     // 标题填充模式
     self.underLineColor = [UIColor redColor];
     
     // 是否需要延迟滚动,下标不会随着拖动而改变
     self.isDelayScroll = YES;
     */

    // 推荐方式（设置下标）
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
        
        // 是否显示标签
        *isShowUnderLine = YES;
        
        // 标题填充模式
        *underLineColor = [UIColor redColor];
        
        // 是否需要延迟滚动,下标不会随着拖动而改变
//        *isDelayScroll = YES;
        
    }];
    
    // 设置全屏显示
    // 如果有导航控制器或者tabBarController,需要设置tableView额外滚动区域,详情请看FullChildViewController
    self.isfullScreen = YES;
}

// 添加所有子控制器
- (void)setUpAllViewController
{
    NSArray *items = @[@"Consumables",@"Attributes",@"Armaments",@"Arcane",@"Common",@"Support",@"Caster",@"Weapons",@"Armor",@"Artifacts",@"Secret"];
    
    for (int i = 0; i < items.count; i++) {
        
        FullChildViewController *a = [[FullChildViewController alloc]init];
        a.title = [NSString stringWithFormat:@"%@",items[i]];
        [self addChildViewController:a];
    }
 
    
}


@end
