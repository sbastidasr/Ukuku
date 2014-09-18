//
//  SBNuevasTVC.m
//  Ukuku
//
//  Created by Sebastian Bastidas on 9/18/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "SBNuevasTVC.h"
#import <Parse/Parse.h>
#import "SBNewsCell.h"

@interface SBNuevasTVC ()

@end

@implementation SBNuevasTVC

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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SBNewsCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    
    
    
    
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"PhotoLocation"];
    //[query whereKey:@"specie" equalTo:@"asd"];   asd cuando solo se quiera una especie especifica.
    [query orderByDescending:@"updatedAt"];
    query.limit = 10;
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSLog(@"titulo: %@", object[@"titulo"]);
                NSLog(@"comentario: %@", object[@"comentario"]);
            //  NSLog(@"location string: %@", usuario[@"n"]);  el miji debe traer el string del location.
                
                PFObject *usuario=object[@"user"];
                PFObject *especie=object[@"specie"]; // para el link
                
                [usuario fetchIfNeededInBackgroundWithBlock:^(PFObject *usuario, NSError *error) {
                    NSMutableDictionary *profile= usuario[@"profile"];
                    
                    PFFile * asd;
                    [asd getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        UIImage *asd =[UIImage imageWithData:data];  //este asignarle al outlet
                    }];
                    
                    NSLog(@"nombre usuario: %@", [profile objectForKey:@"name"] );

                }];

            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBNewsCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [cell cleanCell];
    
    //le mando con cell.especie =
    //le mand el usuario
    
    
    
    
    [cell configureCell];
    return cell;
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
