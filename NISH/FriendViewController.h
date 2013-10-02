//
//  FriendViewController.h
//  NISH
//
//  Created by Bach Vu on 9/11/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "FriendsCell.h"
#import "User.h"
#import "Util.h"

@interface FriendViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *users;
@property (weak, nonatomic) IBOutlet UITableView *friendTableView;
@property (strong, nonatomic) FriendsCell *friendCell;

@end
