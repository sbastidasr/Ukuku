//
//  JSLogInVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 03/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSLogInVC.h"
#import "JSAppDelegate.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>


@interface JSLogInVC ()

@property (weak, nonatomic) IBOutlet UIView *logInView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


- (IBAction)facebookLogInPressed:(id)sender;
- (IBAction)twitterLogInPressed:(id)sender;
- (IBAction)parseLogInPressed:(id)sender;


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
                //[self logInSucceded];
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
#warning Comentado
            //[self logInSucceded];
            NSLog(@"User signed up and logged in with Twitter!");
        } else {
            NSLog(@"User logged in with Twitter!");
        }     
    }];
    
}

- (IBAction)parseLogInPressed:(id)sender {
    
    NSString *email = [[self emailTextField] text];
    NSString *password = [[self passwordTextField] text];
    
    if(email.length !=0 && password.length!=0) {
        
        [PFUser logInWithUsernameInBackground:[self emailTextField].text password:[self passwordTextField].text
                                        block:^(PFUser *user, NSError *error) {
                                            if (user) {
                                                [self logInSucceded];
                                            } else {
                                                UIAlertView *alertError = [[UIAlertView alloc] initWithTitle:@"Credenciales Incorrectas" message:@"Revise su email o contraseña" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                                                [alertError show];
                                                
                                                
                                                NSLog(@"%@", error);
                                            }
                                        }];
    }
    else {
        
        UIAlertView *incomplete = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Los campos no pueden ser vacios" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Reintentar", nil];
        [incomplete show];
        
    }
}

-(void)logInSucceded {

    JSAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate userDidLogIn];

}

    
    
    
@end
