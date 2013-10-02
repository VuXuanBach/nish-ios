//
//  User.m
//  NISH
//
//  Created by Bach Vu on 9/19/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import "User.h"

@implementation User

- (id) init {
    self = [super init];
    if (!self) {
        self.avatar = [[NSData alloc] init];
        self.username = @"";
        self.phoneNumber = @"";
    }
    return self;
}

- (id) initWithUser:(NSData *)avatar withUsername:(NSString *)username withPhoneNumber:(NSString *)phoneNumber {
    self = [super init];
    if (!self) {
        self.avatar = avatar;
        self.username = username;
        self.phoneNumber = phoneNumber;
    }
    return self;
}

@end
