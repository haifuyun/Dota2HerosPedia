//
//  itemDetailViewController.h
//  Dota2Heros
//
//  Created by HFY on 16/1/24.
//  Copyright © 2016年 LHP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface itemDetailViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemCostNumberLabel;
@property (weak, nonatomic) IBOutlet UITextView *itemDescTextView;
@property (weak, nonatomic) IBOutlet UITextView *attribTextView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIImageView *cooldownImageView;
@property (weak, nonatomic) IBOutlet UIImageView *manaImageView;
@property (weak, nonatomic) IBOutlet UILabel *manaTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *cooldownTextLabel;
@property UIColor *backgroundColor;
@property NSString *selectName;
@end
