//
//  MultiplayerButton.m
//  Sixer
//
//  Created by Jake Castro on 11/12/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "MultiplayerButton.h"
#import "Color.h"


@implementation MultiplayerButton

- (void)awakeFromNib {
    [self.layer setCornerRadius:5.0f];
    self.backgroundColor = [Color flatPeterRiverColor];
    self.titleLabel.textColor = [Color flatCloudsColor];
    
}

@end
