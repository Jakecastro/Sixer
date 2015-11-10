//
//  GroupTableViewCell.h
//  Sixer
//
//  Created by Matt Burrill on 11/9/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *onButtonPressSelectGroup;

@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;

@end
