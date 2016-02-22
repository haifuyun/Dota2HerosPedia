//
//  VideoTableViewController.m
//  Dota2Heros
//
//  Created by HFY on 16/1/18.
//  Copyright © 2016年 LHP. All rights reserved.
//

#import "VideoTableViewController.h"
#import "videoTableViewCell.h"
#import "videoPlayViewController.h"
#import "VideoTableViewModal.h"
//#import <AVFoundation/AVFoundation.h>
//#import <CoreMedia/CoreMedia.h>
#import <UIImageView+WebCache.h>

@interface VideoTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (nonatomic,strong) NSArray *imageData;
@property (nonatomic,strong) NSArray *titleData;
@property (nonatomic,strong) NSArray *videoUserName;


@property (nonatomic,strong)VideoTableViewModal *cellModal;

@property NSURLSession *session;

@end

@implementation VideoTableViewController
{
    NSString *docPath;
}


 - (void)viewDidLoad
{
    [super viewDidLoad];
    [self getData];
    [self configNavigationBar];
    [self configTableView];
}

 - (void)configTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor colorWithRed:93.0/255.0 green:71.0/255.0 blue:139.0/255.0 alpha:1.0];
}

 - (void)configNavigationBar
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:93.0/255.0 green:71.0/255.0 blue:139.0/255.0 alpha:1.0]];
    self.title = @"Video";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    self.navigationController.navigationBar.translucent = NO;

}

 - (void)getData
{
    docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    self.cellModal = [[VideoTableViewModal alloc]initData];
    
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:[docPath stringByAppendingPathComponent:@"cellTitleArray.plist"]]) {
        
        self.titleData = [NSArray arrayWithContentsOfFile:[docPath stringByAppendingPathComponent:@"cellTitleArray.plist"]];
        
    }
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:[docPath stringByAppendingPathComponent:@"cellImageArray.plist"]]) {
        
        self.imageData = [NSArray arrayWithContentsOfFile:[docPath stringByAppendingPathComponent:@"cellImageArray.plist"]];
        
    }
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:[docPath stringByAppendingPathComponent:@"videoUserName.plist"]]) {
        
        self.videoUserName = [NSArray arrayWithContentsOfFile:[docPath stringByAppendingPathComponent:@"videoUserName.plist"]];
        
    }

}

 - (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

//    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

 - (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];

}

 - (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.cellModal.Url.count;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    videoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell" forIndexPath:indexPath];

    cell.cellTitle.text = self.titleData[indexPath.row];
    [cell.videoImage sd_setImageWithURL:self.imageData[indexPath.row]];

    return cell;
    
}


 - (IBAction)videoCellClick:(id)sender
{
    UITableViewCell *cell = (UITableViewCell *)[[sender superview]superview];
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    videoPlayViewController *playView = [[videoPlayViewController alloc]init];
    NSLog(@"indexPath %ld",(long)path.row);

        if (path.row <= self.cellModal.realUrl.count) {
            playView.videoUrl = self.self.cellModal.realUrl[path.row];
            NSLog(@"self.cellModal.Url[path.row] %@",self.self.cellModal.Url[path.row]);
            playView.tittle = self.titleData[path.row];
            playView.detail = self.videoUserName[path.row];
        }

    playView.view.backgroundColor = [UIColor blackColor];

    [self.navigationController pushViewController:playView animated:YES];
}




@end
