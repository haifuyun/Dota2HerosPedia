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

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSDictionary *item;
@property (strong, nonatomic) itemDetailViewController *itemDVC;

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
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:self.view.backgroundColor,NSForegroundColorAttributeName, nil];
    }
//    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//    button.imageView.image = [UIImage imageNamed:@"11.png"];
//    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:button];
//    self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"11.png"];
    // 如果有tabBarController，底部需要添加额外滚动区域
//    self.tableView.contentInset = UIEdgeInsetsMake(64 + 44, 0, 49, 0);
    
    
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:self.view.backgroundColor,NSForegroundColorAttributeName, nil];
//
//}

- (void) initDataSource
{
    docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    self.item = [NSDictionary dictionaryWithContentsOfFile:[docPath stringByAppendingPathComponent:@"itemNameListdata.plist"]];
    
//    NSLog(@"22222222222222222 %@",self.item);
    
    NSArray * a = @[@"Clarity",
                    @"Faerie Fire",
                    @"Enchanted Mango",
                    @"Tango",
                    @"Healing Salve",
                    @"Smoke of Deceit",
                    @"Town Portal Scroll",
                    @"Dust of Appearance",
                    @"Animal Courier",
                    @"Flying Courier",
                    @"Observer Ward",
                    @"Sentry Ward",
                    @"Bottle"];
    
    NSArray * b = @[@"Iron Branch",
                    @"Gauntlets of Strength",
                    @"Slippers of Agility",
                    @"Mantle of Intelligence",
                    @"Circlet",
                    @"Belt of Strength",
                    @"Band of Elvenskin",
                    @"Robe of the Magi",
                    @"Ogre Club",
                    @"Blade of Alacrity",
                    @"Staff of Wizardry"];
    
    NSArray * c = @[@"Ring of Protection",
                    @"Stout Shield",
                    @"Quelling Blade",
                    @"Orb of Venom",
                    @"Blades of Attack",
                    @"Chainmail",
                    @"Quarterstaff",
                    @"Helm of Iron Will",
                    @"Broadsword",
                    @"Claymore",
                    @"Javelin",
                    @"Mithril Hammer"];
    
    NSArray * d = @[@"Magic Stick",
                    @"Sage's Mask",
                    @"Ring of Regen",
                    @"Boots of Speed",
                    @"Gloves of Haste",
                    @"Cloak",
                    @"Ring of Health",
                    @"Void Stone",
                    @"Gem of True Sight",
                    @"Morbid Mask",
                    @"Shadow Amulet",
                    @"Ghost Scepter",
                    @"Blink Dagger"];
    
    NSArray * e = @[@"Magic Wand",
                    @"Null Talisman",
                    @"Wraith Band",
                    @"Poor Man's Shield",
                    @"Bracer",
                    @"Soul Ring",
                    @"Phase Boots",
                    @"Power Treads",
                    @"Oblivion Staff",
                    @"Perseverance",
                    @"Hand of Midas",
                    @"Boots of Travel",
                    @"Moon Shard"];
    
    NSArray * f = @[@"Ring of Basilius",
                    @"Iron Talon",
                    @"Headdress",
                    @"Buckler",
                    @"Urn of Shadows",
                    @"Tranquil Boots",
                    @"Ring of Aquila",
                    @"Medallion of Courage",
                    @"Arcane Boots",
                    @"Drum of Endurance",
                    @"Mekansm",
                    @"Vladmir's Offering",
                    @"Guardian Greaves",
                    @"Pipe of Insight"];
    
    NSArray * g = @[@"Glimmer Cape",
                    @"Force Staff",
                    @"Veil of Discord",
                    @"Aether Lens",
                    @"Necronomicon",
                    @"Dagon",
                    @"Eul's Scepter of Divinity",
                    @"Solar Crest",
                    @"Rod of Atos",
                    @"Orchid Malevolence",
                    @"Aghanim's Scepter",
                    @"Refresher Orb",
                    @"Scythe of Vyse",
                    @"Octarine Core"];
  
    NSArray * h = @[@"Crystalys",
                    @"Armlet of Mordiggian",
                    @"Shadow Blade",
                    @"Skull Basher",
                    @"Battle Fury",
                    @"Ethereal Blade",
                    @"Silver Edge",
                    @"Radiance",
                    @"Monkey King Bar",
                    @"Daedalus",
                    @"Butterfly",
                    @"Divine Rapier",
                    @"Abyssal Blade"];
    
    NSArray * i = @[@"Hood of Defiance",
                    @"Vanguard",
                    @"Blade Mail",
                    @"Soul Booster",
                    @"Crimson Guard",
                    @"Black King Bar",
                    @"Lotus Orb",
                    @"Shiva's Guard",
                    @"Bloodstone",
                    @"Manta Style",
                    @"Linken's Sphere",
                    @"Assault Cuirass",
                    @"Heart of Tarrasque"];
    
    NSArray * j = @[@"Mask of Madness",
                    @"Helm of the Dominator",
                    @"Dragon Lance",
                    @"Sange",
                    @"Yasha",
                    @"Maelstrom",
                    @"Diffusal Blade",
                    @"Desolator",
                    @"Heaven's Halberd",
                    @"Sange and Yasha",
                    @"Eye of Skadi",
                    @"Mjollnir",
                    @"Satanic"];
    
    
    NSArray * k = @[@"Energy Booster",
                    @"Vitality Booster",
                    @"Point Booster",
                    @"Platemail",
                    @"Talisman of Evasion",
                    @"Hyperstone",
                    @"Ultimate Orb",
                    @"Demon Edge",
                    @"Mystic Staff",
                    @"Reaver",
                    @"Eaglesong",
                    @"Sacred Relic"];
    
    _dataSource = [[NSMutableArray alloc]init];
    [_dataSource addObject:a];
    [_dataSource addObject:b];
    [_dataSource addObject:c];
    [_dataSource addObject:d];
    [_dataSource addObject:e];
    [_dataSource addObject:f];
    [_dataSource addObject:g];
    [_dataSource addObject:h];
    [_dataSource addObject:i];
    [_dataSource addObject:j];
    [_dataSource addObject:k];
    
    
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

    
    if ([self.title isEqualToString:@"Consumables"]) {
        
        number = [_dataSource[0] count];
        
    }
    if ([self.title isEqualToString:@"Attributes"]) {
        
          number = [_dataSource[1] count];
        
    }
    if ([self.title isEqualToString:@"Armaments"]) {
        
          number = [_dataSource[2] count];
        
    }
        if ([self.title isEqualToString:@"Arcane"]) {
    
          number = [_dataSource[3] count];
        
    }
        if ([self.title isEqualToString:@"Common"]) {
        
        number = [_dataSource[4] count];

    }
        if ([self.title isEqualToString:@"Support"]) {
        
          number = [_dataSource[5] count];

    }
        if ([self.title isEqualToString:@"Caster"]) {
        
          number = [_dataSource[6] count];

    }
        if ([self.title isEqualToString:@"Weapons"]) {
        
          number = [_dataSource[7] count];

    }
        if ([self.title isEqualToString:@"Armor"]) {
        
          number = [_dataSource[8] count];
        
    }
        if ([self.title isEqualToString:@"Artifacts"]) {
        
          number = [_dataSource[9] count];

    }
        if ([self.title isEqualToString:@"Secret"]) {
        
         number =  [_dataSource[10] count];
        
    }

    return number;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    UIStoryboard *itemDeatil = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    self.itemDVC = [itemDeatil instantiateViewControllerWithIdentifier:@"itemDetailView"];
    self.itemDVC.backgroundColor = self.view.backgroundColor;
    if ([self.title isEqualToString:@"Consumables"]) {
        
        NSLog(@"%@",[NSString stringWithFormat:@"%@",self.item[_dataSource[0][self.tableView.indexPathForSelectedRow.row]][@"name"]]) ;
         self.itemDVC.selectName =  [[NSString stringWithFormat:@"%@",self.item[_dataSource[0][self.tableView.indexPathForSelectedRow.row]][@"name"]] stringByReplacingOccurrencesOfString:@"item_" withString:@""];
    }
    if ([self.title isEqualToString:@"Attributes"]) {
        
        NSLog(@"%@",[NSString stringWithFormat:@"%@",self.item[_dataSource[1][self.tableView.indexPathForSelectedRow.row]][@"name"]]) ;
 
        self.itemDVC.selectName =  [[NSString stringWithFormat:@"%@",self.item[_dataSource[1][self.tableView.indexPathForSelectedRow.row]][@"name"]] stringByReplacingOccurrencesOfString:@"item_" withString:@""];
    }
    if ([self.title isEqualToString:@"Armaments"]) {
        
        NSLog(@"%@",[NSString stringWithFormat:@"%@",self.item[_dataSource[2][self.tableView.indexPathForSelectedRow.row]][@"name"]]) ;

        self.itemDVC.selectName =  [[NSString stringWithFormat:@"%@",self.item[_dataSource[2][self.tableView.indexPathForSelectedRow.row]][@"name"]] stringByReplacingOccurrencesOfString:@"item_" withString:@""];
    }
    if ([self.title isEqualToString:@"Arcane"]) {
        
        NSLog(@"%@",[NSString stringWithFormat:@"%@",self.item[_dataSource[3][self.tableView.indexPathForSelectedRow.row]][@"name"]]) ;

        self.itemDVC.selectName =  [[NSString stringWithFormat:@"%@",self.item[_dataSource[3][self.tableView.indexPathForSelectedRow.row]][@"name"]] stringByReplacingOccurrencesOfString:@"item_" withString:@""];
    }
    if ([self.title isEqualToString:@"Common"]) {
        
        NSLog(@"%@",[NSString stringWithFormat:@"%@",self.item[_dataSource[4][self.tableView.indexPathForSelectedRow.row]][@"name"]]) ;

        self.itemDVC.selectName =  [[NSString stringWithFormat:@"%@",self.item[_dataSource[4][self.tableView.indexPathForSelectedRow.row]][@"name"]] stringByReplacingOccurrencesOfString:@"item_" withString:@""];
    }
    if ([self.title isEqualToString:@"Support"]) {
        
        NSLog(@"%@",[NSString stringWithFormat:@"%@",self.item[_dataSource[5][self.tableView.indexPathForSelectedRow.row]][@"name"]]) ;

        self.itemDVC.selectName =  [[NSString stringWithFormat:@"%@",self.item[_dataSource[5][self.tableView.indexPathForSelectedRow.row]][@"name"]] stringByReplacingOccurrencesOfString:@"item_" withString:@""];
    }
    if ([self.title isEqualToString:@"Caster"]) {
        
        NSLog(@"%@",[NSString stringWithFormat:@"%@",self.item[_dataSource[6][self.tableView.indexPathForSelectedRow.row]][@"name"]]) ;
 
        self.itemDVC.selectName =  [[NSString stringWithFormat:@"%@",self.item[_dataSource[6][self.tableView.indexPathForSelectedRow.row]][@"name"]] stringByReplacingOccurrencesOfString:@"item_" withString:@""];
    }
    if ([self.title isEqualToString:@"Weapons"]) {
        
        NSLog(@"%@",[NSString stringWithFormat:@"%@",self.item[_dataSource[7][self.tableView.indexPathForSelectedRow.row]][@"name"]]) ;

        self.itemDVC.selectName =  [[NSString stringWithFormat:@"%@",self.item[_dataSource[7][self.tableView.indexPathForSelectedRow.row]][@"name"]] stringByReplacingOccurrencesOfString:@"item_" withString:@""];
    }
    if ([self.title isEqualToString:@"Armor"]) {
        
        NSLog(@"%@",[NSString stringWithFormat:@"%@",self.item[_dataSource[8][self.tableView.indexPathForSelectedRow.row]][@"name"]]) ;

        self.itemDVC.selectName =  [[NSString stringWithFormat:@"%@",self.item[_dataSource[8][self.tableView.indexPathForSelectedRow.row]][@"name"]] stringByReplacingOccurrencesOfString:@"item_" withString:@""];
    }
    if ([self.title isEqualToString:@"Artifacts"]) {
        
        NSLog(@"%@",[NSString stringWithFormat:@"%@",self.item[_dataSource[9][self.tableView.indexPathForSelectedRow.row]][@"name"]]) ;

        self.itemDVC.selectName =  [[NSString stringWithFormat:@"%@",self.item[_dataSource[9][self.tableView.indexPathForSelectedRow.row]][@"name"]] stringByReplacingOccurrencesOfString:@"item_" withString:@""];
    }
    if ([self.title isEqualToString:@"Secret"]) {
        
        NSLog(@"%@",[NSString stringWithFormat:@"%@",self.item[_dataSource[10][self.tableView.indexPathForSelectedRow.row]][@"name"]]) ;
 
        self.itemDVC.selectName =  [[NSString stringWithFormat:@"%@",self.item[_dataSource[10][self.tableView.indexPathForSelectedRow.row]][@"name"]] stringByReplacingOccurrencesOfString:@"item_" withString:@""];
    }
    
    
  


    
    [self.navigationController pushViewController:self.itemDVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"ItemsSliderBarCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"ItemsSliderBarCell"];
        nibsRegistered = YES;
    }
    
    static NSString *ID = @"ItemsSliderBarCell";
    ItemsSliderBarCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    
    if ([self.title isEqualToString:@"Consumables"]) {
        
            NSString *resourceName = self.item[_dataSource[0][indexPath.row]][@"name"];
        
//        NSLog(@" aaaaaaaa    %@",_dataSource[0]);
            NSString *realName = [resourceName stringByReplacingOccurrencesOfString:@"item_" withString:@""];
        
            NSString *urlString = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/items/%@_lg.png",realName];
        
            NSURL *imageURL = [NSURL URLWithString:urlString];
        
            [cell.itemImageView sd_setImageWithURL:imageURL];
        
            cell.itemNameLabel.text = _dataSource[0][indexPath.row];
        
            cell.costNumberLabel.text = [NSString stringWithFormat:@"%@",self.item[_dataSource[0][indexPath.row]][@"cost"]];
        
            cell.costImageView.image = [UIImage imageNamed:@"gold.png"];
        
        

    }else     if ([self.title isEqualToString:@"Attributes"]) {
        
        NSString *resourceName = self.item[_dataSource[1][indexPath.row]][@"name"];
        
        NSString *realName = [resourceName stringByReplacingOccurrencesOfString:@"item_" withString:@""];
        
        NSString *urlString = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/items/%@_lg.png",realName];
        
        NSURL *imageURL = [NSURL URLWithString:urlString];
        
        [cell.itemImageView sd_setImageWithURL:imageURL];
        
        cell.itemNameLabel.text = _dataSource[1][indexPath.row];
        
        cell.costNumberLabel.text = [NSString stringWithFormat:@"%@",self.item[_dataSource[1][indexPath.row]][@"cost"]];
        
        cell.costImageView.image = [UIImage imageNamed:@"gold.png"];
        

        
    }else     if ([self.title isEqualToString:@"Armaments"]) {
        
        NSString *resourceName = self.item[_dataSource[2][indexPath.row]][@"name"];
        
        NSString *realName = [resourceName stringByReplacingOccurrencesOfString:@"item_" withString:@""];
        
        NSString *urlString = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/items/%@_lg.png",realName];
        
        NSURL *imageURL = [NSURL URLWithString:urlString];
        
        [cell.itemImageView sd_setImageWithURL:imageURL];
        
        cell.itemNameLabel.text = _dataSource[2][indexPath.row];

        cell.costNumberLabel.text = [NSString stringWithFormat:@"%@",self.item[_dataSource[2][indexPath.row]][@"cost"]];
        
        cell.costImageView.image = [UIImage imageNamed:@"gold.png"];
        

        
    }else     if ([self.title isEqualToString:@"Arcane"]) {
        
        NSString *resourceName = self.item[_dataSource[3][indexPath.row]][@"name"];
        
        NSString *realName = [resourceName stringByReplacingOccurrencesOfString:@"item_" withString:@""];
        
        NSString *urlString = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/items/%@_lg.png",realName];
        
        NSURL *imageURL = [NSURL URLWithString:urlString];
        
        [cell.itemImageView sd_setImageWithURL:imageURL];
        
        cell.itemNameLabel.text = _dataSource[3][indexPath.row];
        
        cell.costNumberLabel.text = [NSString stringWithFormat:@"%@",self.item[_dataSource[3][indexPath.row]][@"cost"]];
        
        cell.costImageView.image = [UIImage imageNamed:@"gold.png"];
        

        
    }else     if ([self.title isEqualToString:@"Common"]) {
        
        NSString *resourceName = self.item[_dataSource[4][indexPath.row]][@"name"];
        
        NSString *realName = [resourceName stringByReplacingOccurrencesOfString:@"item_" withString:@""];
        
        NSString *urlString = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/items/%@_lg.png",realName];
        
        NSURL *imageURL = [NSURL URLWithString:urlString];
        
        [cell.itemImageView sd_setImageWithURL:imageURL];
        
        cell.itemNameLabel.text = _dataSource[4][indexPath.row];
        
        NSLog(@"cost  %@",self.item[_dataSource[4][indexPath.row]][@"cost"]);
        
        cell.costNumberLabel.text = [NSString stringWithFormat:@"%@",self.item[_dataSource[4][indexPath.row]][@"cost"]];
        
        cell.costImageView.image = [UIImage imageNamed:@"gold.png"];
        

    }else     if ([self.title isEqualToString:@"Support"]) {
        
        NSString *resourceName = self.item[_dataSource[5][indexPath.row]][@"name"];
        
        NSString *realName = [resourceName stringByReplacingOccurrencesOfString:@"item_" withString:@""];
        
        NSString *urlString = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/items/%@_lg.png",realName];
        
        NSURL *imageURL = [NSURL URLWithString:urlString];
        
        [cell.itemImageView sd_setImageWithURL:imageURL];
        
        cell.itemNameLabel.text = _dataSource[5][indexPath.row];
        
        cell.costNumberLabel.text = [NSString stringWithFormat:@"%@",self.item[_dataSource[5][indexPath.row]][@"cost"]];
        
        cell.costImageView.image = [UIImage imageNamed:@"gold.png"];
        
        
    }else     if ([self.title isEqualToString:@"Caster"]) {
        
        NSString *resourceName = self.item[_dataSource[6][indexPath.row]][@"name"];
        
        NSString *realName = [resourceName stringByReplacingOccurrencesOfString:@"item_" withString:@""];
        
        NSString *urlString = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/items/%@_lg.png",realName];
        
        NSURL *imageURL = [NSURL URLWithString:urlString];
        
        [cell.itemImageView sd_setImageWithURL:imageURL];
        
        cell.itemNameLabel.text = _dataSource[6][indexPath.row];
        
        cell.costNumberLabel.text = [NSString stringWithFormat:@"%@",self.item[_dataSource[6][indexPath.row]][@"cost"]];
        
        cell.costImageView.image = [UIImage imageNamed:@"gold.png"];
        
        
    }else     if ([self.title isEqualToString:@"Weapons"]) {
        
        NSString *resourceName = self.item[_dataSource[7][indexPath.row]][@"name"];
        
        NSString *realName = [resourceName stringByReplacingOccurrencesOfString:@"item_" withString:@""];
        
        NSString *urlString = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/items/%@_lg.png",realName];
        
        NSURL *imageURL = [NSURL URLWithString:urlString];
        
        [cell.itemImageView sd_setImageWithURL:imageURL];
        
        cell.itemNameLabel.text = _dataSource[7][indexPath.row];
        
        cell.costNumberLabel.text = [NSString stringWithFormat:@"%@",self.item[_dataSource[7][indexPath.row]][@"cost"]];
        
        cell.costImageView.image = [UIImage imageNamed:@"gold.png"];
        
        
    }else     if ([self.title isEqualToString:@"Armor"]) {
        
        NSString *resourceName = self.item[_dataSource[8][indexPath.row]][@"name"];
        
        NSString *realName = [resourceName stringByReplacingOccurrencesOfString:@"item_" withString:@""];
        
        NSString *urlString = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/items/%@_lg.png",realName];
        
        NSURL *imageURL = [NSURL URLWithString:urlString];
        
        [cell.itemImageView sd_setImageWithURL:imageURL];
        
        cell.itemNameLabel.text = _dataSource[8][indexPath.row];
        
        cell.costNumberLabel.text = [NSString stringWithFormat:@"%@",self.item[_dataSource[8][indexPath.row]][@"cost"]];
        
        cell.costImageView.image = [UIImage imageNamed:@"gold.png"];
        
        
    }else     if ([self.title isEqualToString:@"Artifacts"]) {
        
        NSString *resourceName = self.item[_dataSource[9][indexPath.row]][@"name"];
        
        NSString *realName = [resourceName stringByReplacingOccurrencesOfString:@"item_" withString:@""];
        
        NSString *urlString = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/items/%@_lg.png",realName];
        
        NSURL *imageURL = [NSURL URLWithString:urlString];
        
        [cell.itemImageView sd_setImageWithURL:imageURL];
        
        cell.itemNameLabel.text = _dataSource[9][indexPath.row];
        
        cell.costNumberLabel.text = [NSString stringWithFormat:@"%@",self.item[_dataSource[9][indexPath.row]][@"cost"]];
        
        cell.costImageView.image = [UIImage imageNamed:@"gold.png"];
        
        
    }else     if ([self.title isEqualToString:@"Secret"]) {
        
        NSString *resourceName = self.item[_dataSource[10][indexPath.row]][@"name"];
        
        NSString *realName = [resourceName stringByReplacingOccurrencesOfString:@"item_" withString:@""];
        
        NSString *urlString = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/items/%@_lg.png",realName];
        
        NSURL *imageURL = [NSURL URLWithString:urlString];
        
        [cell.itemImageView sd_setImageWithURL:imageURL];
        
        cell.itemNameLabel.text = _dataSource[10][indexPath.row];
        
        cell.costNumberLabel.text = [NSString stringWithFormat:@"%@",self.item[_dataSource[10][indexPath.row]][@"cost"]];
        
        cell.costImageView.image = [UIImage imageNamed:@"gold.png"];
        
 
    }
    


    return cell;
}


@end
