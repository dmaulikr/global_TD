
// Import the interfaces
#import "HelloWorldScene.h"
#import "GameHUD.h"
#import "VariableStore.h"
#import "DataModel.h"




@implementation HelloWorld
@synthesize background = _background;
@synthesize currentLevel = _currentLevel;

int creepCostBus=12;
int creepCostDoc=4;
int creepCostGrandma=2;
//----
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorld *layer = [HelloWorld node];
	
	// add layer as a child to scene
	[scene addChild: layer z:1];
	GameHUD * myGameHUD = [GameHUD sharedHUD];
	[scene addChild:myGameHUD z:2];
    
    DataModel *m = [DataModel getModel];
    m._gameLayer = layer;
    m._gameHUDLayer = myGameHUD;
   
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init {
    if((self = [super init])) {	        
        //  self.tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"TileMap.tmx"];
        
        movableSprites = [[NSMutableArray alloc] init];
        
        self.background = [CCSprite spriteWithFile:@"Untitled-2.png"];
        self.background.anchorPoint = ccp(0,0);
        self.background.visible=false;
        [self addChild:self.background z:0];
        
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
 
       
       // [self addWaypoint]; 
        DataModel *m = [DataModel getModel];
        m.VIP=0;
        creepIndex=0;
        towerSelected=false;
  //[self addWaves: m._BusNum, m._DoctorNum];
  // [self schedule:@selector(update:)];
  // [self schedule:@selector(gameLogic:) interval:1.0];		
		
		self.currentLevel = 0;
        m.HomeBaseTouchEnable_GameLayer=true;
        
        gameHUD = [GameHUD sharedHUD];
        
        //---Rau scroll menu
     
//        one = [CCSprite spriteWithFile:@"grandma.png"];
//        one.position = ccp(200,200);
//        [self addChild:one];
////        
        //----
        
    
        
          }
    return self;
}

- (void) callTowerSelectMenu{
    DataModel *m = [DataModel getModel];
//   controller = [[TowerSelectMenu alloc] init];
//  [m.towerMenuView addSubview:[controller view]];
//   [m.towerMenuView bringSubviewToFront:[controller view]];
    

    [m._gameHUDLayer addTurrets];
}

- (void) removeTowerSelectMenu{
//[controller removeFromParentViewController];
}

-(void)addWaves:(int) total_creeps {
	DataModel *m = [DataModel getModel];
	Wave *wave = nil;
	wave = [[Wave alloc] initWithCreep:[FastRedCreep creep] SpawnRate:1 TotalCreeps:total_creeps];
	[m._waves addObject:wave];
	wave = nil;
	wave = [[Wave alloc] initWithCreep:[StrongGreenCreep creep] SpawnRate:1.0 TotalCreeps:total_creeps];
	[m._waves addObject:wave];
	wave = nil;	
	wave = [[Wave alloc] initWithCreep:[GrandmaCreep creep] SpawnRate:1.0 TotalCreeps:total_creeps];
	[m._waves addObject:wave];
	wave = nil;	
}
- (Wave *)getCurrentWave{
	DataModel *m = [DataModel getModel];	
	Wave * wave = (Wave *) [m._waves objectAtIndex:self.currentLevel];
	return wave;
}

- (Wave *)getNextWave{
	
	DataModel *m = [DataModel getModel];
	self.currentLevel++;
	if (self.currentLevel > 1)
		self.currentLevel = 0;
    Wave * wave = (Wave *) [m._waves objectAtIndex:self.currentLevel];
    return wave;
}

//- (void)draw {
//  DataModel *m=[DataModel getModel];
//    glEnable(GL_LINE_SMOOTH);
//    
//    
//    
//    CGPoint point;
//    CGPoint nextPoint;
//   
//    for(int i = 0; i < m._wayPointsFromMap.count-1; i++) {
//    CLLocation* location = [m._wayPointsFromMap objectAtIndex:i];   
//    CGPoint t= [m.routeMapView convertCoordinate:location.coordinate toPointToView:m.cocos_view];
//    
//     point = [[CCDirector sharedDirector] convertToGL: t];
//        
//        CLLocation* location2 = [m._wayPointsFromMap objectAtIndex:i+1];   
//        CGPoint t2= [m.routeMapView convertCoordinate:location2.coordinate toPointToView:m.cocos_view];
//        
//       nextPoint=  [[CCDirector sharedDirector] convertToGL: t2];
//        glColor4f(1.0, 0.0, 0.0, 1.0);  
//        glLineWidth(6.0f);
//   ccDrawLine( ccp(point.x, point.y), ccp(nextPoint.x, nextPoint.y) );
//        
//        [LinePoints addObject:NSStringFromCGPoint(point)];
//        [LinePoints addObject:NSStringFromCGPoint(nextPoint)];
//
//   
//        }
//    //  NSLog(@" waypoint.position %d",LinePoints.count); 
//}




-(void)addWaypoint {   
//	DataModel *m = [DataModel getModel];
//	
//	//CCTMXObjectGroup *objects = [self.tileMap objectGroupNamed:@"Objects"];
//	WayPoint *wp = nil;
//	//--------
//    NSMutableArray *arrayX = [NSMutableArray arrayWithObjects: @"-100", @"-100",   nil];
//    NSMutableArray *arrayY = [NSMutableArray arrayWithObjects: @"-10", @"-10",  nil];
//     
////        // NSLog(@"array: %@", [array objectAtIndex:3]);
//    int spawnPointCounter = 0;
//    while (spawnPointCounter<2) {
//        int x = [[arrayX objectAtIndex:spawnPointCounter]intValue];
//        int y = [[arrayY objectAtIndex:spawnPointCounter]intValue];
//        
//       wp = [WayPoint node];
//        wp.position = ccp(x, y);
//        [m._waypoints addObject:wp];
//        spawnPointCounter++;
//    
//    }
////  NSLog(@"array: %@", m._waypoints);
//	NSAssert([m._waypoints count] > 0, @"Waypoint objects missing");
//	wp = nil;
//    
//    //----------
//    
	
}

- (CGPoint) tileCoordForPosition:(CGPoint) position 
{
    int x = position.x;
    int y = position.y;
	return ccp(x,y);
}

- (BOOL) canBuildOnTilePosition:(CGPoint) pos 
{
	
    return YES;
    
    bool occupied = NO;
    
    DataModel *m = [DataModel getModel];
    
    for (Tower *tower1 in m._towers) {
        CGRect towerRect = CGRectMake(tower1.position.x - (tower1.contentSize.width/2), tower1.position.y - (tower1.contentSize.height/2), tower1.contentSize.width, tower1.contentSize.height);
        if (CGRectContainsPoint(towerRect, pos)) {
            occupied = YES;
        }
        
    }
    
    if(occupied == NO) {
        
        return YES;
        
    }
    
    return NO;
    
}

//-----
- (void) resetWaveSystem{
    NSLog(@"resetWave");
    DataModel *m = [DataModel getModel];
    Wave * wave = [self getCurrentWave];
    wave.totalCreeps = m._creepsOrder.count;
    wave.aliveCreeps = m._creepsOrder.count;
    m.stopWave=false;
    creepIndex = 0;
    m.startWatchMyAttack=false;
}


-(void)addTarget {	
    
	DataModel *m = [DataModel getModel];
	Wave * wave = [self getCurrentWave];
    //NSLog(@"income==%d", m.totalIncome);
    //NSLog(@"totalCreep = %d, startWatchMyattack = %d, stopWave = %d, aliveCreep = %d", wave.totalCreeps, m.startWatchMyAttack, m.stopWave, wave.aliveCreeps );
    
    if (wave.totalCreeps < 1 && m.startWatchMyAttack==true && m.stopWave == false && wave.aliveCreeps < 1) {
        NSLog(@"HIT!!!!");
        m.stopWave=true;
      //  [gameHUD updateWaveCount];
        [m._MainMenuCocosLayer add_removeEndTurnButton];
       //[m._WaveCreationUIlayer updateIncomes:10];
        return;
    }
    
    if (wave.totalCreeps < 1 && m.startWatchMyAttack==true ) {
        
        return;
    }
    
    //NSLog(@"alive = %d",wave.aliveCreeps);
	if (wave.totalCreeps < 1 && m.startWatchMyAttack==false && wave.aliveCreeps < 1 ) {
        m.startWatchMyAttack=true;
        wave.totalCreeps = m._creepsEnemyOrder.count;
        wave.aliveCreeps = m._creepsEnemyOrder.count;
        creepIndex = 0;
		return; 
	}
    
    if (wave.totalCreeps < 1) {
        return;
    }

	wave.totalCreeps--;
	 
    Creep *target = nil;
    NSNumber *myNum;
    if(m.startWatchMyAttack==false){
      myNum=[m._creepsOrder objectAtIndex:creepIndex];
    }else{
        myNum=[m._creepsEnemyOrder objectAtIndex:creepIndex];
    }
        if(myNum.integerValue == 5) {//???
            target = [FastRedCreep creep];
            target.type = 5;
        } else if (myNum.integerValue == 1) {
            target = [StrongGreenCreep creep];
            target.type = 1;
        } else if (myNum.integerValue == 2) {
            target = [GrandmaCreep creep];
            target.type = 2;
        }		   
//if (target!=nil){
    
	WayPoint *waypoint = [target getCurrentWaypoint];
	target.position = waypoint.position;	
	waypoint = [target getNextWaypoint ];
	
//    if (target!=nil)
//    {
	[self addChild:target z:1];
    target.healthBar = [CCProgressTimer progressWithFile:@"health_bar_red.png"];
    target.healthBar.type = kCCProgressTimerTypeHorizontalBarLR;
    target.healthBar.percentage = 100;
    [target.healthBar setScale:0.1];
    target.healthBar.position = ccp(target.position.x,(target.position.y+20));
    
    [self addChild:target.healthBar z:3];
	//}
    float moveDuration = [target moveDurScale];
    //float vel = [target getVelocity:target];


	id actionMove = [CCMoveTo actionWithDuration:moveDuration position:waypoint.position];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(FollowPath:)];
	[target runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
  //  NSLog(@"getVelocity output = %f", vel);
	// Add to targets array
    if([m.playerID isEqualToString:[m.hb_player objectAtIndex:1]]){
    //if(m.startWatchMyAttack==false){
        target.tag = [m.playerID intValue];//m._PlayerNum;
    }
    else
    {
        target.tag = [[m.hb_player objectAtIndex:0] intValue];
    }

	//target.tag = [m.playerID intValue];//m._PlayerNum;
	[m._targets addObject:target];
    creepIndex++;
//}
    
}

-(void)FollowPath:(id)sender {
	Creep *creep = (Creep *)sender;

    WayPoint * waypoint = [creep getNextWaypoint];
   
    
    float moveDuration = [creep moveDurScale];
    //float vel = [creep getVelocity:creep];
	id actionMove = [CCMoveTo actionWithDuration:moveDuration position:waypoint.position];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(FollowPath:)];
    [creep stopAllActions];
	[creep runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
}

-(void)ResumePath:(id)sender {
    Creep *creep = (Creep *)sender;
    
    WayPoint * cWaypoint = [creep getCurrentWaypoint];//destination
    WayPoint * lWaypoint = [creep getLastWaypoint];//startpoint
    
    float waypointDist = fabsf(cWaypoint.position.x - lWaypoint.position.x);
    float creepDist = fabsf(cWaypoint.position.x - creep.position.x);
    float distFraction = creepDist / waypointDist;
    float durScale = [creep moveDurScale];
    float moveDuration = durScale * distFraction; //Time it takes to go from one way point to another * the fraction of how far is left to go (meaning it will move at the correct speed)
    id actionMove = [CCMoveTo actionWithDuration:moveDuration position:cWaypoint.position];   
    id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(FollowPath:)];
	[creep stopAllActions];
	[creep runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
}

-(void)gameLogic:(ccTime)dt {
	
	//DataModel *m = [DataModel getModel];
	Wave * wave = [self getCurrentWave];
	static double lastTimeTargetAdded = 0;
    double now = [[NSDate date] timeIntervalSince1970];
    if(lastTimeTargetAdded == 0 || now - lastTimeTargetAdded >= wave.spawnRate) {
        [self addTarget];
        lastTimeTargetAdded = now;
    }
	
} 

-(void)addTower: (CGPoint)pos,playerID,type_id  {
 
	DataModel *m = [DataModel getModel];
	Tower *target = nil;
	
    CGPoint towerLoc = [self tileCoordForPosition: pos];
    bool occupied = NO;
    
    for (Tower *tower1 in m._towers) {
        CGRect towerRect = CGRectMake(tower1.position.x - (tower1.contentSize.width/2), tower1.position.y - (tower1.contentSize.height/2), tower1.contentSize.width, tower1.contentSize.height);
    
        if (CGRectContainsPoint(towerRect, pos) ) {
            NSLog(@" Not Buildable" );
            occupied = YES;
            
        
        }
        
    }
int cost = 0;
    if(type_id == 1)
{
    cost = 50;
}
else if(type_id == 2)
{
    cost = 10;
}
else if(type_id == 3)
{
    cost = 20;
}
else if(type_id == 4)
{
    cost = 100;
}
   // if(occupied == NO) {
if ( m.gold-cost>=0 || m.parsingTower==true){
        switch (type_id) {
            case 1:
                target = [MachineGunTower tower];
                target.type= 1;
                break;
            case 2:
                target = [JumpRope tower];
                target.type = 2;
                break;
            case 3:
                target = [Pyro tower];
                target.type = 3;
                 break;
            case 4:
                if([m.playerID intValue]==playerID ){
                    target = [AddAreaTower tower];
                    target.type = 4;
                    [m.extraArea addObject:target];
                }else{
                    target = [AddEnemyAreaTower tower];
                    //target.type = 4;
                }
                 break;
            default:
                break;
        }
       // NSLog(@"Tower Type %d", target.type);
        
        //[MachineGunTower tower];
        target.position =ccp(towerLoc.x,towerLoc.y);
        CGPoint point=target.position;
      //  point=target.position.y;
        
        //NSLog(@"tower cocos positon = %f, %f",target.position.x, target.position.y);
     //   DataModel *m = [DataModel getModel];
        CLLocationCoordinate2D coord= [m.routeMapView convertPoint: [[CCDirector sharedDirector] convertToUI:point] toCoordinateFromView:m.cocos_view];
       // NSLog(@"tower CCLocation positon = %f, %f",coord.latitude, coord.longitude);
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
        //[m._arrayX addObject: loc];
        target.coord = loc;
        
        
        [self addChild:target z:1];
        
        if (m.parsingTower==false ){
            //reduce money
            if (target.type==1) //firew
            {
                [gameHUD updateResources:-50];}
            else  if (target.type==2)
            {
                [gameHUD updateResources:-10];} //jump
            else  if (target.type==3)
            {
                [gameHUD updateResources:-20];}//pyro
            else  if (target.type==4)
            {
                [gameHUD updateResources:-100];}
        }    
        NSLog(@"Tower was builded");
           
//        if (type_id==1){
//        target.tag = [m.playerID intValue];//m._PlayerNum;
//         //  }
//         //  else if (type_id==2)
//         //  {
//           // target.tag = [m.playerID intValue]+1;
//          // }

        //if([m.playerID isEqualToString:[m.hb_player objectAtIndex:1]]){
            target.tag = playerID; //m._PlayerNum;
        
        [m._towers addObject:target];
    
    if([m.playerID intValue]==playerID ){
        [m._towersToSend addObject:target];
    }
       // NSLog(@"m.towerCount = %d", m._towers.count);
        
    }else {
       // NSLog(@" Not Buildable");
         NSLog(@" Not Enough money");
        [self fadeInOutText];
        
    }
	
}

- (void)fadeInOutText
{
    CCLabelTTF * noMoneyLabel = [[CCLabelTTF labelWithString:@"Not Enough Money!" 
                                                  dimensions:CGSizeMake(320, 550) alignment:UITextAlignmentCenter 
                                                    fontName:@"Helvetica-Bold" fontSize:30.0] retain];
    noMoneyLabel.position = ccp(150,50);
    noMoneyLabel.color = ccc3(255,0,0);
    [self addChild:noMoneyLabel]; 
    
    [noMoneyLabel setOpacity:1.0];
    CCFadeTo *fadeIn = [CCFadeTo actionWithDuration:0.5 opacity:127];
    CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:0.5 opacity:255];
    CCFadeTo *stay = [CCFadeTo actionWithDuration:0.5 opacity:255];
    CCFadeTo *fadeInToZero = [CCFadeTo actionWithDuration:0.5 opacity:1];
    id cleanupAction = [CCCallFuncND actionWithTarget:self selector:@selector(cleanupSprite:) data:noMoneyLabel];
    
    CCSequence *pulseSequence = [CCSequence actions:fadeIn, fadeOut, stay,fadeInToZero, cleanupAction,nil];
    [noMoneyLabel runAction:pulseSequence];
}

- (void) cleanupSprite:(CCSprite*)inSprite
{
    [self removeChild:inSprite cleanup:YES];
}

-(void)removeTowers {
    DataModel *m = [DataModel getModel];
    NSMutableArray *discardedItems = [NSMutableArray array];
    
    for (Tower *tower1 in m._towers) {
         [discardedItems addObject:tower1];
    }
    [m._towers removeObjectsInArray:discardedItems];
}

//-(void)addEnemyTower: (CGPoint)pos {
//	DataModel *m = [DataModel getModel];
//	Tower *target = nil;
//	
//    CGPoint towerLoc = [self tileCoordForPosition: pos];
//    bool occupied = NO;
//    
//    for (Tower *tower1 in m._towers) {
//        CGRect towerRect = CGRectMake(tower1.position.x - (tower1.contentSize.width/2), tower1.position.y - (tower1.contentSize.height/2), tower1.contentSize.width, tower1.contentSize.height);
//        if (CGRectContainsPoint(towerRect, pos)) {
//            NSLog(@" Not Buildable" );
//            occupied = YES;
//            
//        }
//        
//    }
//    
//    if(occupied == NO) {
//        
//        target = [MachineGunTower tower];
//        target.position =ccp(towerLoc.x,towerLoc.y);
//        CGPoint point=target.position;
//        //  point=target.position.y;
//        
//        //NSLog(@"tower cocos positon = %f, %f",target.position.x, target.position.y);
//        DataModel *m = [DataModel getModel];
//        CLLocationCoordinate2D coord= [m.routeMapView convertPoint: [[CCDirector sharedDirector] convertToUI:point] toCoordinateFromView:m.cocos_view];
//        //NSLog(@"tower CCLocation positon = %f, %f",coord.latitude, coord.longitude);
//        CLLocation *loc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
//        //[m._arrayX addObject: loc];
//        target.coord = loc;
//        
//        
//        [self addChild:target z:1];
//        NSLog(@"Tower was builded");
//        if ([m.playerID isEqualToString:[m.hb_player objectAtIndex:1]])
//        {
//            EnemyHomeBase.tag=[m.playerID intValue]+1;
//        }
//        else 
//        {
//            EnemyHomeBase.tag=[m.playerID intValue];
//        }
//        [m._towers addObject:target];
//        
//    }else {
//        NSLog(@" Not Buildable");
//        
//        
//    }
//	
//}


-(void)addHomeBase: (CGPoint)pos {
	
    DataModel *m=[DataModel getModel];
    CGPoint buildLoc = [self tileCoordForPosition: pos];    
    
    HomeBase = [CCSprite spriteWithFile:@"TreehouseBase14.png"];
    
    HomeBase.position = buildLoc;
    [self addChild:HomeBase];
    [movableSprites addObject:HomeBase];
    
    HomeBaseArea = [CCSprite spriteWithFile:@"Square.png"];
    if ([[VariableStore vStore] getZoom]==16 )
    {    HomeBase.scale=.25;
    HomeBaseArea.scale = 1.4;
    }

    
    
    [self addChild:HomeBaseArea z:-1];
    HomeBaseArea.position = buildLoc;
    HomeBase.tag=[m.playerID intValue];//m._PlayerNum;
  //  [self keepHomeBasePos:m.routeMapView];
   
}

-(void)addEnemyHomeBase: (CGPoint)pos {
	
    //CGPoint buildLoc = [self tileCoordForPosition: pos];    
    DataModel *m=[DataModel getModel];
    CGPoint buildLoc = [self tileCoordForPosition: pos];
    EnemyHomeBase = [CCSprite spriteWithFile:@"TreehouseBase14.png"];
 
    EnemyHomeBase.position = buildLoc;
    [self addChild:EnemyHomeBase];
   //[movableSprites addObject:HomeBase];
    
    EnemyHomeBaseArea = [CCSprite spriteWithFile:@"SquareEnemy.png"];
    if ([[VariableStore vStore] getZoom]==16 )
    {    EnemyHomeBase.scale=.25;
     EnemyHomeBaseArea.scale = 1.4;
    }

   
    [self addChild:EnemyHomeBaseArea z:-1];
    EnemyHomeBaseArea.position = buildLoc;
//    if (m._PlayerNum==1)
//    {
//    EnemyHomeBase.tag=2;
//    }
//    else 
//    {
//    EnemyHomeBase.tag=1;
//    } 
   // NSLog(@"in addEnemyHomeBase, pos = %f,%f",EnemyHomeBase.position.x,EnemyHomeBase.position.y);
}

-(void)removeHBs {
    //NSLog(@"removeHBs");
    [self removeChild:HomeBase cleanup:YES];
    //HomeBase = nil; 
    [self removeChild:HomeBaseArea cleanup:YES];
    //HomeBaseArea = nil; 
    [self removeChild:EnemyHomeBase cleanup:YES];
    //EnemyHomeBase = nil; 
    [self removeChild:EnemyHomeBaseArea cleanup:YES];
   // EnemyHomeBaseArea = nil; 
}

//-----------


- (void)update:(ccTime)dt {
    
	DataModel *m = [DataModel getModel];
    [m._gameHUDLayer updateResources:0];
	
    NSMutableArray *projectilesToDelete = [[NSMutableArray alloc] init];
    //for(CCSprite *tar in m._targets){
    //  NSLog(@"target pos (%f, %f)",tar.position.x, tar.position.y);
    // }
    
	for (Projectile *projectile in m._projectiles) {
		CGRect projectileRect = CGRectMake(projectile.position.x - (projectile.contentSize.width/2), 
										   projectile.position.y - (projectile.contentSize.height/2), 
										   projectile.contentSize.width, 
										   projectile.contentSize.height);
        
		NSMutableArray *targetsToDelete = [[NSMutableArray alloc] init];
        
		
		for (Creep *target1 in m._targets) {
			CGRect targetRect = CGRectMake(target1.position.x - (target1.contentSize.width/2), 
										   target1.position.y - (target1.contentSize.height/2), 
										   target1.contentSize.width, 
										   target1.contentSize.height);
            
			if (CGRectIntersectsRect(projectileRect, targetRect)) {
                [projectilesToDelete addObject:projectile];
                
                //Creep *creep = (Creep *)target;
                // Creep *thisCreep;
                Tower *parentTower = (Tower *) projectile.parentTower;
                int thisHitDamage;
                CGRect splashRect;
                
                switch (projectile.tag) {
                    case 3:
                        thisHitDamage = parentTower.damage;
                        splashRect = CGRectMake(projectile.position.x - (parentTower.splashDist), 
                                                projectile.position.y - (parentTower.splashDist), 
                                                (parentTower.splashDist*2), 
                                                (parentTower.splashDist*2));
                        for (Creep *target in m._targets) {//??? ccsprite
                            CGRect thistargetRect = CGRectMake(target.position.x - (target.contentSize.width/2), 
                                                               target.position.y - (target.contentSize.height/2), 
                                                               target.contentSize.width, 
                                                               target.contentSize.height);
                            //thisCreep = (Creep *) target;
                            if (CGRectIntersectsRect(splashRect, thistargetRect) ) {
                                target.hp -= thisHitDamage;
                                if (target.hp <= 0) {
                                    Wave * wave = [m._gameLayer getCurrentWave];
                                    wave.aliveCreeps--;
                                    [targetsToDelete addObject:target];
                                    if (m.startWatchMyAttack==false){
                                        if (target.type==5)
                                        {
                                            [gameHUD updateResources:creepCostBus];
                                        }   
                                        if (target.type==1)
                                        {
                                            [gameHUD updateResources:creepCostDoc];
                                        }   
                                        if (target.type==2)
                                        {
                                            [gameHUD updateResources:creepCostGrandma];
                                        }   
                                    }
                                    [self removeChild:target.healthBar cleanup:YES];
                                    //[thisCreep.parent removeChild:thisCreep.healthBar cleanup:YES];
                                    
                                }
                            }
                        }
                        break;
                        
                        
                    case 2:
                        
                        thisHitDamage = parentTower.damage;
                        
                        id actionFreeze = [CCMoveTo actionWithDuration:parentTower.freezeDur position:target1.position];    
                        id actionMoveResume = [CCCallFuncN actionWithTarget:self selector:@selector(ResumePath:)];  
                        [target1 stopAllActions];
                        [target1 runAction:[CCSequence actions:actionFreeze, actionMoveResume, nil]];
                        
                        target1.hp -= thisHitDamage;
                        if (target1.hp <= 0) {
                            Wave * wave = [m._gameLayer getCurrentWave];
                            wave.aliveCreeps--;
                            [self removeChild:target1.healthBar cleanup:YES];
                            [targetsToDelete addObject:target1];
                            
                            if (m.startWatchMyAttack==false){ 
                                if (target1.type==5)
                                {
                                    [gameHUD updateResources:creepCostBus];
                                }   
                                if (target1.type==1)
                                {
                                    [gameHUD updateResources:creepCostDoc];
                                }   
                                if (target1.type==2)
                                {
                                    [gameHUD updateResources:creepCostGrandma];
                                }  
                            }
                        }
                        
                        break;
                        
                    case 1:
                        thisHitDamage = parentTower.damage;
                        splashRect = CGRectMake(projectile.position.x - (parentTower.splashDist), 
                                                projectile.position.y - (parentTower.splashDist), 
                                                (parentTower.splashDist*2), 
                                                (parentTower.splashDist*2));
                        for (Creep *target in m._targets) {
                            CGRect thistargetRect = CGRectMake(target.position.x - (target.contentSize.width/2), 
                                                               target.position.y - (target.contentSize.height/2), 
                                                               target.contentSize.width, 
                                                               target.contentSize.height);
                            //  thisCreep = (Creep *) target;
                            if (CGRectIntersectsRect(splashRect, thistargetRect) ) {
                                //thisCreep = (Creep *) target;
                                target.hp -= thisHitDamage;
                                if (target.hp <= 0) {
                                    Wave * wave = [m._gameLayer getCurrentWave];
                                    wave.aliveCreeps--;
                                    [targetsToDelete addObject:target];
                                    
                                    if (m.startWatchMyAttack==false){ 
                                        if (target.type==5)
                                        {
                                            [gameHUD updateResources:creepCostBus];
                                        }   
                                        if (target.type==1) 
                                        {
                                            [gameHUD updateResources:creepCostDoc];
                                        }   
                                        if (target.type==2)
                                        {
                                            [gameHUD updateResources:creepCostGrandma];
                                        }  
                                    }
                                    [self removeChild:target.healthBar cleanup:YES];
                                    //[thisCreep.parent removeChild:thisCreep.healthBar cleanup:YES];
                                    
                                }
                            }
                        }
                        break;
                    default:
                        break;
                }				
                //                if (creep.hp <= 0) {
                //                    Wave * wave = [m._gameLayer getCurrentWave];
                //                    wave.aliveCreeps--;
                //                    [self removeChild:creep.healthBar cleanup:YES];
                //                    [targetsToDelete addObject:target];
                //                   [gameHUD updateResources:creepCost];
                //
                //                }
                
                break;
			}	
            
		}
		
		for (CCSprite *target in targetsToDelete) {
			[m._targets removeObject:target];
			[self removeChild:target cleanup:YES];									
		}
		
		[targetsToDelete release];
	}
	
	for (CCSprite *projectile in projectilesToDelete) {
		[m._projectiles removeObject:projectile];
		[self removeChild:projectile cleanup:YES];
	}
	[projectilesToDelete release];
}
- (void) dealloc
{ 
   
	[super dealloc];
}

//keeps the positions of the targets before the region of the map changes
- (void) keepProjectilesPos:(LimitedMapView*) arr{
    DataModel *m = [DataModel getModel];
    for(int i =0; i <m._projectiles.count; i++){
        Projectile *proj = [m._projectiles objectAtIndex:i];
        CGPoint pt = proj.position;
        
        CLLocationCoordinate2D coord= [arr convertPoint: [[CCDirector sharedDirector] convertToUI:pt] toCoordinateFromView:m.cocos_view];
        
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
        
        if(m._prevProPos.count <= i){
            //            NSLog(@"mistake?");
            [m._prevProPos addObject: loc];
        }else{
            [m._prevProPos replaceObjectAtIndex:i withObject:loc];
        }
    }
    
}

- (void) keepHomeBasePos:(LimitedMapView*) arr{
    DataModel *m = [DataModel getModel];
    CGPoint pt = HomeBase.position;
    
    CLLocationCoordinate2D coord= [arr convertPoint: [[CCDirector sharedDirector] convertToUI:pt] toCoordinateFromView:m.cocos_view];
    
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
    m._prevHomeBasePos = loc;
}

- (void) keepEnemyHomeBasePos:(LimitedMapView*) arr{
    DataModel *m = [DataModel getModel];
    CGPoint pt = EnemyHomeBase.position;
    
    CLLocationCoordinate2D coord= [arr convertPoint: [[CCDirector sharedDirector] convertToUI:pt] toCoordinateFromView:m.cocos_view];
    
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
    m._prevEnemyHomeBasePos = loc;
}


//keeps the positions of the targets before the region of the map changes
- (void) keepPositions:(LimitedMapView*) arr{
    DataModel *m = [DataModel getModel];
    for(int i =0; i <m._targets.count; i++){
        Creep *creep = [m._targets objectAtIndex:i];
        CGPoint pt = creep.position;
        
        CLLocationCoordinate2D coord= [arr convertPoint: [[CCDirector sharedDirector] convertToUI:pt] toCoordinateFromView:m.cocos_view];
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
        
        if(m._prevTarPos.count <= i){
            //            NSLog(@"mistake?");
            [m._prevTarPos addObject: loc];
        }else{
            [m._prevTarPos replaceObjectAtIndex:i withObject:loc];
        }
    }
}


- (CCSprite*) getHomeBase{
    return HomeBase;
}

- (CCSprite*) getHomeBaseArea{
    return HomeBaseArea;
}



- (CCSprite*) getEnemyHomeBase{
    return EnemyHomeBase;
}

- (CCSprite*) getEnemyHomeBaseArea{
    return EnemyHomeBaseArea;
}

-(void) HomeBaseZoomIn{
    HomeBase.scale=HomeBase.scale*2;
    EnemyHomeBase.scale*=2;
}

-(void) HomeBaseZoomOut{
    HomeBase.scale=HomeBase.scale/2;
     EnemyHomeBase.scale/=2;
}

//-----------------------------------------touches----------------------------------------------
- (void)t_Begin:(UITouch *)touch withEvent:(UIEvent *)event{
    DataModel *m = [DataModel getModel];
    CGPoint temp_touchLocation = [touch  locationInView:m.cocos_view];
    CGPoint touchLocation = [[CCDirector sharedDirector] convertToGL:temp_touchLocation];

    //----
    //show range if tower was selected
    for (Tower *tower1 in m._towers) {
        
        if ( towerSelected==true) {
            NSLog(@"towerNOtselected");
            for (CCSprite *removeSprite in m._towersRange) {
                [self removeChild:removeSprite cleanup:YES];
            }
            NSMutableArray *discardedItems = [NSMutableArray array];
            
            for (Tower *tower1 in m._towersRange) {
                [discardedItems addObject:tower1];
            }
            [m._towersRange removeObjectsInArray:discardedItems];
            
            [self removeChild:selSpriteRange cleanup:YES];
            //    selSpriteRange = nil;
            towerSelected=false;
        }
    }
        for (Tower *tower1 in m._towers) {
            if (CGRectContainsPoint(tower1.boundingBox, touchLocation) && towerSelected==false && tower1.type!=4) { 
                NSLog(@"tower was selected tag==%d",tower1.type);
                selSpriteRange = [CCSprite spriteWithFile:@"Range.png"];
                
                [self addChild:selSpriteRange z:-1];
                selSpriteRange.position = tower1.position;
               
                if  ([[VariableStore vStore] getZoom]==16)    
                { 
                    if(tower1.type==1){
                        selSpriteRange.scale = 2.8;
                    }
                    else  if(tower1.type==2){
                        selSpriteRange.scale = 0.7;
                    }
                    else  if(tower1.type==3){
                        selSpriteRange.scale = 1.6;
                    }
                   // else  if(tower1.type==4){
                   //     selSpriteRange.scale = 0;
                   // }
                }     
                [m._towersRange addObject:selSpriteRange];
                towerSelected=true;
            }
    } 
    
    if(m.HomeBaseTouchEnable_GameLayer==true){
        if (CGRectContainsPoint(HomeBase.boundingBox, touchLocation)) { 
        m.routeMapView.scrollEnabled=NO;
        NSLog(@"homebase was touched!!!");
        }
    }
    
    //rau
  //  CGPoint loc = [[CCDirector sharedDirector] convertToGL:[touch locationInView:touch.view]];
	//[LinePoints addObject:[NSValue valueWithCGPoint:touchLocation]];
	
}

- (void)t_Moved:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation); 
    
	DataModel *m = [DataModel getModel];
    if(m.HomeBaseTouchEnable_GameLayer==true && m.routeMapView.scrollEnabled==NO){
        CGPoint newPos = ccpAdd(HomeBase.position, translation);
        HomeBase.position = newPos;
        HomeBaseArea.position = newPos;
        
      //  NSLog(@"pos = %f, %f", HomeBase.position.x, HomeBase.position.y);
    }
    
    
     //[_bear stopAction:_walkAction];
}	

- (void)t_Ended:(UITouch *)touch withEvent:(UIEvent *)event{
    DataModel *m = [DataModel getModel];
   // if(selSprite==HomeBase){
     //    DataModel *m = [DataModel getModel];
      //  [self keepHomeBasePos:m.routeMapView];
    //}
    //[self removeChild:selSprite cleanup:YES];
    //selSprite = nil;
    m.routeMapView.scrollEnabled=YES;
}

- (void)t_Cancelled:(UITouch *)touch withEvent:(UIEvent *)event{
    
}

@end



