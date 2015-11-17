//
//  PacketSignInResponse.m
//  Sixer
//
//  Created by Jake Castro on 11/16/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "PacketSignInResponse.h"
#import "NSData+FitAdditions.h"

@implementation PacketSignInResponse

@synthesize playerName = _playerName;

+ (id)packetWithData:(NSData *)data {
    size_t count;
    const size_t PACKET_HEADER_SIZE = 10;
    NSString *playerName = [data rw_stringAtOffset:PACKET_HEADER_SIZE bytesRead:&count];
    return [[self class] packetWithPlayerName:playerName];
}

+ (id)packetWithPlayerName:(NSString *)playerName {
    return [[[self class] alloc] initWithPlayerName:playerName];
}

- (id)initWithPlayerName:(NSString *)playerName {
    if ((self = [super initWithType:PacketTypeSignInResponse])) {
        self.playerName = playerName;
    }
    return self;
}

- (void)addPayloadToData:(NSMutableData *)data {
    [data rw_appendString:self.playerName];
}

@end
