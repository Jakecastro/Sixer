//
//  CVExerciseCell.h
//  Sixer
//
//  Created by Jake Castro on 11/6/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Color.h"

@interface CVExerciseCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *savedLabel;

@end
