//
//  MainViewController.m
//  NISH
//
//  Created by Bach Vu on 9/10/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    
//    self.gridImages = [[NSMutableArray alloc] init];
    
//    NSArray *arr  = [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:nil options:nil];
//    self.cell = [arr objectAtIndex:0];
    
    [self.mainCollectionView registerClass:[Cell class] forCellWithReuseIdentifier:@"cell"];
    self.gridImages = [[NSMutableArray alloc] init];
    
    // Configure layout
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setItemSize:CGSizeMake(70, 70)];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [self.mainCollectionView setCollectionViewLayout:flowLayout];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Image"];
    [query whereKey:@"isPublic" equalTo:[NSNumber numberWithBool:YES]];
    [query orderByDescending:@"createdAt"];
    [query setLimit:20];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            for (PFObject *object in objects) {
                PFFile *imageFile = [object objectForKey:@"imageFile"];
                [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
                    if (!error) {
                        [self.gridImages addObject:[UIImage imageWithData:data]];
                        [self.mainCollectionView reloadData];
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

- (IBAction)login:(id)sender {
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (IBAction)registration:(id)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.gridImages count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
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
