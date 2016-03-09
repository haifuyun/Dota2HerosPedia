//
//  hfyPageView.m
//  Dota2Heros
//
//  Created by HFY on 16/3/9.
//  Copyright © 2016年 LHP. All rights reserved.
//

#import "hfyPageView.h"
#import <UIImageView+WebCache.h>
@interface hfyPageView() <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation hfyPageView

+ (instancetype)pageView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

 - (void)setIamgeUrl:(NSArray *)iamgeUrl
{
    _iamgeUrl = iamgeUrl;
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0; i < iamgeUrl.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView sd_setImageWithURL:_iamgeUrl[i]];
        [self.scrollView addSubview:imageView];
    }
    
    self.pageControl.numberOfPages = iamgeUrl.count;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    
    CGFloat scrollW = self.scrollView.frame.size.width;
    CGFloat scrollH = self.scrollView.frame.size.height;
    
    self.scrollView.contentSize = CGSizeMake(self.iamgeUrl.count * scrollW, 0);
    
    for (int i = 0; i <self.scrollView.subviews.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        imageView.frame = CGRectMake(i *scrollW, 0, scrollW, scrollH);
    }
}

- (void)setCurrentColor:(UIColor *)currentColor
{
    _currentColor = currentColor;
    
    self.pageControl.currentPageIndicatorTintColor = currentColor;
    
}

 - (void)setOtherColor:(UIColor *)otherColor
{
    _otherColor = otherColor;
    
    self.pageControl.pageIndicatorTintColor = otherColor;
    
}

#pragma mark - <UIScrollViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
}

@end
