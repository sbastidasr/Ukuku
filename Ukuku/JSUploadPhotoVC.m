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


@interface JSUploadPhotoVC () <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *animalNameTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *categorySegmented;

- (IBAction)speciePressed:(id)sender;
- (IBAction)cameraPressed:(id)sender;
- (IBAction)savePressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
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
    [self.view setBackgroundWithImageNamed:@"background2.png"];

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
    
    [self offerImageActions];
}

- (IBAction)savePressed:(id)sender {
    [self uploadData];
    
}

- (IBAction)backButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)uploadData {

    NSData *imageData = UIImageJPEGRepresentation(self.photoTaked, 1);
    NSString *imageName = [NSString stringWithFormat:@"image_%@", [self.animalNameTextField text]];
    PFFile *imageFile = [PFFile fileWithName:imageName data:imageData];
    
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:self.photoCoordinate.latitude longitude:self.photoCoordinate.longitude];
    
    PFObject *photoLocation = [PFObject objectWithClassName:@"PhotoLocation"];
    photoLocation[@"location"] = geoPoint;
    photoLocation[@"imageFile"] = imageFile;
    photoLocation[@"user"] = [PFUser currentUser];
    photoLocation[@"specie"]=self.selectSpecie;
    photoLocation[@"titulo"]= self.animalNameTextField.text;
    photoLocation[@"comentario"]=self.descriptionTextView.text;

    
    [photoLocation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!succeeded) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Existio un error al enviar los datos. Intente de nuevo" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
        }
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}



#pragma Mark - Action Sheet Delegate

- (void) actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.firstOtherButtonIndex) {
        [self obtainPictureFromCamera:YES];
    } else {
        [self obtainPictureFromCamera:NO];
    }
}


- (void) offerImageActions {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"COmida 💩"
                                  destructiveButtonTitle:@"Destruir"
                                  otherButtonTitles:@"Tomar Foto", @"Escoger de Galeria", nil];
    [actionSheet showInView:self.view];
    
}

- (void) obtainPictureFromCamera:(BOOL)useCamera {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if (useCamera &&
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}


#pragma mark - Image picker view controller delegate

- (void) imagePickerController:(UIImagePickerController *)imagePickerController
 didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.photoTaked = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#warning Revisar en dispositivo
-(void)actionSheetCancel:(UIActionSheet *)actionSheet {

    [self dismissViewControllerAnimated:YES completion:nil];
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
