//
//  FriendViewController.m
//  NISH
//
//  Created by Bach Vu on 9/11/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import "FriendViewController.h"

@interface FriendViewController ()

@end

@implementation FriendViewController

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
    [Parse setApplicationId:@"PhPbACGcB2vstnumIcUX1D1WrOzabqFPognqfufu"
                  clientKey:@"K5fWoItwvDbFXXPyYL11J3t4thAW3YQw3oUyeS7P"];
        
    UISegmentedControl *statFilter = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Friends", @"Pending", nil]];
    [statFilter setSegmentedControlStyle:UISegmentedControlStyleBar];
    
    self.navigationItem.titleView = statFilter;
    
    [statFilter addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self loadUsers:YES];
    
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.friendTableView setEditing:editing animated:animated];
    
    if (editing) {
    } else {
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (BOOL)tableView:(UITableView *)tableview canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)loadUsers:(BOOL)isFriends {
    self.users = [[NSMutableArray alloc] init];
    PFUser *currUser = [PFUser currentUser];

    for (int i = 0; i < 2; i++) {
        PFQuery *query = [[PFQuery alloc] initWithClassName:isFriends ? @"Friend" : @"Pending"];
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
                    u.username = user.username;
                    u.phoneNumber = [user objectForKey:@"phone"];
                    
                    PFFile *file = [user objectForKey:@"avatar"];
                    if (file == nil) {
                        UIImage *img = [UIImage imageNamed:@"default_avatar.jpg"];
                        NSData *dataImg = UIImageJPEGRepresentation(img, 90);
                        u.avatar = dataImg;
                        [self.users addObject:u];
                        [self.friendTableView reloadData];
                    }
                    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        if (!error) {
                            u.avatar = data;
                            [self.users addObject:u];
                            [self.friendTableView reloadData];
                        }
                    }];
                }
            }
        }];
    }
}

- (void)valueChanged:(UISegmentedControl *)statFilter {
    if (statFilter.selectedSegmentIndex == 0) {
        [self loadUsers:YES];
    } else {
        [self loadUsers:NO];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Setup cell identifier
    static NSString *cellIdentifier = @"friendsCell";
    FriendsCell *cell = (FriendsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FriendsCell" owner:nil options:nil];
        
        for (id currentObj in topLevelObjects) {
            cell = (FriendsCell *) currentObj;
            break;
        }
    }
    
    User *user = [self.users objectAtIndex:indexPath.row];
    cell.ivAvatar.image = [UIImage imageWithData:user.avatar];
    cell.lbUsername.text = user.username;
    cell.user = user;
    
    // Return the cell
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
