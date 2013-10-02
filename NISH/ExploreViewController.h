//
//  ExploreViewController.h
//  NISH
//
//  Created by Bach Vu on 9/11/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Cell.h"

@interface ExploreViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *exploreCollectionView;
@property (strong, nonatomic) NSMutableArray *gridImages;

@end
