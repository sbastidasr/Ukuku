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
    
   // cell.userId=(NSString *)usuario.objectId;
    NSString *usuarioId=usuario.objectId;
    
    cell.userId=usuarioId;
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
    [query whereKey:@"user" equalTo:usuario];
    
    
    PFFile *speciesPic=[object objectForKey:@"imageFile"];
    [speciesPic getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        cell.speciesImageProperty=[UIImage imageWithData:data];
    }];
    
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

//    cell.locationStringProperty=@"4asd";
    [cell configureCell];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 334;

}



- (void)viewDidLoad
{
    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
