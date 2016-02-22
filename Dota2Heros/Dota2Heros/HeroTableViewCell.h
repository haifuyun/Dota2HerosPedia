//
//  HeroTableViewCell.h
//  Dota2Heros
//
//  Created by HFY on 16/1/11.
//  Copyright © 2016年 LHP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeroTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end
