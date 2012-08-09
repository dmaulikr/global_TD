//
//  Wave.m
//  GlobalTD-1.0
//
//  Created by Raushan Karayeva on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Wave.h"

@implementation Wave

@synthesize spawnRate = _spawnRate;
@synthesize totalCreeps = _totalCreeps;
@synthesize aliveCreeps = _aliveCreeps;

@synthesize creepType = _creepType;

-(id) init
{
	if( (self=[super init]) ) {
		
	}
	
	return self;
}

- (id) initWithCreep:(Creep *)creep SpawnRate:(float)spawnrate TotalCreeps:(int)totalcreeps
{
	NSAssert(creep!=nil, @"Invalid creep for wave.");
    
	if( (self = [self init]) )
	{
		_creepType = creep;
		_spawnRate = spawnrate;
		_totalCreeps = totalcreeps;
        _aliveCreeps = totalcreeps;
	}
	return self;
}


@end
