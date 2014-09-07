//
//  JSEditUserVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 06/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSEditUserVC.h"
#import "UITextField+PlaceHolder.h"
#import "UIImage+Crop.h"
#import <Parse/Parse.h>


typedef NS_ENUM(NSInteger, actionSheetButtons) {
    actionSheetTakePicture = 0, // actionSheet.firstOtherButtonIndex
    actionSheetLibrary,
    actionSheetEditPicture
};

typedef NS_ENUM(NSInteger, ImageStatus) {
    ImageStatusDoNothing = 0,
    ImageStatusPreserveNew,
    ImageStatusDelete
};

@interface JSEditUserVC () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    ImageStatus imageStatus;

}

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *bioTextField;
@property (strong, nonatomic) UIImage *profilePicture;

- (IBAction)savePressed:(id)sender;
- (IBAction)cameraPressed:(id)sender;


@end

@implementation JSEditUserVC

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
    [self configurePlaceHolder];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configurePlaceHolder {
    
    [[self nameTextField] setPlaceholder:@"Nombre Completo" andTextFieldBackgroundColor:[UIColor whiteColor]];
    [[self bioTextField] setPlaceholder:@"Bio" andTextFieldBackgroundColor:[UIColor whiteColor]];
    
}

- (IBAction)savePressed:(id)sender {
    
    [PFUser currentUser];
    
    
    
}

- (IBAction)cameraPressed:(id)sender {
    [self offerImageActions];
}

- (void) offerImageActions {
    NSString *deleteButtonTitle = nil;

    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:deleteButtonTitle
                                  otherButtonTitles:@"Take Photo", @"Choose From Library", nil];
    [actionSheet showInView:self.view];
    
}

#pragma Mark - Action Sheet Delegate

- (void) actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        [self deletePicture];
    } else if (buttonIndex == actionSheet.firstOtherButtonIndex) {
        [self obtainPictureFromCamera:YES];
    } else if (buttonIndex == actionSheet.firstOtherButtonIndex + actionSheetLibrary) {
        [self obtainPictureFromCamera:NO];
    }
}

- (void) obtainPictureFromCamera:(BOOL)useCamera {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if (useCamera &&
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

- (void) deletePicture {
    imageStatus = ImageStatusDelete;
    self.profilePicture = nil;
}

#pragma mark - Image picker view controller delegate

- (void) imagePickerController:(UIImagePickerController *)imagePickerController
 didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.profilePicture = [info [UIImagePickerControllerEditedImage] imageSquaredWithSide:200.0];
    // AgentPicture is not observed, because it changes while this controller is hidden.
    imageStatus = ImageStatusPreserveNew;
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
