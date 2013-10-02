//
//  UserViewController.m
//  NISH
//
//  Created by Bach Vu on 9/11/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

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
    UIBarButtonItem *setButton = [[UIBarButtonItem alloc] initWithTitle:@"Setting" style:UIBarButtonItemStylePlain target:self action:@selector(settingClicked)];
    self.navigationItem.rightBarButtonItem = setButton;
    
    PFUser *currUser = [PFUser currentUser];
    self.lbUsername.text = currUser.username;
    
    [self getAvatar:currUser];
}

- (void) settingClicked {
    [PFUser logOut];
}

- (void) getAvatar:(PFUser*) currUser {
    PFFile *file = [currUser objectForKey:@"avatar"];
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            self.ivAvatar.image = [UIImage imageWithData:data];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
