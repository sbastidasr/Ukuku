//
//  JSChooseTypeTVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 10/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSChooseTypeTVC.h"
#import "JSCreateNC.h"
#import "UITableViewController+TitleColor.h"


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
    [self configureLook];
    [self loadTypes];

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
    
    
    NSString *pathPlist = [[NSBundle mainBundle] pathForResource:@"categoryFauna" ofType:@"plist"];
    
    _types = [[NSArray alloc] initWithContentsOfFile:pathPlist];

}

-(void)loadFloraTypes {
    
    
    
    NSString *pathPlist = [[NSBundle mainBundle] pathForResource:@"categoryFlora" ofType:@"plist"];
    
    _types = [[NSArray alloc] initWithContentsOfFile:pathPlist];
}


-(void)configureLook {
    
    [self setTitleColor:@"Tipo"];
    self.view.backgroundColor = [UIColor clearColor];
    
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
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Selecciono: %@", [[self types] objectAtIndex:indexPath.row]);
    NSString *selected = [self.types objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    ((JSCreateNC *)self.navigationController).type =selected;
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
