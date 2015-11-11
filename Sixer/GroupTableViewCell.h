//
//  GroupTableViewCell.h
//  Sixer
//
//  Created by Matt Burrill on 11/9/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"

@protocol PassNameOfGroupDelegate <NSObject>

@optional

-(void) groupTableViewCell:(id)cell didTapButton:(UIButton *)button withGroup:(Group *)group;


@end

@interface GroupTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *onButtonPressSelectGroup;

@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;
@property Group *groupInCell;

@property (nonatomic, assign) id<PassNameOfGroupDelegate> delegate;

@end
