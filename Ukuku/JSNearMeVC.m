//
//  JSNearMeVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 17/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSNearMeVC.h"

@interface JSNearMeVC ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation JSNearMeVC

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
    [self configureLook];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)configureLook {

    [self configureNavigationBar];

}

-(void)configureNavigationBar {
    
    
    
}

-(void)backButtonPressed:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];

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
