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
    
    // 段子
    FullChildViewController *ConsumablesVc = [[FullChildViewController alloc] init];
    ConsumablesVc.title = @"Consumables";
    [self addChildViewController:ConsumablesVc];
    
    // 段子
    FullChildViewController *AttributesVc = [[FullChildViewController alloc] init];
    AttributesVc.title = @"Attributes";
    [self addChildViewController:AttributesVc];
    
    // 段子
    FullChildViewController *ArmamentsVc = [[FullChildViewController alloc] init];
    ArmamentsVc.title = @"Armaments";
    [self addChildViewController:ArmamentsVc];
    
    FullChildViewController *ArcaneVc = [[FullChildViewController alloc] init];
    ArcaneVc.title = @"Arcane";
    [self addChildViewController:ArcaneVc];
    
    // 全部
    FullChildViewController *CommonVc = [[FullChildViewController alloc] init];
    CommonVc.title = @"Common";
    [self addChildViewController:CommonVc];
    
    // 视频
    FullChildViewController *SupportVc = [[FullChildViewController alloc] init];
    SupportVc.title = @"Support";
    [self addChildViewController:SupportVc];
    
    // 声音
    FullChildViewController *CasterVc = [[FullChildViewController alloc] init];
    CasterVc.title = @"Caster";
    [self addChildViewController:CasterVc];
    
    // 图片
    FullChildViewController *WeaponsVc = [[FullChildViewController alloc] init];
    WeaponsVc.title = @"Weapons";
    [self addChildViewController:WeaponsVc];
    
    // 段子
    FullChildViewController *ArmorVc = [[FullChildViewController alloc] init];
    ArmorVc.title = @"Armor";
    [self addChildViewController:ArmorVc];
    
    
    FullChildViewController *ArtifactsVc = [[FullChildViewController alloc] init];
    ArtifactsVc.title = @"Artifacts";
    [self addChildViewController:ArtifactsVc];
    
    
    FullChildViewController *SecretVc = [[FullChildViewController alloc] init];
    SecretVc.title = @"Secret";
    [self addChildViewController:SecretVc];
    
}


@end
