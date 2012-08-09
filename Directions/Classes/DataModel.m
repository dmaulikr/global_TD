//
//  DataModel.m
//  Cocos2D Build a Tower Defense Game
//
//  Created by iPhoneGameTutorials on 4/4/11.
//  Copyright 2011 iPhoneGameTutorial.com All rights reserved.
//

#import "DataModel.h"
#import "HelloWorldScene.h"
@implementation DataModel
@synthesize game_state;
@synthesize _PlayerNum;
@synthesize _gameLayer;
@synthesize _gameHUDLayer;
@synthesize _MainMenuCocosLayer;
@synthesize _cocosScene;
@synthesize _WaveCreationUIlayer;
@synthesize _projectiles;
@synthesize _towers;
@synthesize _towersRange;
@synthesize _MapDirectionsAppDelegate;
@synthesize gameover;
@synthesize parsingTower;
@synthesize _targets;
@synthesize _towersToSend;
@synthesize _waypoints;
@synthesize _MapDirectionsViewController;
@synthesize _joinViewController;
@synthesize VIP=_VIP;
@synthesize _waves;
@synthesize _gestureRecognizer;
@synthesize _touchInGameLayer;
@synthesize cocos_view;
@synthesize inMapView;
@synthesize routeMapView;
@synthesize coord_begin;
@synthesize coord_end;
@synthesize _wayPointsFromMap;
@synthesize extraArea;
@synthesize _prevTarPos;
@synthesize _prevProPos; 
@synthesize _prevHomeBasePos;
@synthesize _prevEnemyHomeBasePos;
@synthesize _server;
@synthesize outputReady;
@synthesize outputString;
@synthesize _creepsOrder;
@synthesize _creepsEnemyOrder;
@synthesize _BusNum;
@synthesize _DoctorNum;
@synthesize continueList;
@synthesize creepsSent;
@synthesize HomeBaseTouchEnable_HUD; 
@synthesize HomeBaseTouchEnable_GameLayer; 

@synthesize sessionID;
@synthesize playerID;
@synthesize hb_lat;
@synthesize hb_lon;
@synthesize hb_player;
@synthesize t_lat;
@synthesize t_lon;
@synthesize t_player;
@synthesize c_type;
@synthesize c_player;
@synthesize gold_value;
@synthesize gold_player;

@synthesize gold;
@synthesize totalIncome;
@synthesize baseHealth;
@synthesize EnemyBaseHealth;

@synthesize towerMenuView;
@synthesize windowT;
@synthesize joinList;
//@synthesize routeRegion;
@synthesize zoom2Region;

@synthesize startWatchMyAttack;
@synthesize tempBoo;
@synthesize stopWave;
@synthesize t_type;
@synthesize moveScale;
static DataModel *_sharedContext = nil;

+(DataModel*)getModel 
{
	if (!_sharedContext) {
		_sharedContext = [[self alloc] init];
	}
	
	return _sharedContext;
}

-(void)encodeWithCoder:(NSCoder *)coder {
    
}

-(id)initWithCoder:(NSCoder *)coder {
    
	return self;
}

- (id) init
{
	if ((self = [super init])) {
        _targets = [[NSMutableArray alloc] init];
        _towersToSend = [[NSMutableArray alloc] init];
		_projectiles = [[NSMutableArray alloc] init];
		_waypoints = [[NSMutableArray alloc] init];
	   _prevProPos = [[NSMutableArray alloc] init];
       _creepsOrder= [[NSMutableArray alloc] init];
        _creepsEnemyOrder= [[NSMutableArray alloc] init];
		_waves = [[NSMutableArray alloc] init];
		_towers = [[NSMutableArray alloc] init];
        _towersRange= [[NSMutableArray alloc] init];
        _prevTarPos = [[NSMutableArray alloc] init];
        _wayPointsFromMap= [[NSMutableArray alloc] init];
             extraArea= [[NSMutableArray alloc] init];
        _server = [NetworkController sharedInstance] ;
        [_server connect];
        outputReady = NO;
        game_state = 1;
        tempBoo = true;
        startWatchMyAttack=false;
        zoom2Region = false;
        stopWave = false;
        parsingTower=false;
        gameover=false;
        gold = 20;
        totalIncome=10;
        creepsSent=0;
	}
	return self;
}

- (void)dealloc {
	
	self._gameLayer = nil;
	self._gameHUDLayer = nil;
    self._MainMenuCocosLayer = nil;
    self._cocosScene = nil;
    self.towerMenuView=nil;
    self._WaveCreationUIlayer = nil;
	self._gestureRecognizer = nil;
    self._touchInGameLayer = nil;
    self._MapDirectionsViewController = nil;
    self._MapDirectionsAppDelegate=nil;
    self._joinViewController=nil;
	 self.cocos_view = nil;
    self.inMapView= nil;
    self.routeMapView = nil;
    self.HomeBaseTouchEnable_HUD = nil;
    self.HomeBaseTouchEnable_GameLayer = nil;
    self._prevHomeBasePos = nil;
    self._prevEnemyHomeBasePos = nil;
    self.outputReady = nil;
    self.outputString = nil;
    self.game_state = 0;
    self._BusNum = 0;
    self._DoctorNum = 0;
    [_server disconnect];
    [_server release];
    self._server = nil;
    
    [continueList release];
    self.continueList = nil;
    
    [c_player release];
    self.c_player = nil;
    [c_type release];
    self.c_type = nil;
    
    [hb_player release];
    self.hb_player = nil;
    [hb_lon release];
    self.hb_lon = nil;
    [hb_lat release];
    self.hb_lat = nil;
    
    [t_type release];
    self.t_type = nil;
    [t_player release];
    self.t_player = nil;
    [t_lon release];
    self.t_lon = nil;
    [t_lat release];
    self.t_lat = nil;
    
    [sessionID release];
    self.sessionID = nil;
    
    [playerID release];
    self.playerID = nil;

   [_wayPointsFromMap release];
    self._wayPointsFromMap = nil;
    
    [extraArea release];
    self.extraArea = nil;
    
    [_creepsOrder release];
    self._creepsOrder = nil;

    [_creepsEnemyOrder release];
    self._creepsEnemyOrder = nil;
    
    [_prevTarPos release];
    self._prevTarPos = nil;
    
    [_prevProPos release];
    self._prevProPos = nil;
    
    [_projectiles release];
	_projectiles = nil;
	[_towers release];
	_towers = nil;
	
    [_towersRange release];
	_towersRange = nil;
    
	[_targets release];
	_targets = nil;	
	
    [_towersToSend release];
	_towersToSend = nil;	
    
	[_waypoints release];
	_waypoints = nil;
    
	[_waves release];
	_waves = nil;	
    
    [joinList release];
    joinList = nil;
    
	[super dealloc];
}

@end
