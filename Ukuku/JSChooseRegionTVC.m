//
//  JSChooseRegionTVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 10/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSChooseRegionTVC.h"
#import "JSCreateNC.h"
#import "UITableViewController+TitleColor.h"


@interface JSChooseRegionTVC ()

@property(strong, nonatomic) NSArray *regions;


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
    [self configureLook];


}



-(NSArray *)regions {

    if (!_regions) {
        _regions = [[NSArray alloc] initWithObjects:@"Costa",@"Sierra",@"Oriente",@"Insular", nil];
    }
    
    return _regions;

}

-(void)configureLook {
    
    [self setTitleColor:@"Region"];
    self.view.backgroundColor = [UIColor lightGrayColor];

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
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"Selecciono: %@", [[self regions] objectAtIndex:indexPath.row]);
    NSString *selected = [self.regions objectAtIndex:indexPath.row];
    ((JSCreateNC *)self.navigationController).region =selected;
    [self.navigationController popViewControllerAnimated:YES];

}



-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;

}


@end
