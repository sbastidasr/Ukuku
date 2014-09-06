//
//  JSSignUpVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 06/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSSignUpVC.h"
#import "UITextField+PlaceHolder.h"

@interface JSSignUpVC ()


- (IBAction)createPressed:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation JSSignUpVC

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configurePlaceHolder {
    
    [[self emailTextField] setPlaceholder:@"Email" andTextFieldBackgroundColor:[UIColor whiteColor]];
    [[self passwordTextField] setPlaceholder:@"Contraseña" andTextFieldBackgroundColor:[UIColor whiteColor]];
    
}

- (IBAction)createPressed:(id)sender {
}
@end
