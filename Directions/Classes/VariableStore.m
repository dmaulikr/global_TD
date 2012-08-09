//
//  VariableStore.m
//  MapDirections
//
//  Created by Lion User on 09/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VariableStore.h"

@implementation VariableStore
static VariableStore* _vStore = nil;

+(VariableStore *)vStore
{
    @synchronized([VariableStore class])
    {
        if(!_vStore)
            [[self alloc] init];
        
        return _vStore;
    }

    return nil;
}
    
+(id) alloc
{
    @synchronized([VariableStore class])
    {
        NSAssert(_vStore == nil, @"Attempted to allocate a second instance of VariableStore");
        _vStore = [super alloc];
        return _vStore;
    }
    
    return nil;
}

-(id)init{
    self = [super init];
    if(self !=nil){
        //initialize variables here
        zoom = 16;
        gameAreaSet = NO;
        
    }
    
    return self;
}


-(NSUInteger)getZoom{
    return zoom;
}
-(void)setZoom:(NSUInteger)z{
    zoom = z;
}

- (BOOL) getGameAreaSet{
    return gameAreaSet;
}

- (void) setGameArea:(BOOL) boo{
    gameAreaSet = boo;
}

- (void) setInMapView:(EAGLView*) inMapView2{
    inMapView = inMapView2;
}
- (EAGLView*) getInMapView{
    return inMapView;
}

@end
