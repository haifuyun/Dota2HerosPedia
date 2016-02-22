//
//  heroVideoWebViewController.m
//  Dota2Heros
//
//  Created by HFY on 16/1/13.
//  Copyright © 2016年 LHP. All rights reserved.
//

#import "heroVideoWebViewController.h"

@interface heroVideoWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation heroVideoWebViewController
{
    NSString *docPath;
}

 - (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchHeroAbilityVideo];
}

 - (void)fetchHeroAbilityVideo
{
    NSDictionary *allAbility = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"VideoAbilityName" ofType:@"plist"]];
    
    NSURL *videoURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",allAbility[self.hero]]];
//    NSLog(@"%@",allAbility[self.hero]);
    NSURLRequest *req = [NSURLRequest requestWithURL:videoURL];
    [self.webView loadRequest:req];
}


 - (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

