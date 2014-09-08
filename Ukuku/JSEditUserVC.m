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
    [self loadUserData];
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


-(void)loadUserData {

    PFUser *user = [PFUser currentUser];
    NSDictionary *profile = user[@"profile"];
    
    self.bioTextField.text = profile[@"bio"];
    self.nameTextField.text=profile[@"name"];
    
    
    
}
- (IBAction)savePressed:(id)sender {
    
    NSString *name = [[self nameTextField] text];
    NSString *bio = [[self bioTextField] text];
    PFUser *user = [PFUser currentUser];
    
    NSMutableDictionary *userProfile = user[@"profile"];
    
    [userProfile setValue:name forKey:@"name"];
    [userProfile setValue:bio forKey:@"bio"];
    
    [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
    [[PFUser currentUser] saveInBackground];
    if (self.profilePicture) {
        [self saveImage:self.profilePicture];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

-(void)saveImage:(UIImage *)image {
    
    NSData *data = UIImageJPEGRepresentation(image, 1);
    
    PFQuery *consulta =[PFQuery queryWithClassName:@"UserPhoto"];
    PFUser *user1 = [PFUser currentUser];
    
    [consulta whereKey:@"user" equalTo:user1];
    [consulta findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        NSLog(@"%@", objects);
        NSString *objectID = [[objects lastObject] valueForKey:@"objectId"];
        
        PFObject *object = [PFObject objectWithoutDataWithClassName:@"UserPhoto" objectId:objectID];
        [object deleteEventually];
        
    }];
    
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
    
    // Save PFFile
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            
            PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
            PFUser *user = [PFUser currentUser];
            [query whereKey:@"user" equalTo:user];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                //if (objects) {
                  //  return;
                //}
            }];
            
            
            
            // Create a PFObject around a PFFile and associate it with the current user
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
        else{
            
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    } progressBlock:^(int percentDone) {
        
        
    }];
    
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
    self.profilePicture = [info [UIImagePickerControllerEditedImage] imageSquaredWithSide:500.0];
    // AgentPicture is not observed, because it changes while this controller is hidden.
    imageStatus = ImageStatusPreserveNew;
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end