//
//  NewDetailTableViewController.m
//  Dota2Heros
//
//  Created by HFY on 16/1/12.
//  Copyright © 2016年 LHP. All rights reserved.
//

#import "DetailTableViewController.h"
#import <UIImageView+WebCache.h>
#import "AbilityTableViewCell.h"
#import "BioTableViewCell.h"

@interface DetailTableViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *heroVertImageView;
@property NSDictionary *heroDetail;
@property NSString *heroBio;
@property NSMutableDictionary *heroAbility;

@end

@implementation DetailTableViewController
{
     NSString *docPath;
}


 - (void)viewDidLoad {
    [super viewDidLoad];
     self.title = self.heroDetailImageName;
    docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    [self fetchImageViewHeroImage];
    [self fetchHeroBio];
    [self fetchHeroAbilityInformation];
 
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}


 - (void)fetchImageViewHeroImage
{
    NSString *urlString = [NSString stringWithFormat:@"http://cdn.dota2.com.cn/apps/dota2/images/heroes/%@_full.png",self.heroDetailImageName];
    
    NSURL *imageURL = [NSURL URLWithString:urlString];
    
    [self.heroVertImageView sd_setImageWithURL:imageURL];
    
}


 - (void)fetchHeroBio
{
    self.heroDetail = [NSDictionary dictionaryWithContentsOfFile:[docPath stringByAppendingPathComponent:@"heroeDetaildata.plist"]];
    self.heroBio = self.heroDetail[self.heroDetailImageName][@"bio"];
    //NSLog(@"%@",self.heroDetail[self.heroDetailImageName][@"bio"]);
}


 - (void)fetchHeroAbilityInformation
{
    NSDictionary *allAbility = [NSDictionary dictionaryWithContentsOfFile:[docPath stringByAppendingPathComponent:@"heroAbilitydata.plist"]];
    self.heroAbility = [NSMutableDictionary dictionary];
  //  NSLog(@"%@",allAbility);
    
    for (NSString *name in allAbility) {
        if ([name hasPrefix:[self.heroDetailImageName stringByAppendingString:@"_"]]) {
       
            NSLog(@"%@",name);
            
            [self.heroAbility setObject:allAbility[name] forKey:name];
        }
        
    }
    
    NSLog(@"%@",self.heroAbility);
}


 - (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return  @"Ability";
        
    }else{
        return @"Bio";
    }
}


#pragma mark - Table view data source


 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 2;
}


 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) {
        return self.heroAbility.count;
        
    }else{
        return 1;
    }
    
  
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        
        AbilityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AbilityCell" forIndexPath:indexPath];
        cell.abilityDetailLabel.numberOfLines = 0;
        cell.abilityNameLabel.text = self.heroAbility[[self.heroAbility allKeys][indexPath.row]][@"dname"];
        cell.abilityDetailLabel.text = self.heroAbility[[self.heroAbility allKeys][indexPath.row]][@"desc"];
        
        
        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/abilities/%@_hp1.png",[self.heroAbility allKeys][indexPath.row]]];
        
        [cell.abilityImageView sd_setImageWithURL:imageURL];
        
        return cell;
   
    }
    else
    {
        BioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BioCell" forIndexPath:indexPath];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = self.heroBio;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
}

 - (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"%@",segue.identifier);
    if ([segue.identifier isEqualToString:@"TOWEB"])
    {
        heroVideoWebViewController *hvwVC = [segue destinationViewController];
        hvwVC.hero = [self.heroAbility allKeys][self.tableView.indexPathForSelectedRow.row];
    }
}




@end
