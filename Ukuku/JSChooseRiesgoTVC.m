//
//  JSRiesgoTVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 10/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSChooseRiesgoTVC.h"
#include "JSCreateNC.h"
#import "UITableViewController+TitleColor.h"



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
    [self configureLook];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)risk {

    if (!_risk) {
        
        NSString *pathPlist = [[NSBundle mainBundle] pathForResource:@"categoryRisks" ofType:@"plist"];
        _risk = [[NSArray alloc] initWithContentsOfFile:pathPlist];
    }
    
    return _risk;

}

-(void)configureLook {

    [self setTitleColor:@"Riesgo"];
    self.view.backgroundColor = [UIColor clearColor];

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
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Selecciono: %@", [[self risk] objectAtIndex:indexPath.row]);
    NSString *selected = [self.risk objectAtIndex:indexPath.row];
    ((JSCreateNC *)self.navigationController).risk =selected;
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
