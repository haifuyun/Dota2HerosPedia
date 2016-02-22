//
//  itemDetailViewController.m
//  Dota2Heros
//
//  Created by HFY on 16/1/24.
//  Copyright © 2016年 LHP. All rights reserved.
//

#import "itemDetailViewController.h"
#import <UIImageView+WebCache.h>
#import "ItemsDetailCell.h"
@interface itemDetailViewController ()
@property NSDictionary *itemsData;
@end

@implementation itemDetailViewController
{
    int numberOfSection;
    BOOL components;
    BOOL lore;
    BOOL notes;
    BOOL desc;
    BOOL attrib;

}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self configDynamicSection];
    [self configTableView];
    [self initData];
    [self initTopView];



    
    NSLog(@"lore:%@",self.itemsData[self.selectName][@"lore"]);
    NSLog(@"attrib:%@",self.itemsData[self.selectName][@"attrib"]);
    if ([self.itemsData[self.selectName][@"attrib"] isEqualToString:@""]) {
        NSLog(@"对的");
    }
    NSLog(@"notes:%@",self.itemsData[self.selectName][@"notes"]);

    if ([self.itemsData[self.selectName][@"components"] count] == 0) {
        NSLog(@"没有");
    }else{
        NSLog(@"components:%lu",[self.itemsData[self.selectName][@"components"] count]);

        NSLog(@"%@",self.itemsData[self.selectName][@"components"]);
    }

    
}

- (void)configDynamicSection
{
    components = YES;
    lore = YES;
    notes = YES;
    desc = YES;
    attrib = YES;
}

- (void)configTableView
{
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.tableView.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:255.0/255.0 alpha:1.0];
        self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

//    [[UITableViewHeaderFooterView appearance]setTintColor:[UIColor colorWithRed:46.0/255.0 green:46.0/255.0 blue:54.0/255.0 alpha:1.0]];
//    [[UITableViewHeaderFooterView appearance]setTintColor:[UIColor colorWithRed:76.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1.0]];


}

- (void)initData
{
    self.itemsData = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"itemsData" ofType:@"plist"]][@"itemdata"];
}

- (void)initTopView
{
    NSString *urlString = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/items/%@",self.itemsData[self.selectName][@"img"]];
    
    NSURL *imageURL = [NSURL URLWithString:urlString];
    
    [self.imageView sd_setImageWithURL:imageURL];
    self.itemNameLabel.text = self.itemsData[self.selectName][@"dname"];
    self.itemCostNumberLabel.text = [NSString stringWithFormat:@"%@",self.itemsData[self.selectName][@"cost"]];
    
    
    if ([[NSString stringWithFormat:@"%@",self.itemsData[self.selectName][@"mc"]] isEqualToString:@"0"]) {
        self.manaImageView.image = [UIImage imageNamed:@"IconEmpty"];
        self.manaTextLabel.text = @"";
    }else{
        self.manaTextLabel.text = [NSString stringWithFormat:@"%@",self.itemsData[self.selectName][@"mc"]];
    }
    
    if ([[NSString stringWithFormat:@"%@",self.itemsData[self.selectName][@"cd"]] isEqualToString:@"0"]) {
        self.cooldownImageView.image = [UIImage imageNamed:@"IconEmpty"];
        self.cooldownTextLabel.text = @"";
    }else{
        self.cooldownTextLabel.text = [NSString stringWithFormat:@"%@",self.itemsData[self.selectName][@"cd"]];
    }
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName = [[NSString alloc]init];
    

    if (![self.itemsData[self.selectName][@"components"] count] == 0)
    {
        if (section == numberOfSection - 1) {
            sectionName = @"Recipe";
            
        }else{
            sectionName = @" ";
   
        }
    }else {
        sectionName = @" ";

    }
    
    return sectionName;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    float number = 0;
    if (![self.itemsData[self.selectName][@"components"] count] == 0)
    {
        if (section == numberOfSection - 1) {
            number = 20.0;
            
        }else{
            number = 7.5;
        }
    }else {
        number = 7.5;
    }
    
    return number;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    int number = 5;
    
    if ([self.itemsData[self.selectName][@"components"] count] == 0) {
        number -= 1;
        components = NO;
            }
    if ([self.itemsData[self.selectName][@"lore"] isEqualToString:@""]) {
        number -= 1;
        lore = NO;
    }
    if ([self.itemsData[self.selectName][@"notes"] isEqualToString:@""]) {
        number -= 1;
        notes = NO;
    }
    if ([self.itemsData[self.selectName][@"desc"] isEqualToString:@""]) {
        number -= 1;
        desc = NO;
      
    }
    if ([self.itemsData[self.selectName][@"attrib"] isEqualToString:@""]) {
        number -= 1;
        attrib = NO;
    }

    numberOfSection = number;

    return number;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    int number = 0;
    
    if (![self.itemsData[self.selectName][@"components"] count] == 0){
           if (section == numberOfSection - 1) {
                number = (int)[self.itemsData[self.selectName][@"components"] count];
               
            }else {
                number = 1;
                
            }
    }else{
     number = 1;
        
    }

    return number;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemsCell" forIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    NSMutableArray *section = [[NSMutableArray alloc]init];

    if (lore) {
        [section addObject:@"lore"];
    }
    if (attrib) {
        [section addObject:@"attrib"];
    }
    if (notes) {
        [section addObject:@"notes"];
    }
    if (desc) {
        [section addObject:@"desc"];
    }
    if (components) {
        [section addObject:@"components"];
    }
   
    NSLog(@"%@",section);
 
    
    
    
//        NSArray *dynamicData = [NSArray arrayWithObject:];
    

    NSArray *data;
    id obj = self.itemsData[self.selectName][section[indexPath.section]];
    if ([obj isKindOfClass:[NSString class]]) {
       
        data = [NSArray arrayWithObject:obj];
    
        cell.textLabel.text = data[indexPath.row];
        
        cell.textLabel.numberOfLines = 0;
        
        
        
        return cell;
    }else{


        data = [NSArray arrayWithArray:obj];
//        cell.textLabel.text = data[indexPath.row];

        cell.textLabel.text = self.itemsData[data[indexPath.row]][@"dname"];
        
        
        NSString *urlString = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/items/%@_lg.png",data[indexPath.row]];

        NSURL *imageURL = [NSURL URLWithString:urlString];
        [cell.imageView sd_setImageWithURL:imageURL];
        cell.textLabel.numberOfLines = 0;
        
        
        
        return cell;
    }
//    NSLog(@"%@",self.itemsData[self.selectName][section[indexPath.section]]);
 

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
