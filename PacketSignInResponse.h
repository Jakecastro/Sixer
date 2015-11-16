//
//  PacketSignInResponse.h
//  Sixer
//
//  Created by Jake Castro on 11/16/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "Packet.h"

@interface PacketSignInResponse : Packet

@property (nonatomic, copy) NSString *playerName;

+ (id)packetWithPlayerName:(NSString *)playerName;

@end
