//
//  Util.h
//  NISH
//
//  Created by Bach Vu on 9/9/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

+ (void)showAlertDialog:(NSString *)title withMessage:(NSString *)message;
+ (UIAlertView *)getConfirmDialog:(NSString *)title withMessage:(NSString *)message;

@end
