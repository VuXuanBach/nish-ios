//
//  FriendsCell.h
//  NISH
//
//  Created by Bach Vu on 9/19/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import <Parse/Parse.h>
#import "Util.h"

@interface FriendsCell : UITableViewCell <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *ivAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lbUsername;
@property (weak, nonatomic) IBOutlet UIButton *btnPhone;
@property (weak, nonatomic) IBOutlet UIButton *btnRemove;

@property (strong, nonatomic) User *user;

- (IBAction)phoneClick:(id)sender;
- (IBAction)removeClick:(id)sender;

@end
