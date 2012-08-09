//
//  ServerTalk.h
//  MapDirections
//
//  Created by Samantha Danesis on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerTalk : NSObject <NSCoding>{
    int playerTurn;
    NSMutableArray *_homeBaseCoord;
    NSMutableArray *towers;
    int gameState;
    
    
    
}

@property (nonatomic, assign) int playerTurn;
@property (nonatomic, assign) int gameState;
@property (nonatomic, retain) NSMutableArray *_homeBaseCoord;
@property (nonatomic, assign) NSMutableArray *towers;

- (void) sendToServer;
- (void) getFromServer;
+ (ServerTalk*)getModel;

@end
