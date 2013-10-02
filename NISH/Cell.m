//
//  Cell.m
//  NISH
//
//  Created by Bach Vu on 9/10/13.
//  Copyright (c) 2013 Bach Vu. All rights reserved.
//

#import "Cell.h"

@interface Cell()

@property (nonatomic, weak) IBOutlet UIButton *btn;

@end

@implementation Cell
@synthesize cellImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

//- (void)awakeFromNib{
//    [super awakeFromNib];
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
