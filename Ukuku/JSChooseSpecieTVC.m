//
//  JSChooseSpecieTVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 17/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSChooseSpecieTVC.h"
#import "JSUploadPhotoVC.h"
#import "UIView+BackGround.h"

@interface JSChooseSpecieTVC ()

@end

@implementation JSChooseSpecieTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithClassName:@"Especie"];
    self = [super initWithStyle:style];
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
    [self configureLook];
    [self configurePFQueryTable];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureLook {
    [self.view setBackgroundWithImageNamed:@"background3.png"];
    [self configureNavigationBar];

}

-(void)configureNavigationBar {
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    backButton.tintColor = [UIColor whiteColor];
    self.title = @"Escoger Especie";
    [self.navigationItem setLeftBarButtonItem:backButton];


}

-(void)configurePFQueryTable {
    
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


-(void)backButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];


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
    
    [query whereKey:@"FloraFauna" equalTo:self.classification];
    
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
    
    
    PFFile *thumbnail = object[@"foto"];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    cell.imageView.file = thumbnail;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ((JSUploadPhotoVC *)self.presentingViewController).selectSpecie = [self.objects objectAtIndex:indexPath.row];
    [self dismissViewControllerAnimated:YES completion:^{
        self.classification=nil;
    }];
    
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
