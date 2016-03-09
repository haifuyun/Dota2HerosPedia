//
//  FullChildViewController.m
//  YZDisplayViewControllerDemo
//
//  Created by yz on 15/12/5.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "FullChildViewController.h"
#import "ItemsSliderBarCell.h"
#import "YZDisplayViewHeader.h"
#import <UIImageView+WebCache.h>
#import "YZXiMaViewController.h"
#import "itemDetailViewController.h"
@interface FullChildViewController ()

@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) NSDictionary *item;
@property (strong, nonatomic) itemDetailViewController *itemDVC;
@property (nonatomic, strong) NSArray *itemsWeaponName;

@end

@implementation FullChildViewController
{
    NSString *docPath;
    
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1];
//    self.view.backgroundColor = [UIColor colorWithRed:93.0/255.0 green:71.0/255.0 blue:139.0/255.0 alpha:1.0];
    
    // 设置额外滚动区域,如果当前是全屏
    // 如果有导航控制器，顶部需要添加额外滚动区域
    // 添加额外滚动区域   导航条高度 + 标题高度
    if (self.navigationController) {
        // 导航条上面高度
        CGFloat navBarH = 64;

        // 查看自己标题滚动视图设置的高度，我这里设置为44
        CGFloat titleScrollViewH = 44;
        [self initDataSource];
        self.tableView.contentInset = UIEdgeInsetsMake(navBarH + titleScrollViewH, 0, 0, 0);
       
    }
//    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//    button.imageView.image = [UIImage imageNamed:@"11.png"];
//    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:button];
//    self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"11.png"];
    // 如果有tabBarController，底部需要添加额外滚动区域
//    self.tableView.contentInset = UIEdgeInsetsMake(64 + 44, 0, 49, 0);
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:self.view.backgroundColor,NSForegroundColorAttributeName, nil];

}

- (void) initDataSource
{
    docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    _item = [NSDictionary dictionaryWithContentsOfFile:[docPath stringByAppendingPathComponent:@"itemNameListdata.plist"]];
    _dataSource = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"weaponClassification" ofType:@"plist"]];
    _itemsWeaponName =  [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"itemsWeaponName" ofType:@"plist"]];

}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger number = 0;
    NSInteger tagNumber =  [_itemsWeaponName indexOfObject:self.title];
    
    number = [_dataSource[tagNumber] count];

    return number;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *itemDeatil = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.itemDVC = [itemDeatil instantiateViewControllerWithIdentifier:@"itemDetailView"];
    self.itemDVC.backgroundColor = self.view.backgroundColor;
    NSInteger tagNumber =  [_itemsWeaponName indexOfObject:self.title];
    
    self.itemDVC.selectName = [[NSString stringWithFormat:@"%@",self.item[_dataSource[tagNumber][self.tableView.indexPathForSelectedRow.row]][@"name"]]stringByReplacingOccurrencesOfString:@"item_" withString:@""];

    [self.navigationController pushViewController:self.itemDVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL xibsRegistered = NO;
    if (!xibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"ItemsSliderBarCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"ItemsSliderBarCell"];
        xibsRegistered = YES;
    }
    static NSString *ID = @"ItemsSliderBarCell";
    ItemsSliderBarCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
   
    
    NSInteger tagNumber =  [_itemsWeaponName indexOfObject:self.title];

    
    NSString *resourceName = self.item[_dataSource[tagNumber][indexPath.row]][@"name"];
    NSString *realName = [resourceName stringByReplacingOccurrencesOfString:@"item_" withString:@""];
    NSString *urlString = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/items/%@_lg.png",realName];
    NSURL *imageURL = [NSURL URLWithString:urlString];
    
    
    [cell.itemImageView sd_setImageWithURL:imageURL];
    cell.itemNameLabel.text = _dataSource[tagNumber][indexPath.row];
    cell.costNumberLabel.text = [NSString stringWithFormat:@"%@",self.item[_dataSource[tagNumber][indexPath.row]][@"cost"]];
    cell.costImageView.image = [UIImage imageNamed:@"gold.png"];
    
    return cell;
}


@end
