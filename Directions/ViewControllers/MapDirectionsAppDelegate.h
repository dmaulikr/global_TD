//
//  MapDirectionsAppDelegate.h
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright KISHIKAWA Katsumi 2009. All rights reserved.
//
#import "cocos2d.h"

@class TouchCapturingWindow;
@class MapDirectionsViewController;
@interface MapDirectionsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    //MainMenuViewComtroller *viewController;
    UIViewController *viewController;
    UIViewController *saveAndRestoreController;
    UIView *contentView;
    EAGLView *cocosView;
    UIView *towerMenuView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
//@property (nonatomic, retain) IBOutlet MainMenuViewComtroller *viewController;
@property (nonatomic, retain) IBOutlet UIViewController *viewController;
-(void) cleanView;
@end

