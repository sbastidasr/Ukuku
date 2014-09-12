//
//  JSChooseTypeTVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 10/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSChooseTypeTVC.h"
#import "JSCreateNC.h"


@interface JSChooseTypeTVC ()

@property(strong, nonatomic)NSArray *types;

@end


@implementation JSChooseTypeTVC



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
    [self loadTypes];
    self.title = @"Tipo";
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadTypes {
    
    switch (_clasification) {
        case Flora:
            [self loadFloraTypes];
            break;
        case Fauna:
            [self loadFaunaTypes];
            break;
            
        default:
            break;
    }
    
    
    


}

-(void)loadFaunaTypes {
    
    /*_types = [[NSArray alloc] initWithObjects:
              @"Anfibios",
              @"Pajaros",
              @"Insectos",
              @"Peces",
              @"Invertebrados",
              @"Mamimferos",
              @"Animales Prehistoricos",
              @"Reptiles",
              nil];*/
    
    NSString *pathPlist = [[NSBundle mainBundle] pathForResource:@"categoryFauna" ofType:@"plist"];
    
    _types = [[NSArray alloc] initWithContentsOfFile:pathPlist];

}

-(void)loadFloraTypes {
    
    
    /*_types = [[NSArray alloc] initWithObjects:
              @"Carnivoras",
              @"Ornamenta",
              @"Feas",
              @"Flagidas",
              @"Decorativas",
              @"Arbol",
              @"Orqu",
              @"Reptiles",
              nil];*/
    
    NSString *pathPlist = [[NSBundle mainBundle] pathForResource:@"categoryFlora" ofType:@"plist"];
    
    _types = [[NSArray alloc] initWithContentsOfFile:pathPlist];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [[self types] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"type" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.types objectAtIndex:indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Selecciono: %@", [[self types] objectAtIndex:indexPath.row]);
    NSString *selected = [self.types objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    ((JSCreateNC *)self.navigationController).type =selected;
    [self.navigationController popViewControllerAnimated:YES];
    
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


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *type = [self.types objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    [self.optionSelected addEntriesFromDictionary:@{@"type":type}];
    JSCreateAnimalVC *newCreateAnimalVC = (JSCreateAnimalVC *)segue.destinationViewController;
    newCreateAnimalVC.optionSelected= self.optionSelected;
    
}
*/

@end
