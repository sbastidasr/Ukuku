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
    self.title=@"Perfil";
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureNavigationBar {
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    
}

-(void)loadProfile {
    
        if([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
            
            [self loadFromFacebook];
        }
        if([PFTwitterUtils isLinkedWithUser:[PFUser currentUser]]) {
            
            [self loadFromTwitter];
            
        }
    if ([PFUser currentUser]) {
        [self loadFromParse];
    }

}


-(void)loadFromParse {
    
    PFUser *user = [PFUser currentUser];
    user[@"profile"];
    


}
-(void)loadFromFacebook {

    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        // handle response
        if (!error) {
            // Parse the data received
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            
            
            NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:4];
            
            if (facebookID) {
                userProfile[@"facebookId"] = facebookID;
            }
            
            NSString *name = userData[@"name"];
            if (name) {
                userProfile[@"name"] = name;
            }
            
            NSString *location = userData[@"location"][@"name"];
            if (location) {
                userProfile[@"location"] = location;
            }
        
            NSString *bio = userData[@"bio"];
            if(bio) {
            
                userProfile[@"bio"] = bio;
            }
            
            
            [self saveImageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]]]];
            
            [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
            [[PFUser currentUser] saveInBackground];
            
            [self updateProfileData];
        } else if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"]
                    isEqualToString: @"OAuthException"]) { // Since the request failed, we can check if it was due to an invalid session
            NSLog(@"The facebook session was invalidated");
            //[self logoutButtonAction:nil];
        } else {
            NSLog(@"Some other error: %@", error);
        }
    }];


}

-(void)loadFromTwitter {
    
    NSURL *verify = [NSURL URLWithString:@"https://api.twitter.com/1.1/account/verify_credentials.json"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:verify];
    [[PFTwitterUtils twitter] signRequest:request];
    NSURLResponse *response = nil;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    
    if(!error) {
        
        NSDictionary *userData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:3];
        
        NSString *twitterID = userData[@"id"];
        
        if (twitterID) {
            userProfile[@"twitterID"] = twitterID;
        }
        
        NSString *name = userData[@"name"];
        if (name) {
            userProfile[@"name"] = name;
        }
        
        NSString *location = userData[@"location"];
        if (location) {
            userProfile[@"location"] = location;
        }
        
        NSString *bio = userData[@"description"];
        if(bio) {
            
            userProfile[@"bio"] = bio;
        }
        
        
        NSString *profileTwitterPicture = [userData[@"profile_image_url"] stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
        
        [self saveImageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profileTwitterPicture]]];
        
        [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
        [[PFUser currentUser] saveInBackground];
        [self updateProfileData];
        
        
    }
    
}

-(void)saveImageWithData:(NSData *)imageData {
    
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];

    // Save PFFile
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            
            PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
            PFUser *user = [PFUser currentUser];
            [query whereKey:@"user" equalTo:user];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (objects.count>0) {
                    return;
                } else {
                    
                    PFObject *userPhoto = [PFObject objectWithClassName:@"UserPhoto"];
                    [userPhoto setObject:imageFile forKey:@"imageFile"];
                    
                    // Set the access control list to current user for security purposes
                    userPhoto.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
                    
                    [userPhoto setObject:user forKey:@"user"];
                    
                    [userPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (!error) {
                            
                        }
                        else{
                            NSLog(@"Error: %@ %@", error, [error userInfo]);
                        }
                    }];
                }
            }];
            
        }
        else{
            
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    } progressBlock:^(int percentDone) {
    }];

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
        titleView.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        
        titleView.textColor = [UIColor whiteColor];
        
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}

@end
