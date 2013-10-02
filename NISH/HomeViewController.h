//
//  HomeViewController.h
//  NISH
//
//  Created by Bach Vu on 9/11/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedViewController.h"
#import "FriendViewController.h"
#import "UserViewController.h"
#import "ExploreViewController.h"

@interface HomeViewController : UITabBarController <UITabBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSString *cameraTitle;

@end
