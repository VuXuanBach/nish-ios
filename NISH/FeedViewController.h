//
//  FeedViewController.h
//  NISH
//
//  Created by Bach Vu on 9/11/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "CustomCell.h"
#import "Cell.h"
#import "Feed.h"

@interface FeedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *feedTableView;
@property (strong, nonatomic) NSMutableArray *tableFeeds;
@property (strong, nonatomic) NSMutableArray *feeds;

@end
