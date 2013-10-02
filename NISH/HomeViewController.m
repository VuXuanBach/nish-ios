//
//  HomeViewController.m
//  NISH
//
//  Created by Bach Vu on 9/11/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    [self.navigationController setNavigationBarHidden:YES];
    
    self.cameraTitle = @"Camera";
    
    // Do any additional setup after loading the view from its nib.
    FeedViewController *feedVC = [[FeedViewController alloc] initWithNibName:@"FeedViewController" bundle:nil];
    [feedVC setTitle:@"Feed"];
    UINavigationController *feedNC = [[UINavigationController alloc] initWithRootViewController:feedVC];
    
    ExploreViewController *exploreVC = [[ExploreViewController alloc] initWithNibName:@"ExploreViewController" bundle:nil];
    [exploreVC setTitle:@"Explore"];
    UINavigationController *exploreNC = [[UINavigationController alloc] initWithRootViewController:exploreVC];
    
    UIViewController *cameraVC = [[UIViewController alloc] init];
    [cameraVC setTitle:self.cameraTitle];
    UINavigationController *cameraNC = [[UINavigationController alloc] initWithRootViewController:cameraVC];
    
    FriendViewController *friendVC = [[FriendViewController alloc] initWithNibName:@"FriendViewController" bundle:nil];
    [friendVC setTitle:@"Friend"];
    UINavigationController *friendNC = [[UINavigationController alloc] initWithRootViewController:friendVC];
    
    UserViewController *userVC = [[UserViewController alloc] initWithNibName:@"UserViewController" bundle:nil];
    [userVC setTitle:@"User"];
    UINavigationController *userNC = [[UINavigationController alloc] initWithRootViewController:userVC];
    
    [self setViewControllers:@[feedNC, exploreNC, cameraNC, friendNC, userNC]];
    
    UITabBarItem *item0 = [self.tabBar.items objectAtIndex:0];
    [item0 setFinishedSelectedImage:[UIImage imageNamed:@"ic_home.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"ic_home.png"]];
    
    UITabBarItem *item1 = [self.tabBar.items objectAtIndex:1];
    [item1 setFinishedSelectedImage:[UIImage imageNamed:@"ic_star.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"ic_star.png"]];
    
    UITabBarItem *item2 = [self.tabBar.items objectAtIndex:2];
    [item2 setFinishedSelectedImage:[UIImage imageNamed:@"ic_camera.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"ic_camera.png"]];
    
    UITabBarItem *item3 = [self.tabBar.items objectAtIndex:3];
    [item3 setFinishedSelectedImage:[UIImage imageNamed:@"ic_heart.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"ic_heart.png"]];
    
    UITabBarItem *item4 = [self.tabBar.items objectAtIndex:4];
    [item4 setFinishedSelectedImage:[UIImage imageNamed:@"ic_perinfo.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"ic_perinfo.png"]];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if ([[item title] isEqualToString:self.cameraTitle]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        }
        
        [imagePicker setDelegate:self];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
