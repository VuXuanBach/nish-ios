//
//  RegisterViewController.m
//  NISH
//
//  Created by Bach Vu on 9/13/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize txtEmail, txtUsername, txtPassword, txtPhone, ivAvatar, btnRegister, scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    self.hasAvatar = NO;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.txtEmail.delegate = self;
    self.txtUsername.delegate = self;
    self.txtPassword.delegate = self;
    self.txtPhone.delegate = self;
    [self registerForKeyboardNotifications];
    
    self.strRemoveAvatar = @"Remove current avatar";
    self.strTakeCamera = @"Take from camera";
    self.strSelectGallery = @"Select from gallery";
    
    [self.ivAvatar setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    [self.ivAvatar addGestureRecognizer:tap];
}

- (void) imageTapped:(UIImageView *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Select Image"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:self.strRemoveAvatar, self.strTakeCamera, self.strSelectGallery, nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if  ([buttonTitle isEqualToString:self.strRemoveAvatar]) {
        UIImage *defaultAvatar = [UIImage imageNamed:@"default_avatar.jpg"];
        [self.ivAvatar setImage:defaultAvatar];
        
        self.hasAvatar = NO;
        
    } else if ([buttonTitle isEqualToString:self.strTakeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        }
        
        [imagePicker setDelegate:self];
        [self presentViewController:imagePicker animated:YES completion:nil];
        
        self.hasAvatar = YES;
        
    } else if ([buttonTitle isEqualToString:self.strSelectGallery]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        [imagePicker setDelegate:self];
        [self presentViewController:imagePicker animated:YES completion:nil];
        
        self.hasAvatar = YES;
    }
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.ivAvatar setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registration:(id)sender {
    if (self.txtEmail.text.length == 0) {
        [Util showAlertDialog:@"Error" withMessage:@"Please fill email"];
    } else if (self.txtUsername.text.length == 0) {
        [Util showAlertDialog:@"Error" withMessage:@"Please fill username"];
    } else if (self.txtPassword.text.length == 0) {
        [Util showAlertDialog:@"Error" withMessage:@"Please fill password"];
    } else {
        PFUser *user = [[PFUser alloc] init];
        
        user.username = txtUsername.text;
        user.password = txtPassword.text;
        user.email = txtEmail.text;
        [user setObject:txtPhone.text forKey:@"phone"];
        [user setObject:[NSNumber numberWithBool:NO] forKey:@"locationPrivacy"];
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                [self uploadAvatar:user];
            } else {
                [Util showAlertDialog:@"Error" withMessage:@"An error occurred! Please try again!"];
            }
        }];
    }
}

- (void) uploadAvatar:(PFUser*)pfu {
    NSData *imageData = UIImagePNGRepresentation([self.ivAvatar image]);
    PFFile *pfFile = [PFFile fileWithName:@"avatar.jpg" data:imageData];
    [pfFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [pfu setObject:pfFile forKey:@"avatar"];
            [pfu saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    [PFUser logInWithUsernameInBackground:pfu.username password:pfu.password block:^(PFUser *user, NSError *error) {
                        if (!error) {
                            HomeViewController *homeVC = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
                            [self.navigationController pushViewController:homeVC animated:YES];
                        }
                    }];
                }
            }];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.activeField resignFirstResponder];
    
    return YES;
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    
    self.scrollView.contentInset = contentInsets;
    
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    
    // Your application might not need or want this behavior.
    
    CGRect aRect = self.view.frame;
    
    aRect.size.height -= kbSize.height;
    
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.activeField.frame.origin.y-kbSize.height);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}
@end
