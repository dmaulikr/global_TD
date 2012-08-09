//
//  HelloWorldLayer.h
//  DragDrop
//
//  Created by Ray Wenderlich on 11/15/10.
//  Copyright Ray Wenderlich 2010. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import <MapKit/Mapkit.h>
#import "cocos2d.h"
#import "GameHUD.h"
#import "DataModel.h"
#import "Tower.h"
#import "Creep.h"
#import "WayPoint.h"
#import "Projectile.h"
#import "Wave.h"
#import "LimitedMapView.h"
#import "CCRadioMenu.h"
#import <UIKit/UIKit.h>
#import "TowerSelectMenu.h"


@interface HelloWorld : CCLayer
{ 
    
	CCTMXLayer *_background;
	CCSprite * HomeBase;
	CCSprite * HomeBaseArea;
    CCSprite * AddAreaTower;
    CCSprite * EnemyHomeBase;
	CCSprite * EnemyHomeBaseArea;
    NSMutableArray * LinePoints;
    CCSprite * selSprite;
    NSMutableArray * movableSprites;
	CCSprite * tower;
	CCSprite * selSpriteRange;
    GameHUD * gameHUD;
    CCSprite *one;

    int _currentLevel;
    int creepIndex;
    bool towerSelected;
  //TowerSelectMenu *controller;
}

@property (nonatomic, retain) CCTMXLayer *background;
@property (nonatomic, assign) int currentLevel;


+ (id) scene;
- (void)addWaypoint;
-(void)addWaves:(int) total_creeps; 
-(void)addTower: (CGPoint)pos, playerID,type_id; 
- (BOOL) canBuildOnTilePosition:(CGPoint) pos;
- (void) keepPositions:(LimitedMapView*) arr;
- (void) keepProjectilesPos:(LimitedMapView*)arr;
- (void) keepHomeBasePos:(LimitedMapView*) arr;
- (void) keepEnemyHomeBasePos:(LimitedMapView*) arr;
- (void) addBear;


- (CCSprite*) getHomeBase;
- (CCSprite*) getHomeBaseArea;
- (CCSprite*) getEnemyHomeBase;
- (CCSprite*) getEnemyHomeBaseArea;
-(void)addHomeBase: (CGPoint)pos; 
-(void)addEnemyHomeBase: (CGPoint)pos;
-(void)removeHBs;


- (void)t_Begin:(UITouch *)touch withEvent:(UIEvent *)event;
- (void)t_Moved:(UITouch *)touch withEvent:(UIEvent *)event;
- (void)t_Cancelled:(UITouch *)touch withEvent:(UIEvent *)event;
- (void)t_Ended:(UITouch *)touch withEvent:(UIEvent *)event;

-(void) HomeBaseZoomIn;
-(void) HomeBaseZoomout;
@end
