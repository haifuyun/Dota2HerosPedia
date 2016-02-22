//
//  NewDetailTableViewController.h
//  Dota2Heros
//
//  Created by HFY on 16/1/12.
//  Copyright © 2016年 LHP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "heroVideoWebViewController.h"
@interface DetailTableViewController : UITableViewController

@property NSString *heroDetailImageName;

@property heroVideoWebViewController *hvwVC;

@end
