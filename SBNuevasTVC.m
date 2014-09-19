//
//  SBNuevasTVC.m
//  Ukuku
//
//  Created by Sebastian Bastidas on 9/18/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "SBNuevasTVC.h"
#import <Parse/Parse.h>
#import "SBNewsCellNuevo.h"


@interface SBNuevasTVC ()



@end

@implementation SBNuevasTVC


-  (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithClassName:@"Especie"];
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"PhotoLocation";
        
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

- (PFQuery *)queryForTable {
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    query.limit = 10;
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    [query orderByDescending:@"updatedAt"];
    return query;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    SBNewsCellNuevo  *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(!cell){
     [tableView registerNib:[UINib nibWithNibName:@"SBNewsCellNuevo" bundle:nil] forCellReuseIdentifier:@"myCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    }
    
    
    [cell cleanCell];
    
    
    cell.photoTitleProperty=object[@"titulo"];
    PFObject *usuario=object[@"user"];
    PFObject *especie=object[@"specie"];
    
    NSString *usuarioId=usuario.objectId;
    cell.userId=usuarioId;
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
    [query whereKey:@"user" equalTo:usuario];
    
    PFFile *speciesPic=[object objectForKey:@"imageFile"];
    [speciesPic getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        cell.speciesImageProperty=[UIImage imageWithData:data];}];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count>0) {
            
            PFObject *imageObject = [objects lastObject];
            PFFile *theImage = [imageObject objectForKey:@"imageFile"];
            
            [theImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                NSData *imageData = data;
                UIImage *image = [UIImage imageWithData:imageData];
                cell.userImageProperty=image;
            }];
        }
    }];
    
    
    [usuario fetchIfNeededInBackgroundWithBlock:^(PFObject *usuario, NSError *error) {
       NSMutableDictionary *profile= usuario[@"profile"];
        cell.userNameProperty=[profile objectForKey:@"name"];
    }];
    
    [especie fetchIfNeededInBackgroundWithBlock:^(PFObject *especie, NSError *error) {
        cell.speciesNameProperty=[especie objectForKey:@"Nombre"];
    }];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    PFGeoPoint *pfGeoPoint= object[@"location"];
    CLLocation *asd=[[CLLocation alloc]initWithLatitude:pfGeoPoint.latitude longitude:pfGeoPoint.longitude];
    
    [geocoder reverseGeocodeLocation:asd completionHandler:^(NSArray *placemarks, NSError *error) {
        if(placemarks.count) {
            
            NSDictionary *dictionary = [[placemarks objectAtIndex:0] addressDictionary];
            NSMutableString *s = [NSMutableString stringWithFormat:@"%@, ", [dictionary valueForKey:@"City"]];
            [s appendString:[dictionary valueForKey:@"State"]];
            cell.locationStringProperty=s;
        }
    }];
  
    [cell configureCell];
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {

    return NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 334;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureNavigationBar];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureNavigationBar {
    
    self.title =@"Nuevas";
    [[UINavigationBar appearance] setBackgroundColor:[UIColor grayColor]];

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
