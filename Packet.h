//
//  Packet.h
//  Sixer
//
//  Created by Jake Castro on 11/16/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//


// const size_t PACKET_HEADER_SIZE = 10;

typedef enum {
    PacketTypeSignInRequest = 0x64,    // server to client
    PacketTypeSignInResponse,          // client to server
    
    PacketTypeServerReady,             // server to client
    PacketTypeClientReady,             // client to server
    
    PacketTypeDealCards,               // server to client
    PacketTypeClientDealtCards,        // client to server
    
    PacketTypeActivatePlayer,          // server to client
    PacketTypeClientTurnedCard,        // client to server
    
    PacketTypePlayerShouldSnap,        // client to server
    PacketTypePlayerCalledSnap,        // server to client
    
    PacketTypeOtherClientQuit,         // server to client
    PacketTypeServerQuit,              // server to client
    PacketTypeClientQuit,              // client to server
}
PacketType;

@interface Packet : NSObject

@property (nonatomic, assign) PacketType packetType;

+ (id)packetWithType:(PacketType)packetType;
- (id)initWithType:(PacketType)packetType;
+ (id)packetWithData:(NSData *)data;

- (NSData *)data;

@end
