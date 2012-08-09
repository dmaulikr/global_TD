//
//  Wave.h
//  GlobalTD-1.0
//
//  Created by Raushan Karayeva on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



#import "cocos2d.h"

#import "Creep.h"

@interface Wave : CCNode {
	float _spawnRate;
	int _totalCreeps;
    int _aliveCreeps;
	Creep * _creepType;
}

@property (nonatomic) float spawnRate;
@property (nonatomic) int totalCreeps;
@property (nonatomic) int aliveCreeps;
@property (nonatomic, retain) Creep *creepType;

- (id)initWithCreep:(Creep *)creep SpawnRate:(float)spawnrate TotalCreeps:(int)totalcreeps;

@end
