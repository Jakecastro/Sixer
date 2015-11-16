//
//  Player.h
//  Sixer
//
//  Created by Jake Castro on 11/15/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "Player.h"

typedef enum {
    PlayerPositionBottom,  // the user
    PlayerPositionLeft,
    PlayerPositionTop,
    PlayerPositionRight
}
PlayerPosition;

@interface Player : NSObject

@property (nonatomic, assign) PlayerPosition position;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *peerID;

@end
