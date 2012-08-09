//
//  MapDirectionsAppDelegate.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright KISHIKAWA Katsumi 2009. All rights reserved.
//

#import "MapDirectionsAppDelegate.h"
#import "CreateGameViewController.h"
#import "HelloWorldScene.h"
#import "DataModel.h"
#import "SaveAndRestoreViewController.h"
#import <UIKit/UIKit.h>
#import "MainMenuCocosLayer.h"


@implementation MapDirectionsAppDelegate

@synthesize window;
@synthesize viewController;


#pragma mark -
#pragma mark Application lifecycle

//- (void) applicationWillTerminate:(UIApplication *)application{
//    [navigationController saveState];
//}

//- (BOOL)applicationShouldLaunch:(UIApplication *)application errorDescription:(NSString**)errorString
//{   
//    sleep(20);
//    
//    return TRUE;
//}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
//    [viewController restoreState];
    DataModel *m = [DataModel getModel];
    
    contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[viewController setView:contentView];
    //--Rau
//    UIView *towerMenuView = [[UIView alloc] initWithFrame:CGRectMake(220.0f, 0.0f, 100.0f, 500.0f)];
//	[contentView addSubview:towerMenuView];
//    m.towerMenuView = towerMenuView;
//   towerMenuView.userInteractionEnabled=NO;
    

   // NSLog(@"appdeleg");
    //---
    
    
	[window addSubview:[viewController view]];
    [window makeKeyAndVisible];
    m.windowT = window; 
    m._MapDirectionsViewController = viewController;
	
    cocosView = [EAGLView viewWithFrame:[[UIScreen mainScreen] bounds]   
                               pixelFormat:kEAGLColorFormatRGBA8 // RGBA8 color buffer                                   
                               depthFormat:0 ];//you don't need a depth buffer prob
    cocosView.opaque = NO;
    [[CCDirector sharedDirector] setOpenGLView:cocosView];
    glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
    glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    [CCDirector sharedDirector].openGLView.backgroundColor = [UIColor clearColor];
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    [contentView addSubview:cocosView];
    // [[CCDirector sharedDirector] setDisplayFPS:true];
    CCScene *scene = [CCScene node];
    
    HelloWorld *layer = [HelloWorld node];
    [scene addChild: layer z:1];
    
    MainMenuCocosLayer *MainMenuLayer = [MainMenuCocosLayer node];
    [scene addChild: MainMenuLayer z:4];    
        
    

    
    m._gameLayer = layer;
    m._MainMenuCocosLayer = MainMenuLayer;
    m.cocos_view = cocosView;
    m._cocosScene = scene;

    //----
    
    cocosView.userInteractionEnabled= NO;
    [[CCDirector sharedDirector] runWithScene:scene];
    //

    
	//[[CCDirector sharedDirector] setDeviceOrientation:kCCDeviceOrientationLandscapeRight]; 
[m._MapDirectionsViewController GettingStarted];
}

-(void) cleanView
{
    DataModel *m=[DataModel getModel];
   // [contentView removeFromSuperview];
  //  [m.towerMenuView removeFromSuperview];
   // [towerMenuView removeFromSuperview];
    //[viewController removeFromParentViewController];
    // towerMenuView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f)];
}
    
////---Rau----
//   // [window addSubview:viewController.view];
//     
//	CLLocationCoordinate2D coord;
//	coord.longitude =-118.289248;//wp -118.28399000;//dom -118.289248;//desert -117.566586;//park -118.539734;//lake -115.794525;// usc -118.284302;
//	coord.latitude = 34.029616;//wp 34.02376000;//dom 34.029616;//desert 35.328851;//park 36.310699;//lake 33.292656;//usc 34.024636;
//    
//	MKReverseGeocoder *geocoder = [[MKReverseGeocoder alloc] initWithCoordinate:coord];
//	[geocoder setDelegate:self];
//	[geocoder start];    
//    
//    

//
////---Rau--
//
//- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
//{
//  // NSLog(@"The geocoder has returned: %@", [placemark addressDictionary]);
//   //   NSLog(@"The geocoder has returned: %@", [placemark thoroughfare]);
//     NSLog(@"The geocoder has returned: %@", [placemark description]);
//}
//
//- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
//{
//    NSLog(@"Error no address here");
//}
////-------


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [cocosView release];
	[viewController release];
	[window release];
    [contentView release];
	[super dealloc];
}

@end

