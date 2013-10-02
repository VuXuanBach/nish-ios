//
//  RegisterViewController.h
//  NISH
//
//  Created by Bach Vu on 9/13/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import <Parse/Parse.h>
#import "HomeViewController.h"

@interface RegisterViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UIImageView *ivAvatar;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UITextField *activeField;
@property (nonatomic, assign) BOOL hasAvatar;
@property (strong, nonatomic) NSString *strRemoveAvatar;
@property (strong, nonatomic) NSString *strTakeCamera;
@property (strong, nonatomic) NSString *strSelectGallery;

- (IBAction)registration:(id)sender;
@end
