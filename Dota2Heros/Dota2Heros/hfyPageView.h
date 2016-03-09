//
//  hfyPageView.h
//  Dota2Heros
//
//  Created by HFY on 16/3/9.
//  Copyright © 2016年 LHP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hfyPageView : UIView
+ (instancetype)pageView;
@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, strong) UIColor *otherColor;
@property (nonatomic, strong) NSArray *iamgeUrl;

@end
