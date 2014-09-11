//
//  JSRiesgoTVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 10/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSChooseRiesgoTVC.h"


@interface JSChooseRiesgoTVC ()

@property(strong, nonatomic) NSArray *risk;


@end

@implementation JSChooseRiesgoTVC

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
    self.title = @"Riesgo";
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*-(void)viewWillDisappear:(BOOL)animated {

    NSString *selected = [self.risk objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    [((JSCreateAnimalNavigation *)self.navigationController.parentViewController) setRisk:selected];

}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)risk {

    if (!_risk) {
        _risk = [[NSArray alloc] initWithObjects:
        @"Excluido",
        @"Casi Amanezada (NT)",
        @"Vulnerable (VU)",
        @"En Peligro (EN)",
        @"En Peligro Critico (CR)",
        @"Extinta en estado Silvestre (EW)",
        @"Extinta (EX)"
        , nil
            ];
    }
    
    return _risk;

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self risk] count];;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"risk" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.risk objectAtIndex:indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Selecciono: %@", [[self risk] objectAtIndex:indexPath.row]);
    NSString *selected = [self.risk objectAtIndex:indexPath.row];
    
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
    NSString *risk = [self.clasificatioRisk objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    [self.optionSelected addEntriesFromDictionary:@{@"risk":risk}];
    JSChooseTypeTVC *newTypeVC = (JSChooseTypeTVC *)segue.destinationViewController;
    newTypeVC.optionSelected = self.optionSelected;
    
}
*/

@end
