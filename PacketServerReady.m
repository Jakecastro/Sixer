//
//  PacketServerReady.m
//  Sixer
//
//  Created by Jake Castro on 11/16/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "PacketServerReady.h"
#import "NSData+FitAdditions.h"
#import "Player.h"

@implementation PacketServerReady

@synthesize players = _players;

+ (id)packetWithPlayers:(NSMutableDictionary *)players {
    return [[[self class] alloc] initWithPlayers:players];
}

+ (id)packetWithData:(NSData *)data {
    NSMutableDictionary *players = [NSMutableDictionary dictionaryWithCapacity:4];
    
    const size_t PACKET_HEADER_SIZE = 10;
    
    size_t offset = PACKET_HEADER_SIZE;
    size_t count;
    
    int numberOfPlayers = [data rw_int8AtOffset:offset];
    offset += 1;
    
    for (int t = 0; t < numberOfPlayers; ++t) {
        NSString *peerID = [data rw_stringAtOffset:offset bytesRead:&count];
        offset += count;
        
        NSString *name = [data rw_stringAtOffset:offset bytesRead:&count];
        offset += count;
        
        PlayerPosition position = [data rw_int8AtOffset:offset];
        offset += 1;
        
        Player *player = [[Player alloc] init];
        player.peerID = peerID;
        player.name = name;
        player.position = position;
        [players setObject:player forKey:player.peerID];
    }
    
    return [[self class] packetWithPlayers:players];
}

- (id)initWithPlayers:(NSMutableDictionary *)players {
    if ((self = [super initWithType:PacketTypeServerReady])) {
        self.players = players;
    }
    return self;
}

- (void)addPayloadToData:(NSMutableData *)data {
    [data rw_appendInt8:[self.players count]];
    
    [self.players enumerateKeysAndObjectsUsingBlock:^(id key, Player *player, BOOL *stop) {
         [data rw_appendString:player.peerID];
         [data rw_appendString:player.name];
         [data rw_appendInt8:player.position];
     }];
}

@end
