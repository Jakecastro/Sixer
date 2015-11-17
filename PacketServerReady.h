//
//  PacketServerReady.h
//  Sixer
//
//  Created by Jake Castro on 11/16/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "Packet.h"

@interface PacketServerReady : Packet

@property (nonatomic, strong) NSMutableDictionary *players;

+ (id)packetWithPlayers:(NSMutableDictionary *)players;

@end
