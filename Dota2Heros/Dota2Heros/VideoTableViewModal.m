//
//  VideoTableViewModal.m
//  Dota2Heros
//
//  Created by HFY on 16/2/18.
//  Copyright © 2016年 LHP. All rights reserved.
//

#import "VideoTableViewModal.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <UIImageView+WebCache.h>

@implementation VideoTableViewModal
{
    NSString *docPath;
}


- (instancetype)initData
{
    if (self = [super init]) {
        docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        if (![[NSFileManager defaultManager]fileExistsAtPath:[docPath stringByAppendingPathComponent:@"cellImageArray.plist"]]
            &&
            ![[NSFileManager defaultManager]fileExistsAtPath:[docPath stringByAppendingPathComponent:@"videoUserName.plist"]]){
            NSLog(@"获取数据");
            [self getVideoCellData];

        }
        
        NSLog(@"1docPath %@",docPath);

    }
    return self;
}

- (void)getVideoCellData
{
    for (NSString *url in self.Url) {
        NSString *videoDataUrl = [NSString stringWithFormat:@"http://play.youku.com/play/get.json?vid=%@==&ct=10",[self getYoukuVideoIdByUrl:url]];
        NSLog(@"%@",videoDataUrl);
        [self fetchvideoDataUrl:videoDataUrl];
    }
//    NSLog(@"cellTitleArray %@",self.cellTitleArray);

}

- (void)fetchvideoDataUrl:(NSString *)videoDataUrl
{
    NSURL *apiURL = [NSURL URLWithString:videoDataUrl];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:apiURL
                                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                     
                                                     NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                     

                                                     NSString *cellImageUrl = json[@"data"][@"video"][@"logo"];
                                                     [self.cellIamgeUrlArray addObject: cellImageUrl];
                                                     
                                                     NSString *cellTitle = json[@"data"][@"video"][@"title"];
                                                     [self.cellTitleArray addObject:cellTitle];
                                                     
                                                     NSString *userName = json[@"data"][@"video"][@"username"];
                                                     [self.videoUserArray addObject:userName];
                                                     
                                                     if ([self.cellTitleArray count] == 13 ) {
                                                         if (![[NSFileManager defaultManager]fileExistsAtPath:[docPath stringByAppendingPathComponent:@"cellTitleArray.plist"]]) {
                                                             
                                                         
                                                            [self.cellTitleArray writeToFile:[docPath stringByAppendingPathComponent:@"cellTitleArray.plist"] atomically:YES];
                                                             
                                                         }
                                                         
                                                         if (![[NSFileManager defaultManager]fileExistsAtPath:[docPath stringByAppendingPathComponent:@"cellImageArray.plist"]]) {
                                                             
                                                              [self.cellIamgeUrlArray writeToFile:[docPath stringByAppendingPathComponent:@"cellImageArray.plist"] atomically:YES];
                                                             
                                                         }
                                                         
                                                         if (![[NSFileManager defaultManager]fileExistsAtPath:[docPath stringByAppendingPathComponent:@"videoUserName.plist"]]) {
                                                             
                                                             [self.videoUserArray writeToFile:[docPath stringByAppendingPathComponent:@"videoUserName.plist"] atomically:YES];
                                                             
                                                         }


                                                         
                                                        

                                                     }
                                                     

                                                 }];
    
    
    [dataTask resume];
}

-(NSString *)getYoukuVideoIdByUrl:(NSString *)videourl
{
    if (videourl != nil && ![videourl isEqualToString:@""]) {
        NSString *youkuId;
        NSArray *firSep = [videourl componentsSeparatedByString:@"id_"];
        if ([firSep count] > 0 && firSep != nil)
        {
            NSArray *secSep = [[firSep lastObject] componentsSeparatedByString:@"."];
            if ([secSep count] >0 && secSep != nil)
            {
                youkuId = [secSep firstObject];
            }
        }
        return youkuId;
        
    } else {
        return @"";
    }
}

- (NSArray *)Url
{
    if (!_Url) {
        _Url = @[@"http://v.youku.com/v_show/id_XODMxMTMyNTcy.html",
                 
                 @"http://v.youku.com/v_show/id_XODE5NDc2Nzcy.html",
                 
                 @"http://v.youku.com/v_show/id_XNzc3MzcwOTI4.html",
                 
                 @"http://v.youku.com/v_show/id_XNzYyNzE3NzUy.html",
                 
                 @"http://v.youku.com/v_show/id_XMTQ3NDY5MzEzNg==.html",
                 
                 @"http://v.youku.com/v_show/id_XMTQ3NDY5MDIwNA==.html",
                 
                 @"http://v.youku.com/v_show/id_XMTQ3NDY4NzY1Ng==.html",
                 
                 @"http://v.youku.com/v_show/id_XMTQ3NDY4NDIwMA==.html",
                 
                 @"http://v.youku.com/v_show/id_XNzIwMDIyNzMy.html",
                 
                 @"http://v.youku.com/v_show/id_XMTQ1MzAzNTgzMg==.html",
                 
                 @"http://v.youku.com/v_show/id_XMTQyMzA2NzI0NA==.html",
                 
                 @"http://v.youku.com/v_show/id_XMTQ0ODQ3MTMxNg==.html",
                 
                 @"http://v.youku.com/v_show/id_XMTM2NTE1ODYyNA==.html"];
    }
    return _Url;
}

- (NSArray *)realUrl
{
    if (!_realUrl) {
        _realUrl = @[
                @"http://pl.youku.com/playlist/m3u8?ts=1457321255&keyframe=0&vid=XODMxMTMyNTcy&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffdiAPT+Ajf2/qYIyw7hfSjITjgKzsLu076QkQCDwPh82kkmIk0mhcVYty9AXFuJs+7A7Uq5HLggZHCAr2E54wtI=&ypremium=1&oip=1931268481&token=2339&sid=8457321255534204feb7d&did=1457321255&ev=1&ctype=20&ep=FfZvanLE0s%2FXSL60smGU35Hwsqy554QGy4hC4UjUXuN7ITnecCCdTZzXhsA48Yla",
                     
                @"http://pl.youku.com/playlist/m3u8?ts=1457321278&keyframe=0&vid=XODE5NDc2Nzcy&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffcODsJ2hizRTF3lt6ItLaR8TjgKzsLu076QkQCDwPh82feIlqwQrafZTApfIs8PvArA7Uq5HLggZHCAr2E54wtI=&ypremium=1&oip=1931268481&token=3908&sid=845732127875620aacfc3&did=1457321278&ev=1&ctype=20&ep=utts1grNBg%2B1U12X7EBeW7tdmMmEwWj%2B1TFht%2FlELcrDFX2XZUlYOLlnTgqfkIw4",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1457321301&keyframe=0&vid=XNzc3MzcwOTI4&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffeyU7bZHCW4PGOI7885o54wTjgKzsLu076QkQCDwPh82F5pUQ6ZCthzpNYrKJypgSrA7Uq5HLggZHCAr2E54wtI=&ypremium=1&oip=1931268481&token=4799&sid=445732130132420a847a5&did=1457321301&ev=1&ctype=20&ep=6YpHMOL%2F%2FeHWi1T9O0Lvq5Q7%2FbNi6iSoYofOrWyPmrbo47Mc7DwDpqtp%2BiLCGZ%2Bv",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1457321320&keyframe=0&vid=XNzYyNzE3NzUy&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffTo2q3FEA7+FPl48EDbx6g0TjgKzsLu076QkQCDwPh82MQGG12GVboMjHP50ldXFarA7Uq5HLggZHCAr2E54wtI=&ypremium=1&oip=1931268481&token=6073&sid=1457321320867209ffee0&did=1457321320&ev=1&ctype=20&ep=iU%2Bcy26XeLq15pUvOftY%2F0eF9XJaZsTVi2w9siJoza9p7u6HYkUqMk99Oq28IwZJ",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1457321351&keyframe=0&vid=XMTQ3NDY5MzEzNg==&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0fffeZOK5kbYyPQUnLb+mST0YTjgKzsLu076QkQCDwPh82G9xjBqhLk2vy6HYGjT7GpBGTNFPYolZj4VCaUuyg7RA=&ypremium=1&oip=1931268481&token=5174&sid=04573213518732029e05f&did=1457321351&ev=1&ctype=20&ep=CAWLEymL55ASxAz%2FziYZ6m1R2p1aWwLeMz7h4KaA9EQOeB8ubmHFfKWKv9vZCt%2Bd",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1457321384&keyframe=0&vid=XMTQ3NDY5MDIwNA==&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffS6c9y0HX6dBIX0wffCoNMYTjgKzsLu076QkQCDwPh82Eo6zCGh0aQO7tMwpsqOLJxGTNFPYolZj4VCaUuyg7RA=&ypremium=1&oip=1931268481&token=4972&sid=0457321384949200c837a&did=1457321384&ev=1&ctype=20&ep=e7PkmG0RO23VdbRMrSEr7xlsScvuH8E6FSC0JE3uocp6%2BlT1lzvsOxjnylWOMUQv",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1457048325&keyframe=0&vid=XMTQ3NDY4NzY1Ng==&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffavx8XW7QktqtPB8+OSfeN8TjgKzsLu076QkQCDwPh82M0h+wpstw5h/JUgeygZ6jRGTNFPYolZj4VCaUuyg7RA=&ypremium=1&oip=1931268481&token=1217&sid=7457048325201203091cd&did=1457048325&ev=1&ctype=20&ep=fSIC1%2BaWlYm%2FbyCYWeGqkkRb9U2YG%2FYhvq3VgptxoH6n4GV6VJN7BBL4NP%2FVOROm",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1457048347&keyframe=0&vid=XMTQ3NDY4NDIwMA==&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffYLocqDiwf6cE4fum1jX06sTjgKzsLu076QkQCDwPh82O3p2icyGIAKTjgW+WEalCBGTNFPYolZj4VCaUuyg7RA=&ypremium=1&oip=1931268481&token=4203&sid=445704834725120df5185&did=1457048347&ev=1&ctype=20&ep=Xc8BfHwN3b7GVN3vEa6CSmRGph7b2LSrKRaUXwI0gyBcpczBuLr2PE8shfbhrg98",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1457048367&keyframe=0&vid=XNzIwMDIyNzMy&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffeZnG+w8p0RQHPXM6Pc/LxITjgKzsLu076QkQCDwPh82S7sh1rBCfTBjDbnUm79eebA7Uq5HLggZHCAr2E54wtI=&ypremium=1&oip=1931268481&token=2728&sid=2457048367227200f62fe&did=1457048367&ev=1&ctype=20&ep=NSK33c4o9ERZ0nVeek2nmYWP8XW%2BPtRuSHnn9zr3TlwO4%2BCEwPmSwPjIlsfQZbf5",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1457321511&keyframe=0&vid=XMTQ1MzAzNTgzMg==&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffQ6oM8FyafgHedSr/BYeckATjgKzsLu076QkQCDwPh82eblIrxOlaZn4fD9CWRa2LxGTNFPYolZj4VCaUuyg7RA=&ypremium=1&oip=1931268481&token=2365&sid=24573215111952009e493&did=1457321511&ev=1&ctype=20&ep=zmSuYZYf%2FAJLwK7kpUb%2BFOmrqJh%2BO5PecE0Zpj35rvtrunh3hqeGfWFc8D764Lfw",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1457321475&keyframe=0&vid=XMTQyMzA2NzI0NA==&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffYxLsPNWJuvfaVXnOFCdwWQTjgKzsLu076QkQCDwPh82N/NSSV+uBtF5cxCHE3WycRGTNFPYolZj4VCaUuyg7RA=&ypremium=1&oip=1931268481&token=6478&sid=145732147560820649e05&did=1457321475&ev=1&ctype=20&ep=P0QKdwNI%2Bd88UX1hrj9eXoC9it39O2j6QgvZx4Q4PUwK3J%2BmJ27LoR7j9iSyVXmE",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1457321449&keyframe=0&vid=XMTQ0ODQ3MTMxNg==&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0fffdOqB5v6nqWMRaepeDqX7oTjgKzsLu076QkQCDwPh82+oh0PrCy2Epjnao5bYkkWhGTNFPYolZj4VCaUuyg7RA=&ypremium=1&oip=1931268481&token=5570&sid=445732144957320a0d2ea&did=1457321449&ev=1&ctype=20&ep=Ets%2BbGWFAOK2N0McLlcG1PF9LHfKQuCLnyiM4ocoOJOc%2FnVOyRHg%2BNDzzZvOLydi",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1457321420&keyframe=0&vid=XMTM2NTE1ODYyNA==&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffZsIalC57LgcVSDrj4FNzpYTjgKzsLu076QkQCDwPh82/bZ/IMlMlRwMBd2j+LbKkxGTNFPYolZj4VCaUuyg7RA=&ypremium=1&oip=1931268481&token=7925&sid=045732142073320d982cd&did=1457321420&ev=1&ctype=20&ep=ZABZh4uHNUgfyfLKHhMRjvOQDNCzl5IrzKXf5qyMvWm3KLHoRnByIHD0RYRHRCg%2B"];
        
    }
    return _realUrl;
}

- (NSMutableArray *)cellTitleArray
{
    if (!_cellTitleArray) {
        _cellTitleArray = [[NSMutableArray alloc]init];
    }
    return _cellTitleArray;
}

- (NSMutableArray *)cellIamgeUrlArray
{
    if (!_cellIamgeUrlArray) {
        _cellIamgeUrlArray = [[NSMutableArray alloc]init];
    }
    return _cellIamgeUrlArray;
}

- (NSMutableArray *)videoUserArray
{
    if (!_videoUserArray) {
        _videoUserArray = [[NSMutableArray alloc]init];
    }
    return _videoUserArray;

}

@end
