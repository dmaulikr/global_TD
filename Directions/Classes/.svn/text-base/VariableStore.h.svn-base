//
//  VariableStore.h
//  MapDirections
//
//  Created by Lion User on 09/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface VariableStore : NSObject
{
    NSUInteger zoom;
    BOOL gameAreaSet;
    EAGLView *inMapView;
}
+(VariableStore *)vStore;

-(NSUInteger) getZoom;
-(void)setZoom:(NSUInteger) z;

- (BOOL) getGameAreaSet;
- (void) setGameArea:(BOOL) boo;
- (void) setInMapView:(EAGLView*) inMapView2;
- (EAGLView*) getInMapView;

@end
