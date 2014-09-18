
//
//  SBExplorarListaTVC.m
//  Ukuku
//
//  Created by Sebastian Bastidas on 9/16/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "SBExplorarListaTVC.h"
#import "UIView+BackGround.h"
#import <Parse/Parse.h>
#import "SBSpeciesDetailVC.h"

@implementation SBExplorarListaTVC


-  (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithClassName:@"Especie"];
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"Especie";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"Nombre";
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        // self.imageKey = @"image";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.region;
    [self.view setBackgroundWithImageNamed:@"background5.png"];
   
    
  //  List = @"<html><body>";
    //refresh =0;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Parse

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}

- (PFQuery *)queryForTable {
 
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
[query whereKey:@"Region" equalTo:self.region];
   [query whereKey:@"FloraFauna" equalTo:self.clasification];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];
    
 
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *cellIdentifier = @"Cell";
   
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell to show todo item with a priority at the bottom
    cell.textLabel.text = object[@"Nombre"];
    cell.detailTextLabel.text = object[@"NombreLatin"];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
 
    
    PFFile *thumbnail = object[@"foto"];
    cell.imageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    cell.imageView.file = thumbnail;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
[self performSegueWithIdentifier:@"pushViewSpecies" sender:[self.tableView cellForRowAtIndexPath:indexPath]];

}

//exploraespecie
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
    PFObject *species= [self.objects objectAtIndex:path.row];
    
    SBSpeciesDetailVC  *speciesDetailVC;
    speciesDetailVC=(SBSpeciesDetailVC  *)segue.destinationViewController;
    speciesDetailVC.species=species;

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