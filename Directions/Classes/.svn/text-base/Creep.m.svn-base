

#import "Creep.h"
#import "Wave.h"
#import "VariableStore.h"
@implementation Creep

@synthesize hp = _curHp;
@synthesize moveDuration = _moveDuration;
@synthesize curWaypoint = _curWaypoint;
@synthesize  prev_loc;
@synthesize healthBar;
@synthesize _totalHp;
@synthesize lastWaypoint = _lastWaypoint;
@synthesize type;



- (WayPoint *)getPreviousWaypoint{
	WayPoint *waypoint; 
	DataModel *m = [DataModel getModel];
    
    
    //watch enemy attacking your base
    if (m.startWatchMyAttack==false){
    
                //the player who created the game
            if ([m.playerID isEqualToString:[m.hb_player objectAtIndex:1]])
            {
            waypoint = (WayPoint *) [m._waypoints objectAtIndex:self.curWaypoint-1];
            }
            else 
            { //the player who joined the game
               waypoint = (WayPoint *) [m._waypoints objectAtIndex:self.curWaypoint+1];
            } 
    }
     
//    watch your creeps attcking enemy base
    //vot eto meniala
    
    if (m.startWatchMyAttack==true){
        
        //the player who created the game
        if ([m.playerID isEqualToString:[m.hb_player objectAtIndex:0]])
        {
            waypoint = (WayPoint *) [m._waypoints objectAtIndex:self.curWaypoint-1];
        }
        else 
        { //the player who joined the game
            waypoint = (WayPoint *) [m._waypoints objectAtIndex:self.curWaypoint+1];
        } 
    }
    
//    NSLog(@"cur way point=%d",self.curWaypoint);
	return waypoint;
}

- (WayPoint *)getCurrentWaypoint{
	
	DataModel *m = [DataModel getModel];
    WayPoint *waypoint;

    waypoint = (WayPoint *) [m._waypoints objectAtIndex:self.curWaypoint];

	 //NSLog(@"cur way point=%d", self.curWaypoint);
	return waypoint;
}

- (WayPoint *)getNextWaypoint{
	
	DataModel *m = [DataModel getModel];
    WayPoint *waypoint;
   // gameHUD = [GameHUD sharedHUD];
    //watch enemy attacking your base
    if (m.startWatchMyAttack==false){
        
                if (![m.playerID isEqualToString:[m.hb_player objectAtIndex:1]])
                {
                    self.curWaypoint--;
                    
                    if (self.curWaypoint < 0){
                        self.curWaypoint++;
                        
                        
                      if ( m.baseHealth > 0) {
                            [m._gameHUDLayer updateBaseHp:-10];
                       }
                        Creep *target = (Creep *) self;
                        
                        NSMutableArray *endtargetsToDelete = [[NSMutableArray alloc] init];
                        [endtargetsToDelete addObject:target];
                        Wave * wave = [m._gameLayer getCurrentWave];
                        wave.aliveCreeps--;
                        
                        for (CCSprite *target in endtargetsToDelete) {
                            [self.parent removeChild:healthBar cleanup:YES];
                            [m._targets removeObject:target];
                            [self.parent removeChild:target cleanup:YES];
                        }
                        return NULL;
                    }
                   waypoint = (WayPoint *) [m._waypoints objectAtIndex:self.curWaypoint];

                }
                else{
                
                        self.curWaypoint++;
                        
                        if (self.curWaypoint >= m._waypoints.count){
                            self.curWaypoint--;
                            
                            if ( m.baseHealth > 0) {
                                [m._gameHUDLayer updateBaseHp:-10];
                            }
                            Creep *target = (Creep *) self;
                            
                            NSMutableArray *endtargetsToDelete = [[NSMutableArray alloc] init];
                            [endtargetsToDelete addObject:target];
                            Wave * wave = [m._gameLayer getCurrentWave];
                            wave.aliveCreeps--;
                            
                            for (CCSprite *target in endtargetsToDelete) {
                                [self.parent removeChild:healthBar cleanup:YES];
                                [m._targets removeObject:target];
                                [self.parent removeChild:target cleanup:YES];
                                
                            }
                            return NULL;
                        }
                        
                        // NSLog(@"l cur way point=%d",self.curWaypoint);
                    waypoint = (WayPoint *) [m._waypoints objectAtIndex:self.curWaypoint];
                }   
    }
        
    //watch your creeps attacking enemy base
    if (m.startWatchMyAttack==true){
        
                if (![m.playerID isEqualToString:[m.hb_player objectAtIndex:0]])
                {
                    self.curWaypoint--;
                    
                    if (self.curWaypoint < 0){
                        self.curWaypoint++;
                        
                        if ( m.EnemyBaseHealth > 0) {
                            [m._gameHUDLayer updateEnemyBaseHp:-10];
                        }
                        Creep *target = (Creep *) self;
                        
                        NSMutableArray *endtargetsToDelete = [[NSMutableArray alloc] init];
                        [endtargetsToDelete addObject:target];
                        Wave * wave = [m._gameLayer getCurrentWave];
                        wave.aliveCreeps--;
                       
                        for (CCSprite *target in endtargetsToDelete) {
                            [self.parent removeChild:healthBar cleanup:YES];
                            [m._targets removeObject:target];
                            [self.parent removeChild:target cleanup:YES];
                        }
                        return NULL;
                    }
                    waypoint = (WayPoint *) [m._waypoints objectAtIndex:self.curWaypoint];
                    
                }
                else{
                    
                    self.curWaypoint++;
                    
                    if (self.curWaypoint >= m._waypoints.count){
                        self.curWaypoint--;
                        
                        if ( m.EnemyBaseHealth > 0) {
                            [m._gameHUDLayer updateEnemyBaseHp:-10];
                        }
                        Creep *target = (Creep *) self;
                        
                        NSMutableArray *endtargetsToDelete = [[NSMutableArray alloc] init];
                        [endtargetsToDelete addObject:target];
                        Wave * wave = [m._gameLayer getCurrentWave];
                        wave.aliveCreeps--;
                        [self removeChild:healthBar cleanup:YES];
                        for (CCSprite *target in endtargetsToDelete) {
                            [self.parent removeChild:healthBar cleanup:YES];
                            [m._targets removeObject:target];
                            [self.parent removeChild:target cleanup:YES];
                        }
                        return NULL;
                    }
                    
                    // NSLog(@"l cur way point=%d",self.curWaypoint);
                    waypoint = (WayPoint *) [m._waypoints objectAtIndex:self.curWaypoint];
                }   
    }
        
        
        
	return waypoint;
}

-(float)getVelocity:(Creep *)creep{
//    float dur = (float)creep.moveDuration;
//    WayPoint *wp1 = creep.getCurrentWaypoint;
//    WayPoint *wp2 = creep.getNextWaypoint;
//   
//    creep.curWaypoint = creep.curWaypoint -1;
//    DataModel *m=[DataModel getModel];
//    CGPoint tarPoint1 = [m.routeMapView convertCoordinate:wp1.coord toPointToView:m.cocos_view];
//    CGPoint tarPoint2 = [m.routeMapView convertCoordinate:wp2.coord toPointToView:m.cocos_view];
//    
//    //float dist = sqrtf(exp2(wp1.coord.latitude - wp2.coord.latitude)  + exp2(wp1.coord.longitude - wp2.coord.longitude));
//    float dist = sqrtf(exp2(tarPoint2.x - tarPoint1.x)  + exp2(tarPoint2.y - tarPoint1.y));
//    
//    float vel = 5*dist/ dur;
//    NSLog(@"getVelocity output = %f", vel);
//
//    return vel;
    return .5;//3;
}

- (float) moveDurScale
{
    
    DataModel *m = [DataModel getModel];
    WayPoint *waypoint0;
    WayPoint *waypoint1;
    WayPoint *waypoint2;
    WayPoint *waypoint3;
     
  if (m.startWatchMyAttack==false)
  {
       if ([m.playerID isEqualToString:[m.hb_player objectAtIndex:0]])
       { 
           waypoint2 = (WayPoint *) [m._waypoints objectAtIndex:(self.curWaypoint+1)];
           waypoint3 = (WayPoint *) [m._waypoints objectAtIndex:(self.curWaypoint)];      
       }
      else 
      { 
          //NSLog(@"id==1, wp==0 F");
         // waypoint0 = (WayPoint *) [m._waypoints objectAtIndex:0];
         // waypoint1 = (WayPoint *) [m._waypoints objectAtIndex:1];
         // firstDistance = ccpDistance(waypoint0.position, waypoint1.position);    
          //  NSLog(@"id1 wp0f curWaypoint=%d",self.curWaypoint);
          waypoint2 = (WayPoint *) [m._waypoints objectAtIndex:(self.curWaypoint-1)];
          waypoint3 = (WayPoint *) [m._waypoints objectAtIndex:(self.curWaypoint)];

          
      }
  
  }
    else
    {
        if ([m.playerID isEqualToString:[m.hb_player objectAtIndex:1]])
        {    
        
            waypoint2 = (WayPoint *) [m._waypoints objectAtIndex:(self.curWaypoint+1)];
            waypoint3 = (WayPoint *) [m._waypoints objectAtIndex:(self.curWaypoint)];  
        }
        else
        { 
        
            waypoint2 = (WayPoint *) [m._waypoints objectAtIndex:(self.curWaypoint-1)];
            waypoint3 = (WayPoint *) [m._waypoints objectAtIndex:(self.curWaypoint)];
        }
    }
    
    waypoint0 = (WayPoint *) [m._waypoints objectAtIndex:0];
    waypoint1 = (WayPoint *) [m._waypoints objectAtIndex:1];
    firstDistance = 5;//ccpDistance(waypoint0.position, waypoint1.position); 
    
     float thisDistance = ccpDistance(waypoint2.position, waypoint3.position);
      //float moveScale = thisDistance/firstDistance;   
    m.moveScale = thisDistance/firstDistance;  
    
    return (self.moveDuration * m.moveScale);
}

-(void)creepLogic:(ccTime)dt {
	 
	
	// Rotate creep to face next waypoint
	WayPoint *waypoint = [self getPreviousWaypoint];
    //If traveling from right to left, flip across the Yaxis maybe use sprite.scaleY *= -1; 
//	if(self.position.x > waypoint.position.x)
//    {
//        self.flipY;
//    }
	CGPoint waypointVector = ccpSub(waypoint.position, self.position);
	CGFloat waypointAngle = ccpToAngle(waypointVector);
	CGFloat cocosAngle = CC_RADIANS_TO_DEGREES(-1 * waypointAngle);
	
	float rotateSpeed = 0.1 / M_PI; // 1/2 second to roate 180 degrees
	float rotateDuration = fabs(waypointAngle * rotateSpeed);    
	
    [self runAction:[CCSequence actions:
                         [CCRotateTo actionWithDuration:rotateDuration angle:cocosAngle],
                         nil]];		

 
}

-(void)healthBarLogic:(ccTime)dt {
    
    //Update health bar pos and percentage.
    healthBar.position = ccp(self.position.x, (self.position.y+20));
    healthBar.percentage = ((float)self.hp/(float)self._totalHp) *100;
    
    if (healthBar.percentage <= 0) {
        [self removeChild:healthBar cleanup:YES];
    }
}
- (WayPoint *)getLastWaypoint{
	
	DataModel *m = [DataModel getModel];
    
	self.lastWaypoint = self.curWaypoint -1;
	
	WayPoint *waypoint = (WayPoint *) [m._waypoints objectAtIndex:self.lastWaypoint];
	
	return waypoint;
}
@end

@implementation FastRedCreep

+ (id)creep {
    DataModel *m = [DataModel getModel];
    
      FastRedCreep *creep = nil;
    if ((creep = [[[super alloc] initWithFile:@"bus_top.png"] autorelease])) {
      
        creep.hp = 100;
        creep.moveDuration = 0.15;//0.5
         creep.scale=0.5;
            //watch enemy attacking your base
            if (m.startWatchMyAttack==false){
                    if ([m.playerID isEqualToString:[m.hb_player objectAtIndex:1]])
                    {   creep.curWaypoint = 0;
                    }
                    else{  //creep.scaleX = -1;
                      creep.curWaypoint = m._waypoints.count-1;
                    }
            }
            //watch your creeps attacking enemy base
            if (m.startWatchMyAttack==true){
                if ([m.playerID isEqualToString:[m.hb_player objectAtIndex:0]])
                {   creep.curWaypoint = 0;
                }
                else{ // creep.scaleX = -1;
                    creep.curWaypoint = m._waypoints.count-1;
                }
            }
            
        }
    
    
                    if  ([[VariableStore vStore] getZoom]==12 )
                    { 
                        creep.scale=0.5;
                                            }  
                    else if  ([[VariableStore vStore] getZoom]==13 )    
                    { 
                        creep.scale=1;
                       
                    }  
                    else if  ([[VariableStore vStore] getZoom]==14 )    
                    { 
                        creep.scale=2;
                        
                    }     

    
    
    creep._totalHp = creep.hp;
    [creep schedule:@selector(healthBarLogic:)];

	[creep schedule:@selector(creepLogic:) interval:0.2];

    return creep;
}

@end

@implementation StrongGreenCreep

+ (id)creep {
        DataModel *m = [DataModel getModel];
    StrongGreenCreep *creep = nil;
    if ((creep = [[[super alloc] initWithFile:@"doctor.png"] autorelease])) {
        
        creep.hp = 25;
        creep.moveDuration = .3;
         creep.scale=0.5;
        //watch enemy attacking your base
        if (m.startWatchMyAttack==false){
                    if ([m.playerID isEqualToString:[m.hb_player objectAtIndex:1]])
                    {  creep.curWaypoint = 0;
                    }
                    else{  //creep.scaleX = -1;
                       creep.curWaypoint =m._waypoints.count-1;
                    }
        }
        //watch your creeps attacking enemy base
        if (m.startWatchMyAttack==true){
            if ([m.playerID isEqualToString:[m.hb_player objectAtIndex:0]])
            {  creep.curWaypoint = 0;
            }
            else{  //creep.scaleX = 1;
                creep.curWaypoint =m._waypoints.count-1;
            }
        }
            
    }
    
    if  ([[VariableStore vStore] getZoom]==12 )
    { 
        creep.scale=0.5;
    }  
    else if  ([[VariableStore vStore] getZoom]==13 )    
    { 
        creep.scale=1;
        
    }  
    else if  ([[VariableStore vStore] getZoom]==14 )    
    { 
        creep.scale=2;
        
    } 
    
    creep._totalHp = creep.hp;
    [creep schedule:@selector(healthBarLogic:)];
	[creep schedule:@selector(creepLogic:) interval:0.2];
    
    
    return creep;
}


@end

@implementation GrandmaCreep

+ (id)creep {
    DataModel *m = [DataModel getModel];
    GrandmaCreep *creep = nil;
    if ((creep = [[[super alloc] initWithFile:@"grandma.png"] autorelease])) {
        
        creep.hp = 10;
        creep.moveDuration = 0.2;
       creep.scale=0.5;
        //watch enemy attacking your base
        if (m.startWatchMyAttack==false){
            if ([m.playerID isEqualToString:[m.hb_player objectAtIndex:1]])
            {  creep.curWaypoint = 0;
            }
            else{  //creep.scaleX = -1;
                creep.curWaypoint =m._waypoints.count-1;
            }
        }
        //watch your creeps attacking enemy base
        if (m.startWatchMyAttack==true){
            if ([m.playerID isEqualToString:[m.hb_player objectAtIndex:0]])
            {  creep.curWaypoint = 0;
            }
            else{ // creep.scaleX = -1;
                creep.curWaypoint =m._waypoints.count-1;
            }
        }
        
    }
    
    
    if  ([[VariableStore vStore] getZoom]==12 )
    { 
        creep.scale=0.5;
    }  
    else if  ([[VariableStore vStore] getZoom]==13 )    
    { 
        creep.scale=1;
        
    }  
    else if  ([[VariableStore vStore] getZoom]==14 )    
    { 
        creep.scale=2;
        
    } 
    
    creep._totalHp = creep.hp;
    [creep schedule:@selector(healthBarLogic:)];
	[creep schedule:@selector(creepLogic:) interval:0.2];
    
    
    return creep;
}


@end
