//
//  MapDirectionsViewController.h
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//
#import "MapDirectionsAppDelegate.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "UICGDirections.h"
#import "LimitedMapView.h"
#import "cocos2d.h"
#import "GameHUD.h"
#import "NetworkController.h"
#import "JoinGameViewController.h"
//----
//#import "Tower.h"
//#import "Creep.h"
//#import "WayPoint.h"
//#import "Projectile.h"
//#import "Wave.h"
//-----
@class UICRouteOverlayMapView;

@interface MapDirectionsViewController : UIViewController<MKMapViewDelegate, UICGDirectionsDelegate, UIAlertViewDelegate,NetworkControllerDelegate> {
//	MKMapView *routeMapView;
    bool continueGame;
     CCSprite * HomeBase;
	LimitedMapView *routeMapView;
    UICRouteOverlayMapView *routeOverlayView;
	UICGDirections *diretions;
	NSString *startPoint;
	NSString *endPoint;
	NSArray *wayPoints;
    NSArray *rPoints;
	UICGTravelModes travelMode;
    CCDirector *director;
    //UIView *contentView;
    NSUInteger coord;
    //EAGLView *cocos_view; 
    UIBarButtonItem *chooseAreaButton;
    int playerNumber;
    NSString *playerName;
    UITextField *inputF;
    UITextField *inputAddress;
    JoinGameViewController *controller;
    NSString *address;
    NSString *adressForSearch;
    bool searchTouched;
    
}

@property (nonatomic, retain) UITextField *inputF;
@property (nonatomic, retain) NSString *startPoint;
@property (nonatomic, retain) NSString *endPoint;
@property (nonatomic, retain) NSArray *wayPoints;
@property (nonatomic, retain) NSArray *rPoints;
@property (nonatomic,assign) bool continueGame;
@property (nonatomic,assign) bool searchTouched;
@property (nonatomic) UICGTravelModes travelMode;
@property (nonatomic, assign) UICGDirections *diretions;
@property (nonatomic,assign) NSString *address;

//@property (nonatomic,retain) EAGLView *cocos_view;
- (void)update;
- (void) hideKeyboard;
- (NSString *) saveFilePath;
- (NSString *) saveFilePathForHomeBase;
- (void) readString:(NSString*)str;
- (void) makeRealRoute;
- (void) refreshServer;
- (void) zoomIn;
- (void) zoomOut;
- (void) choosingArea;
- (void) confirmBase;
- (void) refresh;
- (void) endTurn;
- (void) GettingStarted;
- (void) startDelegate;
- (void) enableInputText;
- (void) callJoinViewController;
- (void) goToAddress;
- (void) parseHB;
- (void) parseTowers;
-(void) setupMap;
-(void) parseCreeps;
- (void) removeInputText;
- (void) removeJoinViewController;
-(void) callStats;
-(void) disableScrolling;
//- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark;
@end
