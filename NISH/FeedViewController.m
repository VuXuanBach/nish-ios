//
//  FeedViewController.m
//  NISH
//
//  Created by Bach Vu on 9/11/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import "FeedViewController.h"

@interface FeedViewController ()

@end

@implementation FeedViewController
@synthesize feedTableView;

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
    
    self.tableFeeds = [[NSMutableArray alloc] init];
    self.feeds = [[NSMutableArray alloc] init];
    
    PFQuery *query = [[PFQuery alloc] initWithClassName:@"Image"];
    [query includeKey:@"user"];
    [query orderByDescending:@"createdAt"];
    
//    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            int position = 0;
            for (PFObject *object in objects) {
                if ([[[object objectForKey:@"user"] objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
                    Feed *feed = [[Feed alloc] init];
                    [self.feeds addObject:feed];
                    [self loadImage:object withPosition:position];
                } else {
                    position--;
                }
                position++;
            }
        }
    }];
}

- (void)loadImage:(PFObject *)object withPosition:(int)position {
    PFFile *file = [object objectForKey:@"imageFile"];
    Feed *currFeed = [self.feeds objectAtIndex:position];
    
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            currFeed.location = [object objectForKey:@"location"];
            currFeed.likes = [object objectForKey:@"like"];
            currFeed.user = [object objectForKey:@"user"];
            currFeed.image = data;
            currFeed.date = [self dateDiff:object];
            currFeed.object = object;
            
            PFUser *user = [object objectForKey:@"user"];
            PFFile *uFile = [user objectForKey:@"avatar"];
            [uFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if (!error) {
                    currFeed.avatar = data;
                    currFeed.username = user.username;
                    
                    [self.tableFeeds addObject:currFeed];
                    [self.feedTableView reloadData];
                }
            }];
        }
    }];
}

- (NSString *)dateDiff:(PFObject *)object {
    NSDate *objDate = [object createdAt];
    NSDate *currDate = [[NSDate alloc] init];
    
    NSTimeInterval diff = [currDate timeIntervalSinceDate:objDate];
    
    if (diff < 0) {
        return [NSString stringWithFormat:@"%i s ago", 0];
    } else if (diff < 60) {
        return [NSString stringWithFormat:@"%i s ago", (int)diff];
    } else if (diff < 60 * 60) {
        return [NSString stringWithFormat:@"%i m ago", (int) diff/60];
    } else if (diff < 60 * 60 * 24) {
        return [NSString stringWithFormat:@"%i h ago", (int) diff/(60*60)];
    } else if (diff < 60 * 60 * 24 *7) {
        return [NSString stringWithFormat:@"%i d ago", (int) diff/(60*60*24)];
    } else if (diff < 60 * 60 * 24 * 7 * 4) {
        return [NSString stringWithFormat:@"%i w ago", (int) diff/(60*60*24*7)];
    } else if (diff < 60 * 60 * 24 * 7 * 4 *12) {
        return [NSString stringWithFormat:@"%i M ago", (int) diff/(60*60*24*7*4)];
    } else {
        return @"More than 1y";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableFeeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Setup cell identifier
    static NSString *cellIdentifier = @"customCell";
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:nil options:nil];
        
        for (id currentObj in topLevelObjects) {
            cell = (CustomCell *) currentObj;
            break;
        }
    }
    NSLog(@"asd");
    
    Feed *feed = [self.tableFeeds objectAtIndex:indexPath.row];
    [cell.ivAvatar setImage:[UIImage imageWithData:feed.avatar]];
    cell.lbUsername.text = feed.username;
    cell.lbCreateAt.text = feed.date;
    cell.lbLocation.text = feed.location;
    [cell.ivMainImage setImage:[UIImage imageWithData:feed.image]];
    
    // Return the cell
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
