//
//  JSChooseRegionTVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 10/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSChooseRegionTVC.h"
#import "JSChooseRiesgoTVC.h"

@interface JSChooseRegionTVC ()

@property(strong, nonatomic) NSArray *regions;
@property(strong, nonatomic)NSMutableDictionary *optionSelected;

@end

@implementation JSChooseRegionTVC

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
    self.title = @"Region";
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(NSArray *)regions {

    if (!_regions) {
        _regions = [[NSArray alloc] initWithObjects:@"Costa",@"Sierra",@"Oriente",@"Insular", nil];
    }
    
    return _regions;

}

-(NSMutableDictionary *)optionSelected {

    if (!_optionSelected) {
        _optionSelected = [[NSMutableDictionary alloc] init];
    }
    
    return _optionSelected;

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
    return [[self regions] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"region" forIndexPath:indexPath];
    cell.textLabel.text = [self.regions objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"Selecciono: %@", [[self regions] objectAtIndex:indexPath.row]);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    

}



-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *region = [self.regions objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    [self.optionSelected addEntriesFromDictionary:@{@"region":region}];
    JSChooseRiesgoTVC *newRiskVC = (JSChooseRiesgoTVC *)segue.destinationViewController;
    newRiskVC.optionSelected =self.optionSelected;
}


@end
