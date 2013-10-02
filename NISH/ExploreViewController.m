//
//  ExploreViewController.m
//  NISH
//
//  Created by Bach Vu on 9/11/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import "ExploreViewController.h"

@interface ExploreViewController ()

@end

@implementation ExploreViewController

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
    [Parse setApplicationId:@"PhPbACGcB2vstnumIcUX1D1WrOzabqFPognqfufu"
                  clientKey:@"K5fWoItwvDbFXXPyYL11J3t4thAW3YQw3oUyeS7P"];
        
    [self.exploreCollectionView registerClass:[Cell class] forCellWithReuseIdentifier:@"cell"];
    self.gridImages = [[NSMutableArray alloc] init];
    
    // Configure layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(70, 70)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.exploreCollectionView setCollectionViewLayout:flowLayout];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Image"];
    [query whereKey:@"isPublic" equalTo:[NSNumber numberWithBool:YES]];
    [query orderByDescending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            for (PFObject *object in objects) {
                PFFile *imageFile = [object objectForKey:@"imageFile"];
                [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
                    if (!error) {
                        [self.gridImages addObject:[UIImage imageWithData:data]];
                        [self.exploreCollectionView reloadData];
                    }
                } progressBlock:^(int percentDone) {
                }];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.gridImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Setup cell identifier
    static NSString *cellIdentifier = @"cell";
    Cell *cell = (Cell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    UIImage *cellData = [self.gridImages objectAtIndex:indexPath.row];
    [cell.cellImage setImage:cellData];
    
    // Return the cell
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

@end