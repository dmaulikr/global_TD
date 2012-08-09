
#import "cocos2d.h"

#import "DataModel.h"
#import "WayPoint.h"
//#import "GameHUD.h"
@interface Creep : CCSprite {
    int _curHp;
	float _moveDuration;
	int _curWaypoint;
    CCProgressTimer *healthBar;
    int _totalHp;
   float firstDistance;
    int _lastWaypoint;
    int type;
//GameHUD * gameHUD;
    
    //sam
    CGPoint prev_loc;
}

@property (nonatomic, assign) int hp;
@property (nonatomic, assign) float moveDuration;
@property (nonatomic, assign) int curWaypoint;
@property (nonatomic, assign) CGPoint prev_loc;
@property (nonatomic, assign) CCProgressTimer *healthBar;
@property (nonatomic, assign) int _totalHp;
@property (nonatomic, assign) int lastWaypoint;
@property (nonatomic, assign) int type;

//- (Creep *) initWithCreep:(Creep *) copyFrom; 
- (WayPoint *)getCurrentWaypoint;
- (WayPoint *)getNextWaypoint;
- (WayPoint *)getPreviousWaypoint;
- (WayPoint *)getLastWaypoint;
- (float)getVelocity:(Creep *)creep;
- (float) moveDurScale;
-(void) zoomBusCreeps;
-(void) zoomDoctorCreeps;
-(void) zoomGrandmaCreeps;
@end

@interface FastRedCreep : Creep {
}
+(id)creep;
@end

@interface StrongGreenCreep : Creep {
}
+(id)creep;
@end
@interface GrandmaCreep: Creep {
}
+(id) creep;
@end
