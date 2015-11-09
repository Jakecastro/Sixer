//
//  Settings.m
//  Sixer
//
//  Created by Danielle Smith on 11/7/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "Settings.h"

@implementation Settings

-(instancetype) initWithName:(NSString *)cellTitle withImage:(UIImage *)imageIcon {
    
    self = [super init];
    if(self) {
        self.cellName = cellTitle;
        self.cellImage = imageIcon;
    }
    
    return self;
}

@end
