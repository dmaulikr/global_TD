//
//  WildcardGestureRecognizer.m
//  Created by Raymond Daly on 10/31/10.
//  Copyright 2010 Floatopian LLC. All rights reserved.
//

#import "WildcardGestureRecognizer.h"
#import "DataModel.h"
#import "MapDirectionsAppDelegate.h"
#import "MapKit/MapKit.h"
#import "HelloWorldScene.h"

@implementation WildcardGestureRecognizer
@synthesize touchesBeganCallback;

-(id) init{
    if (self = [super init])
    {
        self.cancelsTouchesInView = NO;
         
        
    }
    return self;
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    NSLog(@"hitTest:withEvent called :");
//    NSLog(@"Event: %@", event);
//    NSLog(@"Point: %@", NSStringFromCGPoint(point));
//    NSLog(@"Event Type: %d", event.type);
//    NSLog(@"Event SubType: %d", event.subtype);
//    NSLog(@"---");
//    
//    return [super hitTest:point withEvent:event];
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    NSLog(@"touchesBegan ________");
    DataModel *m = [DataModel getModel];
 
    [m._gameLayer keepPositions:m.routeMapView];
    [m._gameLayer keepProjectilesPos:m.routeMapView];
    
    [m._gameHUDLayer t_Begin:touches withEvent:event];
//    [m.routeMapView touchesBegan:touches withEvent:event];
    

   
//    CLLocation *loc = [m._prevTarPos objectAtIndex:0];
//    CLLocationCoordinate2D coord =  loc.coordinate;
//    m.coord_begin = coord;
//    NSLog(@"does this change? %f, %f", coord.latitude, coord.longitude);
//    
        if (touchesBeganCallback)
        touchesBeganCallback(touches, event); 
    // NSLog(@"wild %f,%f", touchLocation.x, touchLocation.y);
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
   // DataModel *m = [DataModel getModel];
   //[m._gameLayer touchesCancelled:touches withEvent: event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    DataModel *m = [DataModel getModel];
  // [m._gameLayer touchesEnded:touches withEvent: event];
    [m._gameHUDLayer t_Ended:touches withEvent:event];
   // [m.cocos_view t_Ended:touches withEvent:event];
//    [m.routeMapView touchesEnded:touches withEvent:event];
    
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    DataModel *m = [DataModel getModel];
  // [m._gameLayer touchesMoved:touches withEvent: event];
    [m._gameHUDLayer t_Moved:touches withEvent:event];
//    [m.routeMapView touchesMoved:touches withEvent:event];
}

- (void)reset
{
   // NSLog(@"reset");
}

- (void)ignoreTouch:(UITouch *)touch forEvent:(UIEvent *)event
{
   // NSLog(@"ignore");
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    //    NSLog(@"recPrevYes!!!!!!!");
    return YES;
}

- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer
{
   // NSLog(@"recPrevYes!!!!!!!");
    return NO;
}

@end