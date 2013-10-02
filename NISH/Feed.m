//
//  Feed.m
//  NISH
//
//  Created by Bach Vu on 9/19/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import "Feed.h"

@implementation Feed

- (id) init {
    self = [super init];
    if (!self) {
        self.user = [[PFUser alloc] init];
        self.avatar = [[NSData alloc] init];
        self.username = @"";
        self.likes = [[NSMutableArray alloc] init];
        self.image = [[NSData alloc] init];
        self.date = @"";
        self.location = @"";
        self.object = nil;
    }
    return self;
}

- (id) initWithUser:(PFUser *)user withAvatar:(NSData *)avatar withUsername:(NSString *)username withLike:(NSMutableArray *)likes withImage:(NSData *)image withDate:(NSString *)date withLocation:(NSString *)location withObject:(PFObject *)object {
    self = [super init];
    if (!self) {
        self.user = user;
        self.avatar = avatar;
        self.username = username;
        self.likes = likes;
        self.image = image;
        self.date = date;
        self.location = location;
        self.object = object;
    }
    return self;
}

@end
