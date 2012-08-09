//
//  GameHUD.h
//  Cocos2D Build a Tower Defense Game
//
//  Created by iPhoneGameTutorials on 4/4/11.
//  Copyright 2011 iPhoneGameTutorial.com All rights reserved.
//

//rau sound
//[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"ButtonSound.mp3"];
//#import "SimpleAudioEngine.h"

#import "cocos2d.h"
#import <MapKit/MapKit.h>
#import "MapDirectionsAppDelegate.h"
#import <UIKit/UIKit.h>
#import "WaveCreationLayer.h"

@class UICRouteOverlayMapView;

@interface MainMenuCocosLayer : CCLayer {
    CCSprite *buttonNewGame;
    CCSprite *buttonNewGame2;
    CCSprite *buttonJoinGame;
    CCSprite *buttonJoinGame2;
    CCSprite *buttonContinueGame;    
    CCSprite *buttonStart;
    CCSprite *buttonStart2;
    CCSprite *buttonOptions;
    CCSprite *buttonCredits;
    CCSprite *buttonCredits2;
    CCSprite *buttonBack;
    CCSprite *buttonBack2;
    CCSprite *buttonBackCredit;
    CCSprite *buttonBackCredit2;
    CCSprite *buttonQuit;
    CCSprite *buttonQuitH;
    CCSprite *BGnewGameLabel;
    
    CCSprite *background;
    CCSprite *zoomIn;
    CCSprite *zoomOut;
    CCSprite *confirmButton;
    CCSprite *confirmBaseButton;
    CCSprite *refreshButton;
    CCSprite *titleGlobalTD;
    CCSprite *buttonSearch;
    CCSprite *buttonGoToMap;
    CCSprite *buttonGoToMap2;
    CCSprite *EndTurnButton;
    CCSprite *sendWaveButton;
    CCSprite *menuButton;
    CCLabelTTF *_label;
    CCLabelTTF *_labelGameName;
    CCLabelTTF *_labelAddress;
    CCSprite * backgroundCredit; 
    CCSprite * backgroundJoin; 
    CCMenuItemFont *item;
    CCMenu *menu;
    CCSprite *one;
    CCSprite * buttonBackfromCreate;
    CCSprite * buttonBackfromJoin;
   // CCLabelTTF *_labelSelGame;   
    WaveCreationLayer * sharedWaveCreationLayer;
     CCSprite *upBG;
   }


- (void)t_Begin:(UITouch *)touch withEvent:(UIEvent *)event;
- (void)t_Moved:(UITouch *)touch withEvent:(UIEvent *)event;
- (void)t_Cancelled:(UITouch *)touch withEvent:(UIEvent *)event;
- (void)t_Ended:(UITouch *)touch withEvent:(UIEvent *)event;

- (void) ChangeToBtn_backCredit2;
- (void) BuildCreditsMenu;
- (void) CleanCreditsMenu;
- (void) ChangeToBtn_quit2;
- (void) ChangeToBtn_search2;
- (void) ChangeToBtn_back2;
- (void) BuildStartMenu;
- (void) BuildMainMenu;
- (void) CleanMainMenu;
- (void) CleanStartMenu;
- (void) CleanUpLayer;
- (void) NewGameFunc;
- (void) JoinGameFunc;
- (void) ContinueGameFunc;
- (void) addHomeBaseUI;
- (void) add_removeRefreshButton;
- (void) add_removeEndTurnButton;
- (void) add_removeOkButton;
- (void) ChangeToBtn_create_game2;
- (void) ChangeToBtn_join_game2;
- (void) ChangeToBtn_options2;
- (void) ChangeToBtn_credits2;
- (void) ChangeToBtn_start2;
- (void) ChangeToBtn_continue2;
- (void) StartFunc;
- (void) OptionsFunc;
- (void) ChangeBackToNormalBtn_search1;
- (void) CreditsFunc;
- (void) actualNewGameFunc;
- (void) add_removesendWaveButton;
- (void) addConfirmButton;
- (void) disableZoomBtn;
-(void) clearGameisOver;
- (void) ChangeToBtn_backfromJoin2;
- (void) AddressSearch2;

+ (MainMenuCocosLayer *)sharedMainMenuCocosLayer;
@end
