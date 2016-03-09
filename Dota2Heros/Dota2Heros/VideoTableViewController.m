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
#import "hfyPageView.h"
#import <UIImageView+WebCache.h>

@interface VideoTableViewController ()
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
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor colorWithRed:93.0/255.0 green:71.0/255.0 blue:139.0/255.0 alpha:1.0];

    hfyPageView *pageView = [hfyPageView pageView];
    pageView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, 200);
    pageView.iamgeUrl = self.imageData;
    pageView.otherColor = [UIColor whiteColor];
    pageView.currentColor = [UIColor colorWithRed:93.0/255.0 green:71.0/255.0 blue:139.0/255.0 alpha:1.0];
    [self.tableView setTableHeaderView:pageView];
    
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


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
//    view.tintColor = [UIColor colorWithRed:142.0/255.0 green:139.0/255.0 blue:162.0/255.0 alpha:1.0];
    view.tintColor = [UIColor colorWithRed:68.0/255.0 green:52.0/255.0 blue:105.0/255.0 alpha:1.0];;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    videoPlayViewController *playView = [[videoPlayViewController alloc]init];
    
    if (indexPath.row <= self.cellModal.realUrl.count) {
        playView.videoUrl = self.self.cellModal.realUrl[indexPath.row];
        NSLog(@"self.cellModal.Url[path.row] %@",self.self.cellModal.Url[indexPath.row]);
        playView.tittle = self.titleData[indexPath.row];
        playView.detail = self.videoUserName[indexPath.row];
    }
    
    playView.view.backgroundColor = [UIColor blackColor];
    
    [self.navigationController pushViewController:playView animated:YES];
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
