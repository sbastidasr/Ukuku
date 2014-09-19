//
//  JSExplorarVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 10/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSExplorarVC.h"
#import "JSAppDelegate.h"
#import <Parse/Parse.h>
#import "UIView+BackGround.h"
#import "SBExploreTypeTVC.h"

@interface JSExplorarVC ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *createSpecieButton;

@end

@implementation JSExplorarVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    [self isCientific];
    [self.view setBackgroundWithImageNamed:@"background4.png"];
    [self.navigationController.view setBackgroundWithImageNamed:@"background.png"];;


}

-(void)configureNavigationBar {
    
    self.title=@"Explorar";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
}

-(void)isCientific {

    BOOL isCientific = [[NSUserDefaults standardUserDefaults] boolForKey:@"Cientific"];
    
    if (!isCientific) {
        [self.navigationItem setRightBarButtonItem:nil];
    }

}


#pragma Mark - OverrideMethods

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont boldSystemFontOfSize:20.0];
        titleView.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    SBExploreTypeTVC *typeTVC;
   typeTVC=(SBExploreTypeTVC *)segue.destinationViewController;
  
    if([segue.identifier isEqualToString:@"pushFlora"])
    {
     
        typeTVC.clasification=@"Flora";
    }
    
    if([segue.identifier isEqualToString:@"pushFauna"])
    {
  
       typeTVC.clasification=@"Fauna";
    }
    
}



@end
