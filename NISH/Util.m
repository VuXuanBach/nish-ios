//
//  Util.m
//  NISH
//
//  Created by Bach Vu on 9/9/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (void)showAlertDialog:(NSString *)title withMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

+ (UIAlertView *)getConfirmDialog:(NSString *)title withMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:title];
    [alert setMessage:message];
    [alert addButtonWithTitle:@"Yes"];
    [alert addButtonWithTitle:@"No"];
    
    return alert;
}

@end
