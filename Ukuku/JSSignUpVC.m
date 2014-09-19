//
//  JSSignUpVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 06/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSSignUpVC.h"
#import "UITextField+PlaceHolder.h"
#import "UIView+BackGround.h"
#import "MBProgressHUD.h"
#import "JSAppDelegate.h"
#import <Parse/Parse.h>

@interface JSSignUpVC ()


- (IBAction)createPressed:(id)sender;



@property (weak, nonatomic) IBOutlet UIView *sigUpView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation JSSignUpVC

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
    [self.view setBackgroundWithImageNamed:@"background3.png"];
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
        CGPoint newCenter = CGPointMake(self.sigUpView.center.x, self.sigUpView.center.y-210);
        self.sigUpView.center = newCenter;
    }];
    
}


- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSLog(@"Keyboard disapeer");
    
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint newCenter = CGPointMake(self.sigUpView.center.x, self.sigUpView.center.y+190);
        self.sigUpView.center = newCenter;
    }];
}


-(void)configurePlaceHolder {
    
    [[self nameTextField] setPlaceholder:@"Nombre Completo" andTextFieldBackgroundColor:[UIColor whiteColor]];
    [[self emailTextField] setPlaceholder:@"Email" andTextFieldBackgroundColor:[UIColor whiteColor]];
    [[self passwordTextField] setPlaceholder:@"Contraseña" andTextFieldBackgroundColor:[UIColor whiteColor]];
    
}

- (IBAction)createPressed:(id)sender {
#warning Checkear que los campos no sean nulos
    PFUser *user = [PFUser user];
    user.username = [[self nameTextField] text];
    user.password = [[self passwordTextField] text];
    user.email = [[self emailTextField] text];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            [self logInSucceded];
            [[PFUser currentUser] setObject:@{@"name":user.username} forKey:@"profile"];
            [[PFUser currentUser] saveInBackground];
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"%@",errorString);
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Revisa los datos" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
            [self.passwordTextField resignFirstResponder];
        }
    }];
    
}

-(void)logInSucceded {
    
    JSAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate userDidLogIn];
    
}
@end
