//
//  FriendsCell.m
//  NISH
//
//  Created by Bach Vu on 9/19/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import "FriendsCell.h"

@implementation FriendsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"FriendsCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)phoneClick:(id)sender {
    if(self.user) {
        NSString *phoneNumber = [@"tel:" stringByAppendingString:self.user.phoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
}

- (IBAction)removeClick:(id)sender {
    if(self.user) {
        UIAlertView *alertView = [Util getConfirmDialog:@"Remove" withMessage: [NSString stringWithFormat:@"Are you sure you want to remove %@ ?", self.user.username]];
        [alertView setDelegate:self];
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // ok = 0, cancel = 1
    if (buttonIndex == 0) {
        PFUser *currUser = [PFUser currentUser];
        for (int i = 0; i < 2; i++) {
            PFQuery *query = [[PFQuery alloc] initWithClassName:@"Friend"];
            [query includeKey:@"user1"];
            [query includeKey:@"user2"];
        
            if (i == 0) {
                [query whereKey:@"user1" equalTo:currUser];
            } else {
                [query whereKey:@"user2" equalTo:currUser];
            }
        
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    for (PFObject *object in objects) {
                        PFUser *user = [[PFUser alloc] init];
                        if (i == 0) {
                            user = [object objectForKey:@"user2"];
                        } else {
                            user = [object objectForKey:@"user1"];
                        }
                    
                        User *u = [[User alloc] init];
                        
                    }
                }
            }];
        }
    }
}

@end
