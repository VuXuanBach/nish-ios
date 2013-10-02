//
//  Feed.h
//  NISH
//
//  Created by Bach Vu on 9/19/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Feed : NSObject

@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) NSData *avatar;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSMutableArray *likes;
@property (strong, nonatomic) NSData *image;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) PFObject *object;

@end
