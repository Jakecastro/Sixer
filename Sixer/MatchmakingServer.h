//
//  MatchmakingServer.h
//  Sixer
//
//  Created by Jake Castro on 11/12/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@class MatchmakingServer;

@protocol MatchmakingServerDelegate <NSObject>

- (void)matchmakingServer:(MatchmakingServer *)server clientDidConnect:(NSString *)peerID;
- (void)matchmakingServer:(MatchmakingServer *)server clientDidDisconnect:(NSString *)peerID;
- (void)matchmakingServerSessionDidEnd:(MatchmakingServer *)server;
- (void)matchmakingServerNoNetwork:(MatchmakingServer *)server;

@end

@interface MatchmakingServer : NSObject <GKSessionDelegate>

@property (nonatomic, assign) int maxClients;
@property (nonatomic, strong, readonly) NSArray *connectedClients;
@property (nonatomic, strong, readonly) GKSession *session;
@property (nonatomic, weak) id <MatchmakingServerDelegate> delegate;

- (void)endSession;
- (void)stopAcceptingConnections;
- (void)startAcceptingConnectionsForSessionID:(NSString *)sessionID;
- (NSUInteger)connectedClientCount;
- (NSString *)peerIDForConnectedClientAtIndex:(NSUInteger)index;
- (NSString *)displayNameForPeerID:(NSString *)peerID;


@end
