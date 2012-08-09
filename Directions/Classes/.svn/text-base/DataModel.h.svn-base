
#import "cocos2d.h"
#import "WildcardGestureRecognizer.h"
#import <MapKit/MapKit.h>
#import "LimitedMapView.h"
#import "NetworkController.h"
#import "TowerSelectMenu.h"
//#import "MapDirectionsViewController.h"

@class HelloWorld;
@class GameHUD;
@class WaveCreationLayer;
@class MainMenuCocosLayer;
@class MapDirectionsViewController;
@class JoinGameViewController;
@class MapDirectionsAppDelegate;

@interface DataModel :NSObject <NSCoding>  {
	HelloWorld *_gameLayer;
	GameHUD *_gameHUDLayer;
    MainMenuCocosLayer *_MainMenuCocosLayer;
    CCScene *_cocosScene;
	WaveCreationLayer *_WaveCreationUIlayer;

    
    
    bool HomeBaseTouchEnable_HUD;
    bool HomeBaseTouchEnable_GameLayer;
    float VIP;
    NSMutableArray *_wayPointsFromMap;
    
    int _PlayerNum;
     int _BusNum;
     int _DocotorNum;
    NetworkController *_server;
    NSMutableArray *_projectiles;
	NSMutableArray *_towers;
    NSMutableArray *_towersRange;
    NSMutableArray *_targets;	
    NSMutableArray * _towersToSend;
	NSMutableArray *_waypoints;	
    NSMutableArray *_prevProPos; 
    NSMutableArray *_creepsOrder;	
    NSMutableArray *_creepsEnemyOrder;	
     CLLocation *_prevHomeBasePos; 
    CLLocation *_prevEnemyHomeBasePos;
    NSMutableArray *_prevTarPos;
  
	NSMutableArray *_waves;	
	UIPanGestureRecognizer *_gestureRecognizer;
    UITouch *_touchInGameLayer;
    MapDirectionsViewController * _MapDirectionsViewController;
    JoinGameViewController *_joinViewController;
    MapDirectionsAppDelegate *_MapDirectionsAppDelegate;
    EAGLView *cocos_view; 
    MKMapView *inMapView;
    LimitedMapView *routeMapView;
    UIView *towerMenuView; 
    
    CLLocationCoordinate2D coord_begin;
    CLLocationCoordinate2D coord_end;
    bool outputReady;
    bool stopWave;
    NSString *outputString;
    int game_state;
    
      UIWindow *windowT;
    NSArray *joinList;
    NSArray *continueList;
    bool zoom2Region;
    NSString *sessionID;
    NSString *playerID;
    NSArray *hb_lat;
    NSArray *hb_lon;
    NSArray *hb_player;
    NSArray *t_type;
    NSArray *t_lat;
    NSArray *t_lon;
    NSArray *t_player;
    NSArray *c_type;
    NSArray *c_player;
    NSArray *gold_value;
    NSArray *gold_player;

    bool startWatchMyAttack;
    bool tempBoo;
    bool gameover;
    bool parsingTower;
    int gold;
    int creepsSent;
    float baseHealth;
    float EnemyBaseHealth;
    float moveScale;
    NSMutableArray * extraArea;
//    MKCoordinateRegion routeRegion;
    int totalIncome;
    
}
//@property(nonatomic,assign) MKCoordinateRegion routeRegion;
@property(nonatomic,retain) NSArray *gold_value;
@property(nonatomic,retain) NSArray *gold_player;
@property(nonatomic, retain) NSArray* t_type;
@property(nonatomic,assign) bool tempBoo;
@property(nonatomic,assign) bool parsingTower;
@property(nonatomic,assign) bool gameover;

@property(nonatomic,assign) int gold;
@property(nonatomic,assign) int creepsSent;
@property(nonatomic,assign) int totalIncome;
@property(nonatomic,assign) float baseHealth;
@property(nonatomic,assign) float EnemyBaseHealth;
@property(nonatomic,assign) float moveScale;
@property(nonatomic,retain) NSArray *c_player;
@property(nonatomic,retain) NSArray *c_type;
@property(nonatomic,retain) NSArray *t_lat;
@property(nonatomic,retain) NSArray *t_lon;
@property(nonatomic,retain) NSArray *t_player;
@property(nonatomic,retain) NSArray *hb_lat;
@property(nonatomic,retain) NSArray *hb_lon;
@property(nonatomic,retain) NSArray *hb_player;
@property(nonatomic,retain) NSMutableArray * extraArea;
@property(nonatomic, retain) NSString *sessionID;
@property(nonatomic, retain) NSString *playerID;

@property(nonatomic, assign) bool zoom2Region;
@property(nonatomic, assign) bool stopWave;
@property(nonatomic, retain) NSArray *continueList;
@property(nonatomic, retain) NSArray *joinList;
@property (nonatomic, retain) IBOutlet UIWindow *windowT;
@property(nonatomic, assign) int game_state;

@property(nonatomic,assign) bool outputReady;
@property(nonatomic, retain) NSString *outputString;
@property(nonatomic, retain) NetworkController* _server;
@property (nonatomic, assign) bool HomeBaseTouchEnable_HUD;
@property (nonatomic, assign) bool HomeBaseTouchEnable_GameLayer;

@property (nonatomic, assign) float VIP;
@property (nonatomic, assign) int _PlayerNum;
@property(nonatomic, assign) int _BusNum;
@property(nonatomic, assign) int _DoctorNum;
@property (nonatomic, retain) HelloWorld *_gameLayer;
@property (nonatomic, retain) GameHUD *_gameHUDLayer;
@property (nonatomic, retain) MainMenuCocosLayer *_MainMenuCocosLayer;
@property (nonatomic, retain) CCScene *_cocosScene;
@property (nonatomic, retain) UIView *towerMenuView; 

@property (nonatomic, retain) WaveCreationLayer *_WaveCreationUIlayer;

@property (nonatomic, retain) NSMutableArray *_wayPointsFromMap;
@property (nonatomic, retain) NSMutableArray * _projectiles;
@property (nonatomic, retain) NSMutableArray * _towers;
@property (nonatomic, retain) NSMutableArray *_towersRange;
@property (nonatomic, retain) NSMutableArray * _targets;
@property (nonatomic, retain) NSMutableArray * _towersToSend;
@property (nonatomic, retain) NSMutableArray * _waypoints;
@property (nonatomic, retain) NSMutableArray *_prevProPos;
@property(nonatomic, retain) CLLocation *_prevHomeBasePos; 
@property(nonatomic, retain) CLLocation *_prevEnemyHomeBasePos; 
@property(nonatomic, retain) NSMutableArray *_prevTarPos;
@property(nonatomic, retain) NSMutableArray *_creepsOrder;
@property(nonatomic, retain) NSMutableArray *_creepsEnemyOrder;

@property (nonatomic, retain) NSMutableArray * _waves;
@property (nonatomic, retain) UIPanGestureRecognizer *_gestureRecognizer;
@property (nonatomic, retain) UITouch *_touchInGameLayer;
@property (nonatomic, retain) MapDirectionsViewController * _MapDirectionsViewController;
@property (nonatomic, retain) JoinGameViewController *_joinViewController;
@property (nonatomic, retain) MapDirectionsAppDelegate *_MapDirectionsAppDelegate;

@property (nonatomic, retain) EAGLView *cocos_view; 
@property (nonatomic, retain) MKMapView *inMapView;
@property (nonatomic, retain) LimitedMapView *routeMapView;
@property (nonatomic, assign) CLLocationCoordinate2D coord_begin;
@property (nonatomic, assign) CLLocationCoordinate2D coord_end;
@property (nonatomic, assign) bool startWatchMyAttack;
+ (DataModel*)getModel;

@end
