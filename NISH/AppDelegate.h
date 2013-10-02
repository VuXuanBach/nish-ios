//
//  AppDelegate.h
//  NISH
//
//  Created by Bach Vu on 9/6/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "HomeViewController.h"
#import <Parse/Parse.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navC;
@property (strong, nonatomic) MainViewController *mainVC;

@end
