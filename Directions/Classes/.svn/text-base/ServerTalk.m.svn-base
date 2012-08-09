//
//  ServerTalk.m
//  MapDirections
//
//  Created by Samantha Danesis on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServerTalk.h"


@implementation ServerTalk

@synthesize gameState;
@synthesize playerTurn;
@synthesize towers;
@synthesize _homeBaseCoord;

static ServerTalk *_sharedContext = nil;

+(ServerTalk*)getModel 
{
	if (!_sharedContext) {
		_sharedContext = [[self alloc] init];
	}
	
	return _sharedContext;
}

-(void)encodeWithCoder:(NSCoder *)coder {
    
}

-(id)initWithCoder:(NSCoder *)coder {
    
	return self;
}

- (id) init
{
	if ((self = [super init])) {
     _homeBaseCoord = [[NSMutableArray alloc] init];
	}
	return self;
}


- (void)dealloc {
    //self._prevHomeBasePos = nil;
    
    [_homeBaseCoord release];
    self._homeBaseCoord = nil;
    
    [super dealloc];
}


- (void) sendToServer{
    
}
- (void) getFromServer{
    
}

@end
