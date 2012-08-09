//
//  NetworkController.m
//  CatRace
//
//  Created by student on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NetworkController.h"
#import "DataModel.h"
#import "MapDirectionsViewController.h"  

@implementation NetworkController
@synthesize gameCenterAvailable = _gameCenterAvailable;
@synthesize userAuthenticated = _userAuthenticated;
@synthesize delegate = _delegate;
@synthesize state = _state;
@synthesize inputStream = _inputStream;
@synthesize outputStream = _outputStream;
@synthesize inputOpened = _inputOpened;
@synthesize outputOpened = _outputOpened;
@synthesize outputBuffer = _outputBuffer;
@synthesize okToWrite = _okToWrite;
@synthesize inputBuffer = _inputBuffer;
@synthesize okToRead = _okToRead;

#pragma mark - Helpers

static NetworkController *sharedController = nil;
+ (NetworkController *) sharedInstance {
    if (!sharedController) {
        sharedController = [[NetworkController alloc] init];
    }
    return sharedController;
}

- (BOOL)isGameCenterAvailable {
    // check for presence of GKLocalPlayer API
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    // check if the device is running iOS 4.1 or later
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer 
                                           options:NSNumericSearch] != NSOrderedAscending);
    
    return (gcClass && osVersionSupported);
}

- (void)setState:(NetworkState)state {
    _state = state;
    if (_delegate) {
        //[_delegate stateChanged:_state];
    }
}

#pragma mark - Init

- (id)init {
    if ((self = [super init])) {
        [self setState:_state];
        _gameCenterAvailable = [self isGameCenterAvailable];
        /*
        if (_gameCenterAvailable) {
            NSNotificationCenter *nc = 
            [NSNotificationCenter defaultCenter];
            [nc addObserver:self 
                   selector:@selector(authenticationChanged) 
                       name:GKPlayerAuthenticationDidChangeNotificationName 
                     object:nil];
        }
         */
    }
    return self;
}

#pragma mark - Server communication

- (void)connect {    
    self.outputBuffer = [NSMutableData data];
    self.inputBuffer = [NSMutableData data];
    self.okToRead = NO;
    [self setState:NetworkStateConnectingToServer];
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"liberty-prime.isi.edu", 8888, &readStream, &writeStream);
    _inputStream = (NSInputStream *)readStream;
    _outputStream = (NSOutputStream *)writeStream;
    [_inputStream setDelegate:self];
    [_outputStream setDelegate:self];
    [_inputStream setProperty:(id)kCFBooleanTrue forKey:(NSString *)kCFStreamPropertyShouldCloseNativeSocket];
    [_outputStream setProperty:(id)kCFBooleanTrue forKey:(NSString *)kCFStreamPropertyShouldCloseNativeSocket];
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_inputStream open];
    [_outputStream open];
}

- (void)disconnect {
    
    [self setState:NetworkStateConnectingToServer];
    self.outputBuffer = nil;
    self.inputBuffer = nil;

    if (_inputStream != nil) {
        self.inputStream.delegate = nil;
        [_inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [_inputStream close];
        self.inputStream = nil;
    } 
    if (_outputStream != nil) {
        self.outputStream.delegate = nil;
        [self.outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [self.outputStream close];
        self.outputStream = nil;
    }
}

- (void)reconnect {
    [self disconnect];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5ull * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self connect];
    });
}

- (void)checkMesage {
    while (true) {
        if (_inputBuffer.length < sizeof(int)) {
            return;
        }
        
        int msgLength = *((int *) _inputBuffer.bytes);
        msgLength = ntohl(msgLength);
       // NSLog(@"message length is %d input buffer length is %d",msgLength,_inputBuffer.length);
        if (_inputBuffer.length < msgLength) {
            return;
        }
        
        NSData * message = [_inputBuffer subdataWithRange:NSMakeRange(4, msgLength)];
        //[self processMessage:message];
        
        int amtRemaining = _inputBuffer.length - msgLength - sizeof(int);
        if (amtRemaining == 0) {
            self.inputBuffer = [[[NSMutableData alloc] init] autorelease];
        } else {
            NSLog(@"inputbuffer still has bytes %d",amtRemaining);
            self.inputBuffer = [[[NSMutableData alloc] initWithBytes:_inputBuffer.bytes+4+msgLength length:amtRemaining] autorelease];
        }        
        
        
        NSString *output = [[NSString alloc] initWithData:message encoding:NSASCIIStringEncoding]; 
        
        
        if (nil != output) {
            // DataModel *m = [DataModel getModel];
            //m.outputReady = YES;
            //m.outputString = output;
            //[_inputBuffer setString:output];
            _okToRead = YES;
            [self processData:output];
            
        }
        
        
    }
}



- (void)inputStreamHandleEvent:(NSStreamEvent)eventCode {
    
    switch (eventCode) {
        case NSStreamEventOpenCompleted: {
            NSLog(@"Opened input stream");
            _inputOpened = YES;
            if (_inputOpened && _outputOpened && _state == NetworkStateConnectingToServer) {
                [self setState:NetworkStateConnected];
                // TODO: Send message to server
            }
        } 
        case NSStreamEventHasBytesAvailable: {                       
            if ([_inputStream hasBytesAvailable]) {                
                NSLog(@"Input stream has bytes...");
                // TODO: Read bytes 
                uint8_t buffer[1024];
                int len;
                
                while ([_inputStream hasBytesAvailable]) {
                    
                    len = [_inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        
                        [_inputBuffer appendData:[NSData dataWithBytes:buffer length:len]];

                        [self checkMesage];
                        
                        /*
                        if (_inputBuffer.length < sizeof(int)){
                            return;
                        }
                        int msgLength = *((int*) _inputBuffer.bytes);
                        msgLength = ntohl(msgLength);
                        NSLog(@"message length is %d input buffer length is %d",msgLength,_inputBuffer.length);
                        if (_inputBuffer.length < msgLength){
                            return;
                        }
                        NSData * messageData = [_inputBuffer subdataWithRange:NSMakeRange(4, msgLength)];
                        int amtRemaining = _inputBuffer.length - msgLength - sizeof(int);
                        if(amtRemaining == 0){
                            self.inputBuffer = [NSMutableData data] ;
                        }
                        else{
                            NSLog(@"inputbuffer still has bytes %d",amtRemaining);
                            self.inputBuffer = [NSMutableData dataWithBytes:_inputBuffer.bytes+4+msgLength length:amtRemaining];
                           // self.inputBuffer = [[NSMutableData alloc] initWithBytes:_inputBuffer.bytes+4+msgLength length:amtRemaining] ;
                            
                        }
                                                
                        //NSString *output = [[NSString alloc] initWithBytes:messageData length:messageData.length encoding:NSASCIIStringEncoding];            
                        NSString *output = [[NSString alloc] initWithData:messageData encoding:NSASCIIStringEncoding]; 
                                            
                                                           
                        if (nil != output) {
                           // DataModel *m = [DataModel getModel];
                            //m.outputReady = YES;
                            //m.outputString = output;
                            //[_inputBuffer setString:output];
                            _okToRead = YES;
                            [self processData:output];

                        }
                         */
                    }
                }

            }
        } break;
        case NSStreamEventHasSpaceAvailable: {
            assert(NO); // should never happen for the input stream
        } break;
        case NSStreamEventErrorOccurred: {
            NSLog(@"Stream open error, reconnecting");
            [self reconnect];
        } break;
        case NSStreamEventEndEncountered: {
            // ignore
        } break;
        default: {
            assert(NO);
        } break;
    }    
}


- (BOOL)writeChunk {
    int amtToWrite = MIN(_outputBuffer.length, 1024);
    if (amtToWrite == 0) return FALSE;
    
    NSLog(@"Amt to write: %d/%d", amtToWrite, _outputBuffer.length);
    
    int amtWritten = [self.outputStream write:_outputBuffer.bytes maxLength:amtToWrite];
    if (amtWritten < 0) {
        [self reconnect];
    }
    int amtRemaining = _outputBuffer.length - amtWritten;
    NSLog(@"Wrote %d bytes, %d remaining.", amtWritten, amtRemaining);    
    if (amtRemaining == 0) {
        self.outputBuffer = [NSMutableData data] ;
    }
    else if(amtWritten == -1){
        NSLog(@"not able to write this message to server");
    }
    else {
        NSLog(@"Creating output buffer of length %d", amtRemaining);
        self.outputBuffer = [NSMutableData dataWithBytes:_outputBuffer.bytes+amtWritten length:amtRemaining];
    }
    

    _okToWrite = FALSE;
    return TRUE;
}


- (void)outputStreamHandleEvent:(NSStreamEvent)eventCode {            
    switch (eventCode) {
        case NSStreamEventOpenCompleted: {
            NSLog(@"Opened output stream");
            _outputOpened = YES;
            if (_inputOpened && _outputOpened && _state == NetworkStateConnectingToServer) {
                [self setState:NetworkStateConnected];
                // TODO: Send message to server
            }
        } break;
        case NSStreamEventHasBytesAvailable: {
            assert(NO);     // should never happen for the output stream
        } break;
        case NSStreamEventHasSpaceAvailable: {
            NSLog(@"Ok to send");
            //BOOL wroteChunk = [self writeChunk];
            //if (!wroteChunk) {
            //    _okToWrite = TRUE;
            //}
            // TODO: Write bytes
        } break;
        case NSStreamEventErrorOccurred: {
            NSLog(@"Stream open error, reconnecting");
            [self reconnect];
        } break;
        case NSStreamEventEndEncountered: {
            // ignore
        } break;
        default: {
            assert(NO);
        } break;
    }
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode { 
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        if (aStream == _inputStream) {
            [self inputStreamHandleEvent:eventCode];
        } else if (aStream == _outputStream) {
            [self outputStreamHandleEvent:eventCode];
        }
    });
}

#pragma mark - Authentication
/*
- (void)authenticationChanged {    
    
    if ([GKLocalPlayer localPlayer].isAuthenticated && !_userAuthenticated) {
        NSLog(@"Authentication changed: player authenticated.");
        [self setState:NetworkStateAuthenticated];
        _userAuthenticated = TRUE; 
        [self connect];
    } else if (![GKLocalPlayer localPlayer].isAuthenticated && _userAuthenticated) {
        NSLog(@"Authentication changed: player not authenticated");
        _userAuthenticated = FALSE;
        [self disconnect];
        [self setState:NetworkStateNotAvailable];
    }
    
}
*/
- (void)authenticateLocalUser { 
    
   // if (!_gameCenterAvailable) return;
    [self setState:NetworkStateConnectingToServer];
    [self connect];
    //remeber disconnect time
    /*
    NSLog(@"Authenticating local user...");
    if ([GKLocalPlayer localPlayer].authenticated == NO) {     
        [self setState:NetworkStatePendingAuthentication];
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:nil];        
    } else {
        NSLog(@"Already authenticated!");
    }
     */
}


- (void)sendData:(NSString*)str {
    //NSLog(@"sending data to server = %@",str);

    NSData *data = [[NSData alloc] initWithData:[str dataUsingEncoding:NSASCIIStringEncoding]];
    int dataLength = data.length;
    dataLength = htonl(dataLength);
    [self.outputBuffer appendBytes:&dataLength length:sizeof(dataLength)];
    [self.outputBuffer appendData:data];
    [self writeChunk];
    //[self.outputStream write:[self.outputBuffer bytes] maxLength:[self.outputBuffer length]];
    
}

- (NSString*)processData:(NSString*)str{
    NSLog(@"string to be processed = %@",str);
    
    
    if (self.delegate) {
        NSLog(@"am i here?");
        [self.delegate readString:str];
        
    }   
    return str;
}

@end