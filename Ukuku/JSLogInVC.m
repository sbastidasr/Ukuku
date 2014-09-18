//
//  JSLogInVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 03/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSLogInVC.h"
#import "JSAppDelegate.h"
#import "UITextField+PlaceHolder.h"
#import "UIView+BackGround.h"
#import "JSSignUpVC.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>


@interface JSLogInVC ()

@property (weak, nonatomic) IBOutlet UIView *logInView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;



- (IBAction)facebookLogInPressed:(id)sender;
- (IBAction)twitterLogInPressed:(id)sender;
- (IBAction)parseLogInPressed:(id)sender;
- (IBAction)createAccountPressed:(id)sender;



@end

@implementation JSLogInVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self registerForKeyboardNotifications];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configurePlaceHolder];
    [self.view setBackgroundWithImageNamed:@"backGroundLogIn@2x"];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
    NSLog(@"Keyboard show");
    
    [UIView animateWithDuration:0.5 animations:^{
        CGPoint newCenter = CGPointMake(self.logInView.center.x, self.logInView.center.y-190);
        self.logInView.center = newCenter;
    }];
    
}


- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSLog(@"Keyboard disapeer");
    
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint newCenter = CGPointMake(self.logInView.center.x, self.logInView.center.y+190);
        self.logInView.center = newCenter;
    }];
}

-(void)configurePlaceHolder {
    
    [[self emailTextField] setPlaceholder:@"Email" andTextFieldBackgroundColor:[UIColor whiteColor]];
    [[self passwordTextField] setPlaceholder:@"Contraseña" andTextFieldBackgroundColor:[UIColor whiteColor]];

}

- (IBAction)facebookLogInPressed:(id)sender {
    
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        //[_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            NSString *errorMessage = nil;
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                errorMessage = @"Uh oh. The user cancelled the Facebook login.";
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                errorMessage = [error localizedDescription];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error"
                                                            message:errorMessage
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Dismiss", nil];
            [alert show];
        } else {
            if (user.isNew) {
                [self logInSucceded];
                NSLog(@"User with facebook signed up and logged in!");
            } else {
                [self logInSucceded];
                NSLog(@"User with facebook logged in!");
            }
            //[self _presentUserDetailsViewControllerAnimated:YES];
        }
    }];
    
    //[_activityIndicator startAnimating]; // Show loading indicator until login is finished
    
    
    

}

- (IBAction)twitterLogInPressed:(id)sender {
    
    [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Twitter login.");
            return;
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in with Twitter!");
            [self logInSucceded];
        } else {
            [self logInSucceded];
            NSLog(@"User logged in with Twitter!");
        }     
    }];
    
}

- (IBAction)parseLogInPressed:(id)sender {
#warning Checkear que los cmapos no sean nulos
    PFQuery *query = [PFUser query];
    
    [query whereKey:@"email" equalTo:[[self emailTextField] text]];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(objects.count>0) {
       
            PFObject *object = [objects objectAtIndex:0];
            NSString *username = [object objectForKey:@"username"];
            
            [PFUser logInWithUsernameInBackground:username password:[[self passwordTextField] text] block:
            ^(PFUser *user, NSError *error) {
                
                if (user) {
                    [self logInSucceded];
                } else {
                    UIAlertView *alertError = [[UIAlertView alloc] initWithTitle:@"Credenciales Incorrectas" message:@"Revise su email o contraseña" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                    [alertError show];
                    
                    
                    NSLog(@"%@", error);
                }
           
            }];
        }
    }];
    
}

- (IBAction)createAccountPressed:(id)sender {
    
    JSSignUpVC *signUpController = [[JSSignUpVC alloc] initWithNibName:@"JSSignUpVC" bundle:nil];
    [self presentViewController:signUpController animated:YES completion:nil];
}

-(void)logInSucceded {

    JSAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate userDidLogIn];
    [self saveToParse];

}


-(void)saveToParse {
    
    //[[PFUser currentUser] setObject:@NO forKey:@"admin"];
    //[[PFUser currentUser] saveInBackground];
    

    if([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
    
        [self saveFromFacebook];
    }
    if ([PFUser currentUser] && [PFTwitterUtils isLinkedWithUser:[PFUser currentUser]]) {
        
        [self saveFromTwitter];
    }

}

-(void)saveFromFacebook {
    
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
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
            
            [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
            [[PFUser currentUser] saveInBackground];
            
            [self saveImageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]]]];
            
        } else if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"]
                    isEqualToString: @"OAuthException"]) {
            NSLog(@"The facebook session was invalidated");

        } else {
            NSLog(@"Some other error: %@", error);
        }
    }];
    
    
}

-(void)saveFromTwitter {
    
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
        
        
        [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
        [[PFUser currentUser] saveInBackground];
        [self saveImageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profileTwitterPicture]]];
    }
    
}

-(void)saveImageWithData:(NSData *)imageData {
    
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];

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
@end
