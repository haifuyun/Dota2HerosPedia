//
//  VideoTableViewModal.h
//  Dota2Heros
//
//  Created by HFY on 16/2/18.
//  Copyright © 2016年 LHP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoTableViewModal : NSObject

@property (nonatomic,strong) NSArray *realUrl;
@property (nonatomic,strong) NSArray *Url;
@property (nonatomic,strong) NSMutableArray *cellIamgeUrlArray;
@property (nonatomic,strong) NSMutableArray *cellTitleArray;
@property (nonatomic,strong) NSMutableArray *videoUserArray;

- (instancetype)initData;

@end
