//
//  UICRouteOverlayMapView.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import "UICRouteOverlayMapView.h"
#import "MKMapView_ZoomLevel.h"
#import "VariableStore.h"
#import "cocos2d.h"
#import "MapDirectionsViewController.h"
#import "UICRouteOverlayMapView.h"
#import "UICRouteAnnotation.h"
#import "RouteListViewController.h"
#import "WaveCreationLayer.h"
#import "VariableStore.h"
#import "LimitedMapView.h"
#import "HelloWorldScene.h"
#import "GameHUD.h"

@implementation UICRouteOverlayMapView

@synthesize inMapView;
@synthesize routes;
@synthesize lineColor; 

- (id)initWithMapView:(MKMapView *)mapView {
	self = [super initWithFrame:CGRectMake(0.0f, 0.0f, mapView.frame.size.width, mapView.frame.size.height)];
	if (self != nil) {
        DataModel *m = [DataModel getModel];
		self.inMapView = (MKMapView*) mapView;
		self.backgroundColor = [UIColor clearColor];
		self.userInteractionEnabled =  NO;
        m.inMapView = inMapView;
        
		[self.inMapView addSubview:self];
        
       // [self.inMapView addSubview:m.cocos_view];
        //[self init_CocosView];
	}
	
	return self;
}


- (void)dealloc {
	[inMapView release];
	[routes release];
	[lineColor release];
	[super dealloc];
}

- (void)drawRect:(CGRect)rect { 
   // NSLog(@"BEFORE meow");
	
    DataModel *m = [DataModel getModel];
    //NSLog(@"poop1 %d", self.hidden);
   // NSLog(@"poop2 %@", self.routes);
    //NSLog(@"poop3 %d", (self.routes.count > 0));
    //if(!self.hidden && self.routes != nil && self.routes.count > 0) {
	if(self.routes != nil && self.routes.count > 0) {
        self.hidden = 0;
        CGContextRef context = UIGraphicsGetCurrentContext(); 
		
		if(!self.lineColor) {
			self.lineColor = [UIColor colorWithRed:0.0f green:0.0f blue:1.0f alpha:0.5f];
		}
        
		//NSLog(@"WOOOOOF");
		CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
		CGContextSetRGBFillColor(context, 0.0f, 0.0f, 1.0f, 1.0f);
		
		CGContextSetLineWidth(context, 4.0f);

        //update way points
		for(int i = 0; i < self.routes.count; i++) {
			CLLocation* location = [self.routes objectAtIndex:i];   
			CGPoint point = [m.routeMapView convertCoordinate:location.coordinate toPointToView:self];
            WayPoint *waypt;
            if(m._waypoints.count == self.routes.count){
                waypt = [m._waypoints objectAtIndex:i];
//                NSLog(@"waypt b4 = %f, %f",waypt.position.x, waypt.position.y);   
            }
            WayPoint *wp = nil;
            
            int x = point.x;
            //the cocos view is at a diff orientation than mapview.  must flip the y axis
            int y = m.routeMapView.frame.size.height -  point.y;

            
            wp = [WayPoint node];
            wp.position = ccp(x, y);
            wp.coord = location.coordinate;
            
            if(m._waypoints.count <=i){
                [m._waypoints addObject:wp];
            }else{
                [m._waypoints replaceObjectAtIndex:i withObject:wp];
            }
                      
        
			if(i == 0) {
				CGContextMoveToPoint(context, point.x, point.y);
			} else {
				CGContextAddLineToPoint(context, point.x, point.y);
			}
		}
       
        
        
        //refresh creeps
        for(int j = 0; j< m._targets.count; j++){
            CLLocation *loc = [m._prevTarPos objectAtIndex:j]; 
            Creep *creep = [m._targets objectAtIndex:j];
            CGPoint tarPoint = [m.routeMapView convertCoordinate:loc.coordinate toPointToView:m.cocos_view];
            
            //this should only be if it is moving, else there is no decement of waypoint.
//         
            
            creep.curWaypoint= creep.curWaypoint-1;
            NSLog(@"in UICRouteOverlayMapVIew=%d",creep.curWaypoint);
            
            float moveDuration = [creep moveDurScale];
            //float vel = [creep getVelocity:creep];
            id actionMove = [CCMoveTo actionWithDuration:0 position: [[CCDirector sharedDirector] convertToGL:tarPoint]];
            id actionMove2 = [CCMoveTo actionWithDuration:moveDuration position:creep.getCurrentWaypoint.position];
            id actionMoveDone = [CCCallFuncN actionWithTarget:m._gameLayer selector:@selector(FollowPath:)];
            [creep stopAllActions];
            [creep runAction:[CCSequence actions:actionMove, actionMove2, actionMoveDone, nil]];
//            CGPoint pts=[[CCDirector sharedDirector] convertToGL:tarPoint];
//            int xPos=pts.x;
//            int yPos=pts.y;
//            creep.position=ccp(xPos,yPos);
        }

        /// refresh towers
        for (Tower *towers in m._towers) {
            CGPoint towPoint = [m.routeMapView convertCoordinate:towers.coord.coordinate toPointToView:m.cocos_view];
            
            [towers setPosition:[[CCDirector sharedDirector] convertToGL:towPoint]];
        }
        
        //refresh projectiles
        for (Projectile *proj in m._projectiles){
            
        }
        
        //refresh homebase
        if(m._prevHomeBasePos !=nil){
            CLLocation *loc = m._prevHomeBasePos; 
            CGPoint basePoint = [m.routeMapView convertCoordinate:loc.coordinate toPointToView:m.cocos_view];
            [[m._gameLayer getHomeBase] setPosition:[[CCDirector sharedDirector] convertToGL:basePoint]];
            [[m._gameLayer getHomeBaseArea] setPosition:[m._gameLayer getHomeBase].position];

        }
        //refresh Enemyhomebase
        if(m._prevEnemyHomeBasePos !=nil){
            CLLocation *loca = m._prevEnemyHomeBasePos; 
            CGPoint basePt = [m.routeMapView convertCoordinate:loca.coordinate toPointToView:m.cocos_view];
            [[m._gameLayer getEnemyHomeBase] setPosition:[[CCDirector sharedDirector] convertToGL:basePt]];
            [[m._gameLayer getEnemyHomeBaseArea] setPosition:[m._gameLayer getEnemyHomeBase].position];
        }
      //  NSLog(@"Matt says moo");
		CGContextStrokePath(context);
       // NSLog(@"quack");
	}
    
}





- (void)setRoutes:(NSArray *)routePoints {
	if (routes != routePoints) {
		[routes release];
		routes = [routePoints retain];
		
		CLLocationDegrees maxLat = -90.0f;
		CLLocationDegrees maxLon = -180.0f;
		CLLocationDegrees minLat = 90.0f;
		CLLocationDegrees minLon = 180.0f;
		
		for (int i = 0; i < self.routes.count; i++) {
			CLLocation *currentLocation = [self.routes objectAtIndex:i];
			if(currentLocation.coordinate.latitude > maxLat) {
				maxLat = currentLocation.coordinate.latitude;
			}
			if(currentLocation.coordinate.latitude < minLat) {
				minLat = currentLocation.coordinate.latitude;
			}
			if(currentLocation.coordinate.longitude > maxLon) {
				maxLon = currentLocation.coordinate.longitude;
			}
			if(currentLocation.coordinate.longitude < minLon) {
				minLon = currentLocation.coordinate.longitude;
			}
		}
		
		MKCoordinateRegion region;
		region.center.latitude     = (maxLat + minLat) / 2;
		region.center.longitude    = (maxLon + minLon) / 2;
		region.span.latitudeDelta  = maxLat - minLat;
		region.span.longitudeDelta = maxLon - minLon;
		
//		[self.inMapView setRegion:region animated:YES];
        DataModel *m = [DataModel getModel];
//        m.routeRegion = region;
        
        if(m.zoom2Region ==true){
            [m.inMapView setCenterCoordinate:region.center zoomLevel:16 animated:YES];
            [[VariableStore vStore] setZoom:16];
        }
        
//        if(m._PlayerNum ==1){
//            [self.inMapView setCenterCoordinate:region.center zoomLevel:12 animated:YES];
//        }
//		[[VariableStore vStore] setZoom:12];
        
        
        //TODO set default zoom level right here
        
         [[VariableStore vStore] setInMapView:(EAGLView*)inMapView];
		[self setNeedsDisplay];
	}
}

@end
