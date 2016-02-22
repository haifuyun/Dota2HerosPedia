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
                @"http://pl.youku.com/playlist/m3u8?ts=1456117946&keyframe=0&vid=XODMxMTMyNTcy&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffY9us7RWxki3U06jlrjG3pITjgKzsLu076QkQCDwPh82kkmIk0mhcVYty9AXFuJs+7A7Uq5HLggZHCAr2E54wtI=&ypremium=1&oip=1931268481&token=5513&sid=545611794621520a607f9&did=1456117946&ev=1&ctype=20&ep=ZrrUyTz%2BrP9symmfLbpRK95TiJCmhNsoQmwmRMu0Pt3nqM07enNr0opQfpgsBB7s",
                     
                @"http://pl.youku.com/playlist/m3u8?ts=1456117969&keyframe=0&vid=XODE5NDc2Nzcy&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffYIUnuSlsRudZg4UpMgJxvETjgKzsLu076QkQCDwPh82feIlqwQrafZTApfIs8PvArA7Uq5HLggZHCAr2E54wtI=&ypremium=1&oip=1931268481&token=3338&sid=445611796921520b84a62&did=1456117969&ev=1&ctype=20&ep=VAm2trk18wcWBO47gF7gyArowsm19NyImgehC8%2B8a4QwdLcM4B3%2BnL6sCscMSoOi",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1456117996&keyframe=0&vid=XNzc3MzcwOTI4&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffdVGiSGMj4Sgn3C99HQdEuwTjgKzsLu076QkQCDwPh82F5pUQ6ZCthzpNYrKJypgSrA7Uq5HLggZHCAr2E54wtI=&ypremium=1&oip=1931268481&token=3510&sid=8456117996515207fc131&did=1456117996&ev=1&ctype=20&ep=FCwityZ7jPkTTzHnLnOGeCXdfnuYubXjHO2MIlMSo2HAFeV5d7dgVlRfzt2XfUbe",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1456118021&keyframe=0&vid=XNzYyNzE3NzUy&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffTTwe07DrrDtel6XblInCiMTjgKzsLu076QkQCDwPh82MQGG12GVboMjHP50ldXFarA7Uq5HLggZHCAr2E54wtI=&ypremium=1&oip=1931268481&token=9264&sid=84561180219242083ac0c&did=1456118021&ev=1&ctype=20&ep=1C%2Fg4oaLvQoh78lUpwnqsLUryVZ3ZlIeVRgY44F6lX5xMJQONvADxamW08IMkaa1",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1455964878&keyframe=0&vid=XMTQ3NDY5MzEzNg==&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffX/MFbZYDSq/oIQvava7hnkTjgKzsLu076QkQCDwPh82G9xjBqhLk2vy6HYGjT7GpBGTNFPYolZj4VCaUuyg7RA=&ypremium=1&oip=1931268481&token=2188&sid=3455964878909204adaa3&did=1455964878&ev=1&ctype=20&ep=86kPkZwXW4EURZntdwuie4wEfOlox7xL5kN2pnwNCE%2BYfzQLRdjmJuRL2F5lwANc",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1455964898&keyframe=0&vid=XMTQ3NDY5MDIwNA==&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffQm361bxgu+xlyv/efw5NcgTjgKzsLu076QkQCDwPh82Eo6zCGh0aQO7tMwpsqOLJxGTNFPYolZj4VCaUuyg7RA=&ypremium=1&oip=1931268481&token=7439&sid=545596489828320065f54&did=1455964898&ev=1&ctype=20&ep=W9DVQCJLaO3NCX1lfdijv4z0cvDi84%2FtjE0E%2FMlHHe93C4yZkB5aIFYU7zzLsQ%2Fu",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1455964937&keyframe=0&vid=XMTQ3NDY4NzY1Ng==&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffduxy5ZXvvRnwmDxWqjhPWoTjgKzsLu076QkQCDwPh82M0h+wpstw5h/JUgeygZ6jRGTNFPYolZj4VCaUuyg7RA=&ypremium=1&oip=1931268481&token=5519&sid=6455964937904208e336b&did=1455964937&ev=1&ctype=20&ep=DZk2FLiWsRlCLK8R%2Bgck%2BZ9bhGZkeEjOcHY2gJTCCedwK6ECU0oLCiBN%2FcWJ7jD%2F",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1455964959&keyframe=0&vid=XMTQ3NDY4NDIwMA==&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0fffuslb9bynI3+qRR2Hdm4xITjgKzsLu076QkQCDwPh82O3p2icyGIAKTjgW+WEalCBGTNFPYolZj4VCaUuyg7RA=&ypremium=1&oip=1931268481&token=2149&sid=145596495957020891ec3&did=1455964959&ev=1&ctype=20&ep=UhwyJRlqjhhvpBzFQHJB5nMj5cJAevC6fofOppnaoeOAn8D4z4s0p0XCMNe%2Berpt",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1455964983&keyframe=0&vid=XNzIwMDIyNzMy&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffRML2D8EarljWP1L9V4ZDSMTjgKzsLu076QkQCDwPh82S7sh1rBCfTBjDbnUm79eebA7Uq5HLggZHCAr2E54wtI=&ypremium=1&oip=1931268481&token=5667&sid=8455964983955201af419&did=1455964983&ev=1&ctype=20&ep=pSz9dfi5UptcV3Z5H30DnNMVkEG2SIW25EBt5v4Z1IirPbGHgdNXisOKSTNPNFnl",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1455965005&keyframe=0&vid=XMTQ1MzAzNTgzMg==&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffbP46nfDrcyoyhQVgZxL9gsTjgKzsLu076QkQCDwPh82eblIrxOlaZn4fD9CWRa2LxGTNFPYolZj4VCaUuyg7RA=&ypremium=1&oip=1931268481&token=7700&sid=7455965005787202f26ba&did=1455965005&ev=1&ctype=20&ep=0yPyF131x%2BI8C2BPn2XnLbLy3jbtjwFEWZHrbdDAlr24dpEGjB26DjffLOS9kQbm",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1455964840&keyframe=0&vid=XMTQyMzA2NzI0NA==&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffWjR+XLK5j7shJWmUkh8RWgTjgKzsLu076QkQCDwPh82N/NSSV+uBtF5cxCHE3WycRGTNFPYolZj4VCaUuyg7RA=&ypremium=1&oip=1931268481&token=7377&sid=245596484086420b2d937&did=1455964840&ev=1&ctype=20&ep=g6dbOEaQZUkUzzb%2BytZRMGxjxPeZl0m7lHEoHgu1v08UytT3qgavXm25aa0blwP6",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1455964821&keyframe=0&vid=XMTQ0ODQ3MTMxNg==&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffffc51BhpDcyr7uS7Wq0bQMTjgKzsLu076QkQCDwPh82+oh0PrCy2Epjnao5bYkkWhGTNFPYolZj4VCaUuyg7RA=&ypremium=1&oip=1931268481&token=5698&sid=745596482106420cc4a4b&did=1455964821&ev=1&ctype=20&ep=qGx%2BSA%2FcmoftpHRTCyvPrKySRrKJeN7jDdH3WV%2Bul34eZnvt4VovlHvuKVnyPJcj",
                
                @"http://pl.youku.com/playlist/m3u8?ts=1455964798&keyframe=0&vid=XMTM2NTE1ODYyNA==&type=mp4&r=/3sLngL0Q6CXymAIiF9JUQQtnOFNJPUClO8A56KJJcT8UB+NRAMQ09zE6rNj4EKMxAvRByWf6hitgv75Fv0ffcDQqdKHXIO7dy3uhfLFWvsTjgKzsLu076QkQCDwPh82/bZ/IMlMlRwMBd2j+LbKkxGTNFPYolZj4VCaUuyg7RA=&ypremium=1&oip=1931268481&token=6526&sid=0455964798715201ac81f&did=1455964798&ev=1&ctype=20&ep=EnsdipQG6aH4X%2Fs9gXgJl0gVUqkwTBiVfVK3wU9USzuoaNBD%2FyuPi7ykcBPj%2FXQC",];
        
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
