//
//  MyCollectionViewCell.m
//  Demo10
//
//  Created by vfa on 8/19/22.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell
- (void)awakeFromNib{
    [super awakeFromNib];
    self.imageView.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView.backgroundColor = [UIColor systemBlueColor];
    

    
}

@end
