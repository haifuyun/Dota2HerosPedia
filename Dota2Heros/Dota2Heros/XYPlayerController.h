//
//  XYPlayerController.h
//  XYPlayer
//
//  Created by Echo on 15/11/23.
//  Copyright © 2015年 Liu Xuanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MediaPlayer;

@interface XYPlayerController : MPMoviePlayerController 

@property (strong, nonatomic) NSString *TVId;
@property (strong, nonatomic) NSString *Access_Token;
@property (strong, nonatomic) UIImage *Cover_Image;//封面图片
@property (strong, nonatomic) NSString *Title;//标题
@property (strong, nonatomic) NSString *Detail;//详细信息

-(void)settingTVId:(NSString *)tvid Title:(NSString *)title Detail:(NSString *)detail access_token:(NSString *)access_token coverImage:(UIImage *)cover_image;
@property (nonatomic, copy)void(^dimissCompleteBlock)(void);
@property (nonatomic, assign) CGRect frame;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)showInWindow;
- (void)dismiss;
- (void)cancelObserver;

@end
