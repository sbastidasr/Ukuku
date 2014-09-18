//
//  SBSpeciesDetailVC.m
//  Ukuku
//
//  Created by Sebastian Bastidas on 9/16/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "SBSpeciesDetailVC.h"

@interface SBSpeciesDetailVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIImageView *speciesDetailImage;
@property (weak, nonatomic) IBOutlet UILabel *speciesDetailName;
@property (weak, nonatomic) IBOutlet UILabel *speciesDetailTipo;
@property (weak, nonatomic) IBOutlet UILabel *speciesDetailNombCient;
@property (weak, nonatomic) IBOutlet UILabel *speciesDetailStatus;
@property (weak, nonatomic) IBOutlet UILabel *speciesDetailRegion;
@property (weak, nonatomic) IBOutlet UITextView *speciesDetailDescription;


@end

@implementation SBSpeciesDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.scroll setScrollEnabled:YES];
    [self.scroll setContentSize:CGSizeMake(320, 835)];
    [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:self.speciesDetailImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.scroll attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0]];
    [self.scroll addConstraint:[NSLayoutConstraint constraintWithItem:self.speciesDetailImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.scroll attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0]];
    self.speciesDetailName.text = self.species[@"Nombre"];
    self.speciesDetailTipo.text = self.species[@"Tipo"];
    self.speciesDetailNombCient.text = self.species[@"NombreLatin"];
    self.speciesDetailStatus.text = self.species[@"Status"];
    self.speciesDetailRegion.text = self.species[@"Region"];
    self.speciesDetailDescription.text = self.species[@"Descripcion"];
    
    
    PFFile *theImage = self.species[@"foto"];
    [theImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        NSData *imageData = data;
        UIImage *image = [UIImage imageWithData:imageData];
        self.speciesDetailImage.image=image;
    }];
    
    //PFFile *thumbnail = self.species[@"foto"];
    //self.speciesDetailImage.image=[UIImage imageNamed:@"placeholder.jpg"];
    //self.speciesDetailImage.image = thumbnail;
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
