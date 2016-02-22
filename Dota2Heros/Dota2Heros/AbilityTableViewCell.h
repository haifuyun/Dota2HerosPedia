//
//  AbilityTableViewCell.h
//  Dota2Heros
//
//  Created by HFY on 16/1/12.
//  Copyright © 2016年 LHP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbilityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *abilityImageView;
@property (weak, nonatomic) IBOutlet UILabel *abilityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilityDetailLabel;


@end
