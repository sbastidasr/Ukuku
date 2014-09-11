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
#import "UIView+BackGround.h"
#import "UITextField+PlaceHolder.h"



@interface JSCreateAnimalVC ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *clasificationSegmented;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (weak, nonatomic) IBOutlet UITableViewCell *regionCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *riskCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *typeCell;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *cientificNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

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
    [self configureViewLook];
    
    
    
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

-(void)configureViewLook {
    
    [self configureCells];
    [self configureTextFields];
    [self configureTextView];
    [self configureScroller];
    [self configureNavigationBar];
    
    [self.view setBackgroundWithImaheNamed:@"backGroundLogIn@2x.png"];
    


}

-(void)configureCells {

    [self.regionCell.contentView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.regionCell.contentView.layer setBorderWidth:1.5f];
    
    [self.riskCell.contentView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.riskCell.contentView.layer setBorderWidth:1.5f];
    
    [self.typeCell.contentView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.typeCell.contentView.layer setBorderWidth:1.5f];
    

}


-(void)configureTextFields {
    
    [self.nameTextField setPlaceholder:@"  Nombre" andTextFieldBackgroundColor:[UIColor whiteColor]];
    [self.cientificNameTextField setPlaceholder:@"  Nombre Cientifico" andTextFieldBackgroundColor:[UIColor whiteColor]];

    

}


-(void)configureTextView {

    [self.descriptionTextView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.descriptionTextView.layer setBorderWidth:1.5f];

}

-(void)configureScroller {
    
    [self.scroller setScrollEnabled:YES];
    [self.scroller setContentSize:CGSizeMake(320, 680)];

}

-(void)configureNavigationBar {
    
    self.title=@"Crear Animal";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    
}

#pragma mark - Navigation


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"pushType"]) {
        JSChooseTypeTVC *chooseController = segue.destinationViewController;
        chooseController.clasification = self.clasificationSegmented.selectedSegmentIndex;
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
        titleView.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        
        titleView.textColor = [UIColor whiteColor];
        
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}

@end
