//
//  videoTableViewCell.h
//  Dota2Heros
//
//  Created by HFY on 16/2/15.
//  Copyright © 2016年 LHP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface videoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;

@property (weak, nonatomic) IBOutlet UIButton *videoCellButton;
@end
