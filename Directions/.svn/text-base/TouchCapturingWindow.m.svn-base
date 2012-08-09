//
//  TouchCapturingWindow.m
//  WTSWTSTM
//
//  Created by Bruno Nadeau on 10-10-21.
//  Copyright 2010 Wyld Collective Ltd. All rights reserved.
//

#import "TouchCapturingWindow.h"
#import "DataModel.h"
#import "HelloWorldScene.h"
#import "WaveCreationLayer.h"
#import "MainMenuCocosLayer.h"


@implementation TouchCapturingWindow

- (void)dealloc {
    if ( views ) [views release];
    [super dealloc];
}

- (void)addViewForTouchPriority:(UIView*)view {
    if ( !views ) views = [[NSMutableArray alloc] init];
    [views addObject:view];
}

- (void)removeViewForTouchPriority:(UIView*)view {
    if ( !views ) return;
    [views removeObject:view];
}

- (void)sendEvent:(UIEvent *)event {

    UITouch *touch = [[event allTouches] anyObject];

    if (touch.phase == UITouchPhaseBegan) {
        DataModel *m = [DataModel getModel];
        [m._gameLayer keepPositions:m.routeMapView];
        [m._gameLayer keepProjectilesPos:m.routeMapView];
        [m._gameLayer keepHomeBasePos:m.routeMapView];
        [m._gameLayer keepEnemyHomeBasePos:m.routeMapView];
        
        [m._gameHUDLayer t_Begin:touch withEvent:event];
        [m._gameLayer t_Begin:touch withEvent:event];
        [m._MainMenuCocosLayer t_Begin:touch withEvent:event]; 
        if(m._WaveCreationUIlayer.visible==true){
            [m._WaveCreationUIlayer t_Begin:touch withEvent:event];
        }
     
    }
	else if (touch.phase == UITouchPhaseMoved) {
        DataModel *m = [DataModel getModel];
        [m._gameHUDLayer t_Moved:touch withEvent:event];
        [m._gameLayer t_Moved:touch withEvent:event];
        [m._MainMenuCocosLayer t_Moved:touch withEvent:event]; 
         
	}
	else if (touch.phase == UITouchPhaseCancelled) {

	}
	else if (touch.phase == UITouchPhaseEnded) {
        
        DataModel *m = [DataModel getModel];
        [m._gameHUDLayer t_Ended:touch withEvent:event];
        [m._gameLayer t_Ended:touch withEvent:event];
        [m._MainMenuCocosLayer t_Ended:touch withEvent:event];
        
    }
    
    [super sendEvent:event];
}

@end