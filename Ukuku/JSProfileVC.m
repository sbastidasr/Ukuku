//
//  JSProfileVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 06/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSProfileVC.h"
#import "JSAppDelegate.h"
#import "JSEditUserVC.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface JSProfileVC ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UITextView *bioTextView;

- (IBAction)logOutPressed:(id)sender;
- (IBAction)editButtonPressed:(id)sender;
@end

@implementation JSProfileVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      [self loadProfile];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadProfile];
    [self configureNavigationBar];
    
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureNavigationBar {
    
    self.title=@"Perfil";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    
}

-(void)loadProfile {
    
    if ([PFUser currentUser]) 
        [self loadFromParse];
    

}


-(void)loadFromParse {
    
    PFUser *user = [PFUser currentUser];
    NSDictionary *userProfile = user[@"profile"];
    
    self.nameLabel.text = [NSString stringWithFormat:@"    %@", userProfile[@"name"]];
    self.bioTextView.text = userProfile[@"bio"];
    [self downloadProfilePicture];
    


}


-(void)downloadProfilePicture {


    PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
    PFUser *user = [PFUser currentUser];
    [query whereKey:@"user" equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count>0) {
            
            PFObject *imageObject = [objects lastObject];
            PFFile *theImage = [imageObject objectForKey:@"imageFile"];
            
            [theImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                NSData *imageData = data;
                UIImage *image = [UIImage imageWithData:imageData];
                self.pictureImageView.image=image;
            }];
        }
    }];
}

- (void)updateProfileData {
    
    
    NSString *bio = [PFUser currentUser][@"profile"][@"bio"];
    if (bio) {
        self.bioTextView.text = bio;
    }
    // Set the name in the header view label
    NSString *name = [PFUser currentUser][@"profile"][@"name"];
    if (name) {
        self.nameLabel.text = [NSString stringWithFormat:@"     %@", name];
    }
    [self downloadProfilePicture];
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

- (IBAction)logOutPressed:(id)sender {
    
    [PFUser logOut];
    JSAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate userDidLogOut];
}

- (IBAction)editButtonPressed:(id)sender {
    
    [self presentViewController:[[JSEditUserVC alloc] init] animated:YES completion:nil];
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

@end
