//
//  Settings.h
//  Sixer
//
//  Created by Danielle Smith on 11/7/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Settings : NSObject
@property NSString *cellName;
@property UIImage *cellImage;

-(instancetype) initWithName:(NSString *)cellTitle withImage:(UIImage *)imageIcon;
@end
