//
//  MasterTableViewController.m
//  Dota2Heros
//
//  Created by HFY on 16/1/11.
//  Copyright © 2016年 LHP. All rights reserved.
//

#define kAPI_KEY @"16D5983ACCB2352EB3D0C3B477537EBC"

#import "MasterTableViewController.h"
#import "DetailTableViewController.h"
#import "HeroTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "SearchResultsViewController.h"
#import "VideoTableViewModal.h"

@interface MasterTableViewController ()<UISearchResultsUpdating,UISearchControllerDelegate>

@property (nonatomic, strong) NSArray *heroList;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSDictionary *heroesDetail;
@property (nonatomic, strong) NSArray *itemsDetail;
@property (nonatomic, strong) NSMutableDictionary *itemData;
@property (nonatomic, strong) NSMutableArray *localized_namedataArray;
@property (nonatomic, strong) NSMutableArray *namedataArray;
@property (nonatomic, strong) NSMutableArray *searchDataArray;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic,strong)VideoTableViewModal *cellModal;

@property NSMutableDictionary *itemNameList;
@property (strong, nonatomic) NSArray *item;;
@end

@implementation MasterTableViewController
{
    NSString *docPath;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithRed:93.0/255.0 green:71.0/255.0 blue:139.0/255.0 alpha:1.0];

    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    [self setupDataSource];
    [self setSearchBar];
    [self setNavigationBar];
    if (!self.cellModal) {
        self.cellModal = [[VideoTableViewModal alloc]initData];
        NSLog(@"初始化videomodal");
    }


  
    
    NSLog(@"%@",docPath);
    
    
}

- (void)setNavigationBar
{
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:93.0/255.0 green:71.0/255.0 blue:139.0/255.0 alpha:1.0]];
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    
    self.title = @"Dota2 heroPedia";

}

- (void)setSearchBar
{
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
//        self.definesPresentationContext = YES;

    self.searchController.searchBar.barTintColor = [UIColor colorWithRed:134.0/255.0 green:127.0/255.0 blue:208.0/255.0 alpha:1.0];
    self.localized_namedataArray = [[NSMutableArray alloc]init];

    for (id obj in self.heroList) {
        
        if ([obj[@"localized_name"] isKindOfClass:[NSString class]]) {
            
            [self.localized_namedataArray addObject:obj[@"localized_name"]];
            [self.namedataArray addObject:obj[@"name"]];
//            NSLog(@"%@",obj[@"localized_name"]);
            
            
        }
        
    }

//    NSLog(@"dataArray %@",self.localized_namedataArray);
}

- (UISearchController *)searchController {
    if (!_searchController) {
       
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        //  接下来都是定义searchBar的样式
        _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.size.width, 44.0);
        _searchController.searchBar.placeholder = @"Hero";
        _searchController.searchResultsUpdater = self;
        _searchController.delegate = self;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        _searchController.obscuresBackgroundDuringPresentation = YES;
        _searchController.dimsBackgroundDuringPresentation = YES;
     
        return _searchController;
    }
    return _searchController;
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
   
    NSMutableArray *tempArray = [NSMutableArray array];
  
    NSString *text = searchController.searchBar.text;
    //  遍历源数据中的联系人
    for (NSString *name in self.localized_namedataArray) {
        //  1、text不能为空，第二判断contact是否包括字符串text，是得话，加入到临时数组中
        if ([text length] != 0 && [name containsString:text]) {
            [tempArray addObject:name];
        }
    }
   
    
    self.searchDataArray = [NSMutableArray arrayWithArray:tempArray];
    [self.tableView reloadData];

}

 - (void)fetchHeroesList
{
    NSURL *apiURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.steampowered.com/IEconDOTA2_570/GetHeroes/v0001/?key=%@&language=en_US",kAPI_KEY]];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:apiURL
                                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
      
                                                     NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
      
                                                     self.heroList = json[@"result"][@"heroes"];
        
                                                     [self.heroList writeToFile:[docPath stringByAppendingPathComponent:@"heroListdata.plist"] atomically:YES];
    
                                                     dispatch_sync(dispatch_get_main_queue(), ^{
            
            
                                                         [self.tableView reloadData];
       
                                                     });
                                                 }];
    
    
    [dataTask resume];
}

- (void)fetchHeroesDetailInfotmation
{
    NSURL *apiURL = [NSURL URLWithString:@"http://www.dota2.com/jsfeed/heropickerdata?v=18874723138974056&l=english"];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:apiURL
                                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
       
                                                     self.heroesDetail = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                     
                                                     [self.heroesDetail writeToFile:[docPath stringByAppendingPathComponent:@"heroeDetaildata.plist"] atomically:YES];
                                                     
                                                 }];
    
    [dataTask resume];
}

 - (void)fetchHeroeAbilityData
{
    NSURL *apiURL = [NSURL URLWithString:@"http://www.dota2.com/jsfeed/abilitydata?v=18874723138974056&l=english"];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:apiURL
                                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
                                                     NSDictionary *abilityData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"abilitydata"];
        
                                                     [abilityData writeToFile:[docPath stringByAppendingPathComponent:@"heroAbilitydata.plist"] atomically:YES];
    }];
    
    [dataTask resume];

}

 - (void)fetchItemList
{
    NSURL *apiURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.steampowered.com/IEconDOTA2_570/GetGameItems/v0001/?key=%@&language=en_US",kAPI_KEY]];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:apiURL
                                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                     
                                                     
                                                     NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                
                                                     self.item = [[NSArray alloc]init];
                                                     self.item = json[@"result"][@"items"];
                                                     
                                                     
                                                     self.itemNameList = [[NSMutableDictionary alloc]init];
                                                     NSMutableArray *localized_name = [[NSMutableArray alloc]init];
                                                     
                                                     for (NSDictionary *itemDic in self.item)
                                                     {
                                                         [localized_name addObject:itemDic[@"localized_name"]];
                                                     }
                                                     
                                                     for (int i=0; i < localized_name.count; i++) {
                                                         for (NSDictionary *itemDic in self.item) {
                                                             
                                                             if ([itemDic[@"localized_name"] isEqualToString:localized_name[i]]) {
                                                                 
                                                                 [self.itemNameList setObject:itemDic forKey:itemDic[@"localized_name"]];
                                                                 
                                                             }
                                                         }
                                                     }
                                                     [self.itemNameList writeToFile:[docPath stringByAppendingPathComponent:@"itemNameListdata.plist"] atomically:YES];
                                                     
                                                     
                                                 }];
    
    
    [dataTask resume];
}


 - (void)setupDataSource
{
    if ([[NSFileManager defaultManager]fileExistsAtPath:[docPath stringByAppendingPathComponent:@"heroListdata.plist"]]) {
        
        self.heroList = [NSArray arrayWithContentsOfFile:[docPath stringByAppendingPathComponent:@"heroListdata.plist"]];
        
    }else{
        
        [self fetchHeroesList];
        
    }
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:[docPath stringByAppendingPathComponent:@"heroeDetaildata.plist"]]) {
        
        self.heroesDetail = [NSDictionary dictionaryWithContentsOfFile:[docPath stringByAppendingPathComponent:@"heroeDetaildata.plist"]];
        
    }else{
    
        [self fetchHeroesDetailInfotmation];
        
    }
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:[docPath stringByAppendingPathComponent:@"heroAbilitydata.plist"]]) {
    
        
    }else{
        
        [self fetchHeroeAbilityData];
    }
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:[docPath stringByAppendingPathComponent:@"itemNameListdata.plist"]]) {
        
        
    }else{
        
        [self fetchItemList];
    }
    
//    if ([[NSFileManager defaultManager]fileExistsAtPath:[docPath stringByAppendingPathComponent:@"ItemsDetaildata.plist"]]) {
//        
//        NSLog(@"有ItemsDetaildata.plist");
//    }else{
//        
//        [self fetchItemsDetailInfotmation];
//    }
    
}

 - (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"TODETAIL"]) {
        
        DetailTableViewController *detailVC = [segue destinationViewController];
        
        NSString *fetchName = self.heroList[self.tableView.indexPathForSelectedRow.row][@"name"];
        NSString *selecteHero = [fetchName stringByReplacingOccurrencesOfString:@"npc_dota_hero_" withString:@""];
        detailVC.heroDetailImageName = selecteHero;
        //NSLog(@"%@",selecteHero);
    }
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
    
    if (self.searchController.active) {
        return self.searchDataArray.count;
    }else{
        return self.heroList.count;
    }
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeroTableViewCell *cell = (HeroTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[HeroTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    if (self.searchController.active) {
        
        cell.nameLabel.text = self.searchDataArray[indexPath.row];
        
    }else{
    
    NSString *resourceName = self.heroList[indexPath.row][@"name"];
    
    NSString *realName = [resourceName stringByReplacingOccurrencesOfString:@"npc_dota_hero_" withString:@""];
    
    NSString *urlString = [NSString stringWithFormat:@"http://cdn.dota2.com.cn/apps/dota2/images/heroes/%@_vert.jpg",realName];
    
    NSURL *imageURL = [NSURL URLWithString:urlString];
    
    [cell.iconImageView sd_setImageWithURL:imageURL];
    

    cell.nameLabel.text = self.heroList[indexPath.row][@"localized_name"];
    
    cell.typeLabel.text = self.heroesDetail[realName][@"atk_l"];
    }
    return cell;
}

//- (void)fetchItemsDetailInfotmation
//{
//    NSURL *apiURL = [NSURL URLWithString:@"http://www.dota2.com/jsfeed/itemdata"];
//    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:apiURL
//                                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//                                                     NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil][@"itemdata"];
//
//                                                     for (NSString *name in dic) {
//                                                         for (NSDictionary *obj in dic[name]) {
//                                                             NSLog(@"%@",[NSString stringWithUTF8String:object_getClassName(obj)]);
//                                                             NSLog(@"%@",obj);
//                                                             [self.itemData setObject:obj forKey:dic[name]];
//                                                         }
//                                                     }
//                                                     NSLog(@"%@",self.itemData);
////                                                     NSLog(@"%@",dic);
//                                                     [dic writeToFile:[docPath stringByAppendingPathComponent:@"ItemsDetaildata.plist"] atomically:YES];
//
//                                                 }];
//
//    [dataTask resume];
//
////    NSDictionary *itemsData = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"itemsData" ofType:@"plist"]][@"itemdata"];
////
////
////    NSLog(@"%@",itemsData);
//}

@end
