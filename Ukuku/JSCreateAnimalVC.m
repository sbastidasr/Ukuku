//
//  JSCreateAnimalVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 10/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSCreateAnimalVC.h"
#import "JSChooseRegionTVC.h"

@interface JSCreateAnimalVC ()

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

-(void)viewDidAppear:(BOOL)animated {

    [self imprimirOpciones];

}
-(void)imprimirOpciones {
    
    NSLog(@"Opciones");

    NSLog(@"Region: %@", self.region);
    NSLog(@"Risk: %@", self.risk);
    NSLog(@"Type: %@", self.type);

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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"showRegion"]) {
        JSChooseRegionTVC *controller = (JSChooseRegionTVC *)segue.destinationViewController;
    }


}

@end
