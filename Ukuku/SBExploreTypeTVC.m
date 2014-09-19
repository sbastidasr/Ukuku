//
//  SBExploreTypeTVC.m
//  Ukuku
//
//  Created by Sebastian Bastidas on 9/16/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "SBExploreTypeTVC.h"
#import "SBExplorarListaTVC.h"
#import "UIView+BackGround.h"

@interface SBExploreTypeTVC ()

@property (nonatomic, strong) NSArray *items;

@end

@implementation SBExploreTypeTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.clasification;
    self.items= [[NSArray alloc]initWithObjects:@"Costa",@"Sierra",@"Oriente", nil];
    
    [self.view setBackgroundColor:[UIColor clearColor]];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [self.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *item = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text=item;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
    NSString *region = cell.textLabel.text;

    SBExplorarListaTVC  *explorarTVC;
    explorarTVC=(SBExplorarListaTVC  *)segue.destinationViewController;
    explorarTVC.clasification=self.clasification;
    explorarTVC.region=region;

}

#pragma Mark - OverrideMethods

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont boldSystemFontOfSize:20.0];
        titleView.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}

@end
