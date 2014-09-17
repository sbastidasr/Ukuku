//
//  JSUploadPhotoVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 16/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSUploadPhotoVC.h"
#import "JSChooseSpecieTVC.h"
#import "UIView+BackGround.h"
#import "UITextField+PlaceHolder.h"


@interface JSUploadPhotoVC () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *animalNameTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *categorySegmented;

- (IBAction)speciePressed:(id)sender;
- (IBAction)cameraPressed:(id)sender;
- (IBAction)savePressed:(id)sender;
@end

@implementation JSUploadPhotoVC

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
    [self configureLook];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureLook {

    self.title = @"Upload";
    [self configureTextView];
    [self.animalNameTextField setPlaceholder:@"  Name" andTextFieldBackgroundColor:[UIColor whiteColor]];
    
    [self.view setBackgroundWithImageNamed:@"backGroundLogIn@2x.png"];

}

-(void)configureTextView {
    
    self.descriptionTextView.text = @"Descripcion";
    [self.descriptionTextView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.descriptionTextView.layer setBorderWidth:1.5f];
    self.descriptionTextView.delegate = self;
    
    
}


#pragma mark - UITextViewDelegate Methods

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Descripcion"]) {
        textView.text = @"";
        textView.textColor = [UIColor whiteColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Descripcion";
        textView.textColor = [UIColor whiteColor]; //optional
    }
    [textView resignFirstResponder];
}


- (IBAction)speciePressed:(id)sender {
    
    [self.descriptionTextView endEditing:YES];
    
    JSChooseSpecieTVC *chooseVC = [[JSChooseSpecieTVC alloc] init];
    chooseVC.classification =  [self.categorySegmented titleForSegmentAtIndex:self.categorySegmented.selectedSegmentIndex];
    UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:chooseVC];
     
    
    
    
    [chooseVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:navCon animated:YES completion:nil];

}

- (IBAction)cameraPressed:(id)sender {
}

- (IBAction)savePressed:(id)sender {
    [self uploadData];
    
}

-(void)backPressed {

}

-(void)uploadData {

    NSData *imageData = UIImageJPEGRepresentation(self.photoTaked, 1);
    NSString *imageName = [NSString stringWithFormat:@"%@_%@", [self.animalNameTextField text], [PFUser currentUser][@"username"]];
    PFFile *imageFile = [PFFile fileWithName:imageName data:imageData];
    
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:self.photoCoordinate.latitude longitude:self.photoCoordinate.longitude];
    
    PFObject *photoLocation = [PFObject objectWithClassName:@"PhotoLocation"];
    photoLocation[@"location"] = geoPoint;
    photoLocation[@"imageFile"] = imageFile;
    photoLocation[@"user"] = [PFUser currentUser];
    //photoLocation[@"specie"]=;
    photoLocation[@"titulo"]= self.animalNameTextField.text;
    photoLocation[@"comentario"]=self.descriptionTextView.text;

    
    [photoLocation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!succeeded) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Existio un error al enviar los datos. Intente de nuevo" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
        }
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
