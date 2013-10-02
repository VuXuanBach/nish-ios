//
//  MainViewController.h
//  NISH
//
//  Created by Bach Vu on 9/10/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "Cell.h"

@interface MainViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) NSMutableArray *gridImages;

- (IBAction)login:(id)sender;
- (IBAction)registration:(id)sender;
@end
