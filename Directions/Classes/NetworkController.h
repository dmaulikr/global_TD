//
//  NetworkController.h
//  CatRace
//
//  Created by student on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

typedef enum {
    NetworkStateNotAvailable,
    NetworkStatePendingAuthentication,
    NetworkStateAuthenticated,    
    NetworkStateConnectingToServer,
    NetworkStateConnected,
} NetworkState;

@protocol NetworkControllerDelegate
- (void)stateChanged:(NetworkState)state;
@end

@interface NetworkController : NSObject <NSStreamDelegate>{
    BOOL _gameCenterAvailable;
    BOOL _userAuthenticated;
    id <NetworkControllerDelegate> _delegate;
    NetworkState _state;
    NSInputStream *_inputStream;
    NSOutputStream *_outputStream;
    BOOL _inputOpened;
    BOOL _outputOpened;
    NSMutableData *_outputBuffer;
    BOOL _okToWrite;
    NSMutableData *_inputBuffer;
    BOOL _okToRead;
}

@property (assign, readonly) BOOL gameCenterAvailable;
@property (assign, readonly) BOOL userAuthenticated;
@property (assign) id <NetworkControllerDelegate> delegate;
@property (assign, readonly) NetworkState state;
@property (retain) NSInputStream *inputStream;
@property (retain) NSOutputStream *outputStream;
@property (assign) BOOL inputOpened;
@property (assign) BOOL outputOpened;
@property (retain) NSMutableData *outputBuffer;
@property (assign) BOOL okToWrite;
@property (retain) NSMutableData *inputBuffer;
@property (assign) BOOL okToRead;

+ (NetworkController *)sharedInstance;
- (void)authenticateLocalUser;
- (void)connect;
- (void)disconnect;
- (void)sendData:(NSString*)str;
- (BOOL)writeChunk;
- (NSString*)processData:(NSString*)str;
- (void)sendData:(NSString*)str;

@end