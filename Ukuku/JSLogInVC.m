//
//  JSLogInVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 03/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSLogInVC.h"


@interface JSLogInVC ()

@property (weak, nonatomic) IBOutlet UIView *logInView;
- (IBAction)facebookLogInTouched:(id)sender;

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

- (IBAction)facebookLogInTouched:(id)sender {
    

}
@end
