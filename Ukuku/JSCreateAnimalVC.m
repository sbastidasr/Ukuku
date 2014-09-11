//
//  JSCreateAnimalVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 10/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSCreateAnimalVC.h"
#import "JSChooseTypeTVC.h"
#import "JSCreateNC.h"



@interface JSCreateAnimalVC ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *clasificationSegmented;

@end

@implementation JSCreateAnimalVC

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
    self.title = @"Crear Animal";
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {

    JSCreateNC *nav = (JSCreateNC *)self.navigationController;
    
    NSLog(@"%@", nav.region);
    NSLog(@"%@", nav.risk);
    NSLog(@"%@", nav.type);

}

#pragma mark - Navigation


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"pushType"]) {
        JSChooseTypeTVC *chooseController = segue.destinationViewController;
        chooseController.clasification = self.clasificationSegmented.selectedSegmentIndex;
    }

}

@end
