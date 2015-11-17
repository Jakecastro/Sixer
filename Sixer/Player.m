//
//  Player.m
//  Sixer
//
//  Created by Jake Castro on 11/15/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize position = _position;
@synthesize name = _name;
@synthesize peerID = _peerID;
@synthesize receivedResponse = _receivedResponse;

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"dealloc %@", self);
#endif
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ peerID = %@, name = %@, position = %d", [super description], self.peerID, self.name, self.position];
}

@end