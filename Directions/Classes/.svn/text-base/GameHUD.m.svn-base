
#import "GameHUD.h"
#import "DataModel.h"
#import "VariableStore.h"
#import <MapKit/MapKit.h>
#import "MKMapView_ZoomLevel.h"
#import "UICRouteOverlayMapView.h"
#import "HelloWorldScene.h"
#import "SimpleAudioEngine.h"

@implementation GameHUD

@synthesize descriptionFlag;
@synthesize resources = resources;
@synthesize ChoosingHB;
@synthesize emitter = _emitter;
//@synthesize baseHpPercentage = baseHpPercentage;
int waveCount;

static GameHUD *_sharedHUD = nil;

+ (GameHUD *)sharedHUD
{
	@synchronized([GameHUD class])
	{
		if (!_sharedHUD)
        [[self alloc] init];
		return _sharedHUD;
	}
	// to avoid compiler warning
	return nil;
}

+(id)alloc
{
	@synchronized([GameHUD class])
	{
		NSAssert(_sharedHUD == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedHUD = [super alloc];
		return _sharedHUD;
	}
	// to avoid compiler warning
	return nil;
}

-(id) init
{
	if ((self=[super init]) ) {
        //soundTD
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Wallpaper.mp3"];
         DataModel *m = [DataModel getModel];
        HBnotActive = true;
        //--- money--Rau--
        //money
     //   resources = m.gold;//100; 
        //homebase health
        m.baseHealth=100;
        m.EnemyBaseHealth=100;
        
        upBG = [CCSprite spriteWithFile:@"hud2.png"];
        upBG.scale=1;
        upBG.position = ccp(120,460);
        [self addChild:upBG z:-3];
        
        coinTD = [CCSprite spriteWithFile:@"coinTD.png"];
        coinTD.scale=1;
        coinTD.position = ccp(65,465);
        [self addChild:coinTD z:1];
        
		self->resourceLabel = [CCLabelTTF labelWithString:@"" dimensions:CGSizeMake(150, 25) alignment:UITextAlignmentRight fontName:@"Marker Felt" fontSize:20];
            [self->resourceLabel setString:[NSString stringWithFormat: @"%i",m.gold]];
        resourceLabel.position = ccp(35, 465);
        resourceLabel.color = ccc3(100,0,100);
        [self addChild:resourceLabel z:1];
        
        // Set up wavecount label
        waveCount = 1;
        self->waveCountLabel = [CCLabelTTF labelWithString:@"Turn 1" dimensions:CGSizeMake(150, 25) alignment:UITextAlignmentRight fontName:@"Marker Felt" fontSize:20];
        waveCountLabel.position = ccp(135, 465);
        waveCountLabel.color = ccc3(100,0,100);
        [self addChild:waveCountLabel z:1];
        
        
        
        // Set up BaseHplabel
        baseHpLabel = [CCSprite spriteWithFile:@"smily.png"];// [CCLabelTTF labelWithString:@"Base Health" dimensions:CGSizeMake(150, 25) alignment:UITextAlignmentRight fontName:@"Marker Felt" fontSize:20];
        baseHpLabel.position = ccp(65, 445);
        baseHpLabel.scale=0.5;
      //  baseHpLabel.color = ccc3(100,0,100);
        [self addChild:baseHpLabel z:2];
        
        //Set up helth Bar
        self->healthBar = [CCProgressTimer progressWithFile:@"health_bar_green.png"];
        self->healthBar.type = kCCProgressTimerTypeHorizontalBarLR;
        self->healthBar.percentage = m.baseHealth;
        [self->healthBar setScale:0.5]; 
        self->healthBar.position = ccp(110, 445);
        [self addChild:healthBar z:1];
        
//       //enemy baseHP
        // Set up BaseHplabel
        enemyBaseHpLabel = [CCSprite spriteWithFile:@"devil.png"]; //[CCLabelTTF labelWithString:@"Enemy Base Health" dimensions:CGSizeMake(150, 25) alignment:UITextAlignmentRight fontName:@"Marker Felt" fontSize:20];
        enemyBaseHpLabel.position = ccp(175, 445);
        enemyBaseHpLabel.scale=0.4;
       //enemyBaseHpLabel.color = ccc3(100,0,100);
        [self addChild:enemyBaseHpLabel z:1];
        
        //Set up helth Bar
        self->EnemyHealthBar = [CCProgressTimer progressWithFile:@"health_bar_green.png"];
        self->EnemyHealthBar.type = kCCProgressTimerTypeHorizontalBarLR;
        self->EnemyHealthBar.percentage = m.EnemyBaseHealth;
        [self->EnemyHealthBar setScale:0.5]; 
        self->EnemyHealthBar.position = ccp(222, 445);
        [self addChild:EnemyHealthBar z:1];
        
        
        
//---
        
       
        descriptionFlag = false;
        towerSprite=nil;
        if(m.game_state ==1){
//            [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
//            background = [CCSprite spriteWithFile:@"hudBG2.png"];
//            background.anchorPoint = ccp(0,0);
//            [self addChild:background];
//            [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
            
           
            HomeBase4 = [CCSprite spriteWithFile:@"TreehouseBase14.png"];
            HomeBase4.scale=.2;
            HomeBase4.position = ccp(72,357);
            [self addChild:HomeBase4];
            HomeBaseArea4 = [CCSprite spriteWithFile:@"Square.png"];
            HomeBaseArea4.scale = 1.4;
            [self addChild:HomeBaseArea4 z:-1];
            HomeBaseArea4.position = ccp(72,357);
            HomeBaseArea4.opacity=100;
            HomeBase4.opacity=100;
            
            HomeBase1 = [CCSprite spriteWithFile:@"TreehouseBase14.png"];
            HomeBase1.scale=.2;
            HomeBase1.position = ccp(248,357);
            [self addChild:HomeBase1];
            HomeBaseArea1 = [CCSprite spriteWithFile:@"Square.png"];
            HomeBaseArea1.scale = 1.4;
            [self addChild:HomeBaseArea1 z:-1];
            HomeBaseArea1.position = ccp(248,357);
            HomeBaseArea1.opacity=100;
            HomeBase1.opacity=100;
            
            
            HomeBase2 = [CCSprite spriteWithFile:@"TreehouseBase14.png"];
            HomeBase2.scale=.2;
            HomeBase2.position = ccp(72,123);
            [self addChild:HomeBase2];
            HomeBaseArea2 = [CCSprite spriteWithFile:@"Square.png"];
            HomeBaseArea2.scale = 1.4;
            [self addChild:HomeBaseArea2 z:-1];
            HomeBaseArea2.position = ccp(72,123);
            HomeBaseArea2.opacity=100;
            HomeBase2.opacity=100;
            
            HomeBase3 = [CCSprite spriteWithFile:@"TreehouseBase14.png"];
            HomeBase3.scale=.2;
            HomeBase3.position = ccp(248,123);
            [self addChild:HomeBase3];
            HomeBaseArea3 = [CCSprite spriteWithFile:@"Square.png"];
            HomeBaseArea3.scale = 1.4;
            [self addChild:HomeBaseArea3 z:-1];
            HomeBaseArea3.position = ccp(248,123);
            HomeBaseArea3.opacity=100;
            HomeBase3.opacity=100;
            
            DataModel *m = [DataModel getModel];
            m.HomeBaseTouchEnable_HUD=true;
            
        }
	}
	return self;
}

-(void) updateBaseHp:(int)amount{
    DataModel *m=[DataModel getModel];
    m.baseHealth += amount;
    
    if (m.baseHealth  <= 25) {
        [self->healthBar setSprite:[CCSprite spriteWithFile:@"health_bar_red.png"]];
        [self->healthBar setScale:0.5]; 
    }
    
    if (m.baseHealth  <= 0) {
        //Game Over Scenario
        //   printf("Game Over\n");
        m.gameover=true;
       //[self loseWindow];
        [m._MapDirectionsViewController callStats];
        [m._MainMenuCocosLayer  clearGameisOver];
        //Implement Game Over Scenario
        
        
        
//        for (CCSprite *removeSprite in m._creepsEnemyOrder) {
//            [self removeChild:removeSprite cleanup:YES];}
//           NSMutableArray *discardedItems = [NSMutableArray array];
//        
//        for (Creep *creeps in m._creepsEnemyOrder) {
//            [discardedItems addObject:creeps];
//        }
//        [m._creepsEnemyOrder removeObjectsInArray:discardedItems];
//       
//        for (CCSprite *removeSprite2 in m._creepsOrder) {
//            [self removeChild:removeSprite2 cleanup:YES];}
//        NSMutableArray *discardedItems2 = [NSMutableArray array];
//        
//        for (Creep *creeps2 in m._creepsOrder) {
//            [discardedItems2 addObject:creeps2];
//        }
//        [m._creepsOrder removeObjectsInArray:discardedItems2];
        
        
    }
    
    [self->healthBar setPercentage:m.baseHealth];
}

-(void) updateEnemyBaseHp:(int)amount{
    DataModel *m=[DataModel getModel];
    m.EnemyBaseHealth += amount;
    
    if (m.EnemyBaseHealth  <= 25) {
        [self->EnemyHealthBar setSprite:[CCSprite spriteWithFile:@"health_bar_red.png"]];
        [self->EnemyHealthBar setScale:0.5]; 
    }
    
    if (m.EnemyBaseHealth  <= 0) {
        //Game Over Scenario
     //   printf("Game Over\n");
           m.gameover=true;
        [m._MapDirectionsViewController callStats];
//        [self winWindow];
        [m._MainMenuCocosLayer  clearGameisOver];
        
        
        
//        for (CCSprite *removeSprite in m._creepsEnemyOrder) {
//            [self removeChild:removeSprite cleanup:YES];}
//        NSMutableArray *discardedItems = [NSMutableArray array];
//        
//        for (Creep *creeps in m._creepsEnemyOrder) {
//            [discardedItems addObject:creeps];
//        }
//        [m._creepsEnemyOrder removeObjectsInArray:discardedItems];
//        
//        for (CCSprite *removeSprite2 in m._creepsOrder) {
//            [self removeChild:removeSprite2 cleanup:YES];}
//        NSMutableArray *discardedItems2 = [NSMutableArray array];
//        
//        for (Creep *creeps2 in m._creepsOrder) {
//            [discardedItems2 addObject:creeps2];
//        }
//        [m._creepsOrder removeObjectsInArray:discardedItems2];
        
        
        //Implement Game Over Scenario
    }
    
    [self->EnemyHealthBar setPercentage:m.EnemyBaseHealth];
}

-(void) updateResources:(int)amount{
    DataModel *m=[DataModel getModel];
    m.gold += amount;
    [self->resourceLabel setString:[NSString stringWithFormat: @"%i",m.gold]];
}

//-(void) updateResourcesNom{
//    resources += 1;
//    [self->resourceLabel setString:[NSString stringWithFormat: @"$%i",resources]];
//}
-(void) updateWaveCount{
    waveCount++;
    [self->waveCountLabel setString:[NSString stringWithFormat: @"Turn %i",waveCount]];
}
    
    
- (void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}


- (void) dealloc
{
	[movableSprites release];
    movableSprites = nil;
	[super dealloc];
}
- (void) addDescription:(int) rowId
{  
    if(!descBG){
        descBG = [CCSprite spriteWithFile:@"towerDescBG.png"];
        descBG.scale=0.5;//0.4
        descBG.position = ccp(150,275);//300
        [self addChild:descBG];
    }
   
    if(!btn_close){
        btn_close = [CCSprite spriteWithFile:@"btn_close.png"];
        btn_close.scale=0.2;
        btn_close.position = ccp(250,400);
        [self addChild:btn_close];
    }
    
    [self removeChild:descLabel cleanup:YES];
    
    if (rowId==1){
    Row=1;

            
        descLabel = [[CCLabelTTF labelWithString:@"Name: Fireworks  \n Damage: 3\nAttack Speed: 1.3                         \n Range: 1000\n Special Effect: Fireworks explode dealing splash damage within an area of 200 around the target." 
                                      dimensions:CGSizeMake(200, 150) alignment:UITextAlignmentCenter 
                                        fontName:@"Arial" fontSize:14.0] retain];
        descLabel.position = ccp(150,300);
        [self addChild:descLabel];
    
    }
    else if (rowId==2)   {
        Row=2;
            
        descLabel = [[CCLabelTTF labelWithString:@"Name: Jump Rope\n Damage: 4\nAttack Speed:1.0                         \n Range: 50\n Special Effect: These friends use their jumprope to trip their target and temporarily stun them for up to 2.0 seconds." 
                                                           dimensions:CGSizeMake(200, 150) alignment:UITextAlignmentCenter 
                                                             fontName:@"Arial" fontSize:14.0] retain];
        descLabel.position = ccp(150,300);
        [self addChild:descLabel];}
    else if (rowId==3)   {
        Row=3;
             
            descLabel = [[CCLabelTTF labelWithString:@"Name: Pyro \n Damage: 5\nAttack Speed: 1.2                        \n Range: 200\n Special Effect: Pyros use their flame attack to deal splash damage within an area of 25 around their target." 
                                          dimensions:CGSizeMake(200, 150) alignment:UITextAlignmentCenter 
                                            fontName:@"Arial" fontSize:14.0] retain];
            descLabel.position = ccp(150,300);
            [self addChild:descLabel];}
    else if (rowId==4)   {
        Row=4;
        
        descLabel = [[CCLabelTTF labelWithString:@"Name: Expansion \n  Range: 200\n Special Effect: Adds extra tower buildable area." 
                                      dimensions:CGSizeMake(200, 150) alignment:UITextAlignmentCenter 
                                        fontName:@"Arial" fontSize:14.0] retain];
        descLabel.position = ccp(150,300);
        [self addChild:descLabel];}


}

- (void) ChangeToBtn_close2{
    [self removeChild:btn_close cleanup:YES];
    btn_close = nil; 
    
    btn_close = [CCSprite spriteWithFile:@"btn_close2.png"];
    btn_close.scale = .2;
    btn_close.position = ccp(250, 400);
    [self addChild:btn_close];
    [self performSelector:@selector(close) withObject:nil afterDelay:(0.3)];
}

-(void) close{
    [self removeChild:btn_close cleanup:YES];
    btn_close=nil;
    [self removeChild:descLabel cleanup:YES];
    descLabel=nil;
    [self removeChild:descBG cleanup:YES];
    descBG=nil;
} 

- (void) removeEnemyBaseChoise:(int) num{
    if(num == 1){
        [self removeChild:HomeBase4 cleanup:YES];
        HomeBase4 = nil;
        [self removeChild:HomeBaseArea4 cleanup:YES];
        HomeBaseArea4 = nil;
    }
    else if(num == 2){
        [self removeChild:HomeBase1 cleanup:YES];
        HomeBase1 = nil;
        [self removeChild:HomeBaseArea1 cleanup:YES];
        HomeBaseArea1 = nil;
    }
    else if(num == 3){
        [self removeChild:HomeBase2 cleanup:YES];
        HomeBase2 = nil;
        [self removeChild:HomeBaseArea2 cleanup:YES];
        HomeBaseArea2 = nil;
    }
    else if(num == 4){
        [self removeChild:HomeBase3 cleanup:YES];
        HomeBase3 = nil;
        [self removeChild:HomeBaseArea3 cleanup:YES];
        HomeBaseArea3 = nil;
    }
}

- (bool) chooseHB{    
    
    bool ready=false;
    int xPos;
    int yPos;
    
    if(ChoosingHB == 1){
        xPos = 72;
        yPos = 357;
        ready = true;
    }
    if(ChoosingHB == 2){
        xPos = 248;
        yPos = 357;
        ready = true;
    }
    if(ChoosingHB == 3){
        xPos = 72;
        yPos = 123;
        ready = true;
    }
    if(ChoosingHB == 4){
        xPos = 248;
        yPos = 123;
        ready = true;
    }
    
    if(ready==false){
        //[self removeChild:HomeBase cleanup:YES];
        //[self removeChild:HomeBaseArea cleanup:YES];
        
        return false;
        
    }else{
        DataModel *m = [DataModel getModel];
        [m._gameLayer addHomeBase: ccp(xPos,yPos)];
        
        
        [self removeChild:HomeBase4 cleanup:YES];
        HomeBase4 = nil; 
        [self removeChild:HomeBaseArea4 cleanup:YES];
        HomeBaseArea4 = nil; 
        
        [self removeChild:HomeBase1 cleanup:YES];
        HomeBase1 = nil; 
        [self removeChild:HomeBaseArea1 cleanup:YES];
        HomeBaseArea1 = nil; 
        
        [self removeChild:HomeBase2 cleanup:YES];
        HomeBase2 = nil; 
        [self removeChild:HomeBaseArea2 cleanup:YES];
        HomeBaseArea2 = nil; 
        
        [self removeChild:HomeBase3 cleanup:YES];
        HomeBase3 = nil; 
        [self removeChild:HomeBaseArea3 cleanup:YES];
        HomeBaseArea3 = nil; 
        return true;
    }    
}

//-------------------------Touches-------------------------------------------------
    
- (void)t_Begin:(UITouch *)touch withEvent:(UIEvent *)event;  
{ 
    DataModel *m = [DataModel getModel];

    CGPoint temp_touchLocation = [touch  locationInView:m.cocos_view];
    CGPoint touchLocation = [[CCDirector sharedDirector] convertToGL:temp_touchLocation];
    if (CGRectContainsPoint(buttonQuit.boundingBox, touchLocation)) { 
        [self ChangeToBtn_quit2];
    }
    
    if(btn_close){
    if (CGRectContainsPoint(btn_close.boundingBox, touchLocation)) { 
        m.routeMapView.scrollEnabled=NO;
          [self ChangeToBtn_close2];
          descriptionFlag=false;
    }
    }
   
   for (CCSprite *sprite in movableSprites) {
       if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) { 
            m.routeMapView.scrollEnabled=NO;
           // NSLog(@"sprite was touched!!!%d",sprite.tag);
           
           if(sprite.tag==4){
               towerSprite = [CCSprite spriteWithFile:@"SquareT.png"]; 
               towerSprite.position = touchLocation;
               towerSprite.tag = sprite.tag;
               descriptionFlag = true;
               
           }
                     
           if(sprite.tag==3){
           towerSprite = [CCSprite spriteWithFile:@"pyroz14.png"]; 
           towerSprite.position = touchLocation;
           towerSprite.tag = sprite.tag;
           descriptionFlag = true;
               
           }
           if(sprite.tag==2){
           towerSprite = [CCSprite spriteWithFile:@"jumpropez14.png"];
           towerSprite.position = touchLocation;
           towerSprite.tag = sprite.tag;
           descriptionFlag = true;
           }
           if(sprite.tag==1){
           towerSprite = [CCSprite spriteWithFile:@"fireworksz14.png"];
           towerSprite.position = touchLocation;
           towerSprite.tag = sprite.tag;
           descriptionFlag = true;
           }
            [self addChild:towerSprite z:1];
           selSpriteRange = [CCSprite spriteWithFile:@"Range.png"];
          
           [self addChild:selSpriteRange z:-1];
           selSpriteRange.position = towerSprite.position;
 
               
                                  
                                   if(sprite.tag==1){
                                       selSpriteRange.scale = 2.8; 
                                       towerSprite.scale=0.5;
                                   }
                                   else  if(sprite.tag==2){
                                       selSpriteRange.scale = 0.7; 
                                       towerSprite.scale=0.5;
                                   }
                                   else  if(sprite.tag==3){
                                       selSpriteRange.scale = 1.6; 
                                       towerSprite.scale=0.5;
                                   }
                                   else if (sprite.tag==4){
                                       selSpriteRange.scale = 0; 
                                       towerSprite.scale=1;
                                   }
                                
                                   
        break;
                    
           
           
        }
    }
    if(m.HomeBaseTouchEnable_HUD==true){
        if(HomeBase4 != nil){
            if (CGRectContainsPoint(HomeBase4.boundingBox, touchLocation)) {  
                HomeBaseArea4.opacity=255;
                HomeBase4.opacity=255;
                ChoosingHB = 1;
            }else{
                HomeBaseArea4.opacity=100;
                HomeBase4.opacity=100;
            }
        }
        
        if(HomeBase1 != nil){
            if (CGRectContainsPoint(HomeBase1.boundingBox, touchLocation)) {  
                HomeBaseArea1.opacity=255;
                HomeBase1.opacity=255;
                ChoosingHB = 2;
            }else{
                HomeBaseArea1.opacity=100;
                HomeBase1.opacity=100;
            }
        }
        
        if(HomeBase2 != nil){
            if (CGRectContainsPoint(HomeBase2.boundingBox, touchLocation)) {  
                HomeBaseArea2.opacity=255;
                HomeBase2.opacity=255;
                ChoosingHB = 3;
            }else{
                HomeBaseArea2.opacity=100;
                HomeBase2.opacity=100;
            }
        }
        
        if(HomeBase3 != nil){
            if (CGRectContainsPoint(HomeBase3.boundingBox, touchLocation)) {  
                HomeBaseArea3.opacity=255;
                HomeBase3.opacity=255;
                ChoosingHB = 4;
            }else{
                HomeBaseArea3.opacity=100;
                HomeBase3.opacity=100;
            }
        }
        
        
//        if (CGRectContainsPoint(HomeBase.boundingBox, touchLocation)) {  
//             m.routeMapView.scrollEnabled=NO;
//           // selSprite = HomeBase;
//            HomeBase.scale=.25;
//            if(!HomeBaseArea){
//                HomeBaseArea = [CCSprite spriteWithFile:@"Square.png"];
//                HomeBaseArea.scale = 1.4;
//                [self addChild:HomeBaseArea z:-1];
//                HomeBaseArea.position = HomeBase.position;
//                //selSpriteRange=HomeBaseArea;
//                HBnotActive=false;
//            }
//        }  
    }
}


- (void)t_Moved:(UITouch *)touch withEvent:(UIEvent *)event;
{ 
    if(descriptionFlag==true){
        [self close];
    }
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);    
	
       
        if(towerSprite){
            CGPoint newPos = ccpAdd(towerSprite.position, translation);
            descriptionFlag = false;
            towerSprite.position = newPos;
            selSpriteRange.position = newPos;
        }
        
        if(HomeBase && HBnotActive==false){
            CGPoint newPos = ccpAdd(HomeBase.position, translation);
            HomeBase.position = newPos;
            HomeBaseArea.position = newPos;
        }
}


- (void)t_Ended:(UITouch *)touch withEvent:(UIEvent *)event;
{ 
    if(descriptionFlag==true){
        [self close];
        [self addDescription:towerSprite.tag];
    }
    descriptionFlag=false;

    DataModel *m = [DataModel getModel];
    CGPoint temp_touchLocation = [touch  locationInView:m.cocos_view];
    CGPoint touchLocation = [[CCDirector sharedDirector] convertToGL:temp_touchLocation];
 
		//if (selSprite) {
		CGRect backgroundRect = CGRectMake(background.position.x, 
                                           background.position.y, 
                                           background.contentSize.width, 
                                           background.contentSize.height);
		
		if (!CGRectContainsPoint(backgroundRect, touchLocation) && m.routeMapView.scrollEnabled==NO) {
            //      NSLOG(@"BUILD HERE");
            if(HomeBase && HBnotActive==false){
//                [m._gameLayer addHomeBase: touchLocation];
//                [m._MainMenuCocosLayer addConfirmButton];
//                m.HomeBaseTouchEnable_HUD=false;
//                [self removeChild:HomeBaseArea cleanup:YES];
//                HomeBaseArea = nil; 
//                [self removeChild:HomeBase cleanup:YES];
//                HomeBase = nil; 
//                HBnotActive=true;
//                
//                [self removeChild:background cleanup:YES];
//                background = nil;
                
                

            }
            else if(towerSprite){
                
                CCSprite *tempSPRT;
                tempSPRT =  [m._gameLayer getHomeBaseArea];
                CCSprite *tempSPRT2;
                
                
                if (towerSprite.tag==4)
                {    
                    if (CGRectIntersectsRect(towerSprite.boundingBox, tempSPRT.boundingBox) && !CGRectIntersectsRect(towerSprite.boundingBox, backgrounds.boundingBox)) { 
                        [m._gameLayer addTower: touchLocation,[m.playerID intValue], towerSprite.tag];   
                    }else{
                        for (tempSPRT2 in m.extraArea)
                        {
                            if (CGRectIntersectsRect(towerSprite.boundingBox, tempSPRT2.boundingBox)&& !CGRectIntersectsRect(towerSprite.boundingBox, backgrounds.boundingBox)) { 
                                [m._gameLayer addTower: touchLocation,[m.playerID intValue], towerSprite.tag];
                                break;
                            }
                        } 
                    }
                }
                
                    if (towerSprite.tag!=4)
                    {       for (tempSPRT2 in m.extraArea)
                            {
                                     if (CGRectIntersectsRect(towerSprite.boundingBox, tempSPRT2.boundingBox)&& !CGRectIntersectsRect(towerSprite.boundingBox, backgrounds.boundingBox)) { 
                                         [m._gameLayer addTower: touchLocation,[m.playerID intValue], towerSprite.tag];
                                         break;
                                     }
                            }   
                        if (CGRectIntersectsRect(towerSprite.boundingBox, tempSPRT.boundingBox)&& !CGRectIntersectsRect(towerSprite.boundingBox, backgrounds.boundingBox)) { 
                            [m._gameLayer addTower: touchLocation,[m.playerID intValue], towerSprite.tag];
                        }
                    }
        //add tower if it was placed on the 4th tower 
//                if (CGRectIntersectsRect(towerSprite.boundingBox, tempSPRT2.boundingBox)) { 
//                    [m._gameLayer addTower: touchLocation,[m.playerID intValue], towerSprite.tag];
//                }
            
            
                [self removeChild:towerSprite cleanup:YES];
                towerSprite = nil;
                [self removeChild:selSpriteRange cleanup:YES];
                selSpriteRange = nil;
                [self removeChild:tempSPRT cleanup:YES];
                tempSPRT = nil;
               // [self removeChild:tempSPRT2 cleanup:YES];
               // tempSPRT2 = nil;
           }
		}
	
	
        // if homeBase is active
       // if(selSprite==HomeBase){ 
//}
        //if turret is active
        //else if(selSprite==towerSprite){

       // }
        //[self removeChild:selSprite cleanup:YES];
        //selSprite = nil;

	//}

    m.routeMapView.scrollEnabled=YES;
}

- (void)t_Cancelled:(NSSet *)touches withEvent:(UIEvent *)event;
{
    
}

- (void)addTurrets {
        CGSize winSize = [CCDirector sharedDirector].winSize;
    
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        backgrounds = [CCSprite spriteWithFile:@"hudBG2.png"];
        backgrounds.anchorPoint = ccp(0,0);
        [self addChild:backgrounds];
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
    
        movableSprites = [[NSMutableArray alloc] init];
        images = [NSMutableArray arrayWithObjects:@"fireworksz14.png", @"jumpropez14.png", @"pyroz14.png", @"SquareT.png",nil];       
        for(int i = 0; i < images.count; ++i) {
            NSString *image = [images objectAtIndex:i];
            Tsprites = [CCSprite spriteWithFile:image];
            float offsetFraction = ((float)(i+1))/(images.count);
            Tsprites.position = ccp(winSize.width*offsetFraction-35, 50);
            Tsprites.tag = i+1;
            [self addChild:Tsprites];
            [movableSprites addObject:Tsprites];
        }
    
    
            //Set up and place towerCost labels
            towerCost1 = [CCLabelTTF labelWithString:@"$" fontName:@"Marker Felt" fontSize:12];
            towerCost1.position = ccp(35, 15);
            towerCost1.color = ccc3(255, 255, 0);
             [towerCost1 setString:[NSString stringWithFormat:@"$ 50"]];
            [self addChild:towerCost1 z:1];
            
            //Set up and place towerCost labels
            towerCost2 = [CCLabelTTF labelWithString:@"$" fontName:@"Marker Felt" fontSize:12];
            towerCost2.position = ccp(125, 15);
            towerCost2.color = ccc3(255, 255, 0);
            [self addChild:towerCost2 z:1];
             [towerCost2 setString:[NSString stringWithFormat:@"$ 10"]];
            
            
            //Set up and place towerCost labels
            towerCost3 = [CCLabelTTF labelWithString:@"$" fontName:@"Marker Felt" fontSize:12];
            towerCost3.position = ccp(210, 15);
            towerCost3.color = ccc3(255, 255, 0);
            [self addChild:towerCost3 z:1];
             [towerCost3 setString:[NSString stringWithFormat:@"$ 20"]];
    
    //Set up and place towerCost labels
    towerCost4 = [CCLabelTTF labelWithString:@"$" fontName:@"Marker Felt" fontSize:12];
    towerCost4.position = ccp(275, 15);
    towerCost4.color = ccc3(255, 255, 0);
    [self addChild:towerCost4 z:1];
    [towerCost4 setString:[NSString stringWithFormat:@"$ 100"]];
    
    
//            
//            //Set cost values
//            switch (i) {
//                case 0:
//                    [towerCost setString:[NSString stringWithFormat:@"$ 25"]];
//                    break;
//                case 1:
//                    [towerCost setString:[NSString stringWithFormat:@"$ 20"]];
//                    break;
//                case 2:
//                    [towerCost setString:[NSString stringWithFormat:@"$ 10"]];
//                    break;
//                default:
//                    break;
//            }
  //      }
}

- (void) removeTurret{
    [self removeChild:towerCost1 cleanup:YES];
     [self removeChild:towerCost2 cleanup:YES];
     [self removeChild:towerCost3 cleanup:YES];
         [self removeChild:towerCost4 cleanup:YES];
 //   towerCost = nil;
    
    [self removeChild:backgrounds cleanup:YES];
    backgrounds = nil;
    [self removeChild:Tsprites cleanup:YES];
    Tsprites = nil;
    for (CCSprite *sprite in movableSprites) {
         [self removeChild:sprite cleanup:YES];
         sprite = nil;
    }
    movableSprites = nil;
    images = nil;
}

- (void) showText:(bool) show
{
    if(show==true){
        
        _background = [CCSprite spriteWithFile:@"hud.png"];
        _background.scale = 10;
        [self addChild:_background z:+1];

        
        label = [CCLabelTTF labelWithString:@"Waiting for other players" fontName:@"Marker Felt" fontSize:32 ];
        CGSize size = [[CCDirector sharedDirector] winSize];
        //label.anchorPoint = ccp(0,0);
        label.position =  ccp( size.height/2, size.width /2);
        label.rotation = -45;
        [self addChild: label z:+2];
    }
    
    if(show==false){
        [self removeChild:_background cleanup:YES];
        _background = nil;
        [self removeChild:label cleanup:YES];
        label = nil;
    }

}
- (void) winWindow
{ DataModel *m=[DataModel getModel];
    bgWin = [CCSprite spriteWithFile:@"SuburbanBG.jpg"];
    bgWin.anchorPoint = ccp(0,0);
    bgWin.scale = .5;
    [self addChild:bgWin];
    
    buttonQuit= [CCSprite spriteWithFile:@"btn_quit.png"];
    buttonQuit.scale = .2;
    buttonQuit.position = ccp(285, 35);
    [self addChild:buttonQuit z:0]; 
   
    winTitle= [CCSprite spriteWithFile:@"win_title_with_stats.png"];
    winTitle.scale = .4;
    winTitle.position = ccp(100,365);
    [self addChild:winTitle z:0];
    
   // waveCountLabel.position = ccp(55, 290);
   // waveCountLabel.scale=0.6;
   //[self->waveCountLabel setString:[NSString stringWithFormat: @"Turns %i",waveCount]];
    
    self.emitter = [CCParticleExplosion node];
	[self addChild:self.emitter z:0];
    self.emitter.startSize = 2.0f;
    self.emitter.startSizeVar = 0.5f;
	self.emitter.texture = [[CCTextureCache sharedTextureCache] addImage: @"stars-grayscale.png"];
    self.emitter.position = ccp(100,365);
    self.emitter.autoRemoveOnFinish = YES;
    
    
    [self removeChild:enemyBaseHpLabel cleanup:YES];
    enemyBaseHpLabel = nil; 
    [self removeChild:EnemyHealthBar cleanup:YES];
    EnemyHealthBar = nil; 
    [self removeChild:healthBar cleanup:YES];
    healthBar = nil; 
    [self removeChild:baseHpLabel cleanup:YES];
    baseHpLabel = nil; 
    [self removeChild:resourceLabel cleanup:YES];
    resourceLabel = nil; 
    [self removeChild:coinTD cleanup:YES];
    coinTD = nil; 
    [self removeChild:waveCountLabel cleanup:YES];
    waveCountLabel = nil; 
    
    int myInt = (int) m.baseHealth;
    
    self->Stats = [CCLabelTTF labelWithString:@"" dimensions:CGSizeMake(150, 190) alignment:UITextAlignmentRight fontName:@"Marker Felt" fontSize:14];
    Stats.position = ccp(50, 190);
    Stats.color = ccc3(100,0,100);
    [self addChild:Stats z:1];
     [self->Stats setString:[NSString stringWithFormat: @"Gold:%i \n Income: %i\n Attackers sent: %i\n Base HP %d \n",m.gold,m.totalIncome, m.creepsSent, myInt]];
//    NSLog(@" m.c_type== %d", m.c_type.count); 
//     NSLog(@" m.gold== %d", m.gold); 
//    NSLog(@" m.totalIncome== %d", m.totalIncome); 
//    NSLog(@" homebase life== %f", m.baseHealth ); 

}
- (void) loseWindow
{   DataModel *m=[DataModel getModel];
    bgLose = [CCSprite spriteWithFile:@"SuburbanNight.png"];
    bgLose.anchorPoint = ccp(0,0);
    bgLose.scale = .5;
    [self addChild:bgLose];
    
  
    
    buttonQuit= [CCSprite spriteWithFile:@"btn_quit.png"];
    buttonQuit.scale = .2;
    buttonQuit.position = ccp(285, 35);
    [self addChild:buttonQuit z:0]; 
    
    loseTitle= [CCSprite spriteWithFile:@"lose_title_with_stats.png"];
    loseTitle.scale = .4;
    loseTitle.position = ccp(100,365);
    [self addChild:loseTitle z:0]; 
    
   //   waveCountLabel.position = ccp(55, 290);
   // waveCountLabel.scale=0.6;
   //    [self->waveCountLabel setString:[NSString stringWithFormat: @"Turns %i",waveCount]];
    //resourceLabel.position = ccp(30, 255);
    
	self.emitter = [CCParticleRain node];
	[self addChild:self.emitter z:0];
	
	//CGPoint p = self.emitter.position;
	//self.emitter.position = ccp( p.x, p.y-100);
	self.emitter.life = 4;
	self.emitter.startSize = 1.0f;
    self.emitter.emissionRate = 200.0f;
	//self.emitter.startSizeVar = 0.05f;
	self.emitter.texture = [[CCTextureCache sharedTextureCache] addImage: @"fire.pvr"];
    self.emitter.position = ccp(160,500);
    
    
    [self removeChild:enemyBaseHpLabel cleanup:YES];
    enemyBaseHpLabel = nil; 
    [self removeChild:EnemyHealthBar cleanup:YES];
    EnemyHealthBar = nil; 
    [self removeChild:healthBar cleanup:YES];
    healthBar = nil; 
    [self removeChild:baseHpLabel cleanup:YES];
    baseHpLabel = nil; 
    [self removeChild:resourceLabel cleanup:YES];
    resourceLabel = nil; 
    [self removeChild:coinTD cleanup:YES];
    coinTD = nil; 
    [self removeChild:waveCountLabel cleanup:YES];
    waveCountLabel = nil; 
    
    
    self->Stats = [CCLabelTTF labelWithString:@"" dimensions:CGSizeMake(150, 190) alignment:UITextAlignmentRight fontName:@"Marker Felt" fontSize:14];
    Stats.position = ccp(50, 190);
    Stats.color = ccc3(100,0,100);
    [self addChild:Stats z:1];
    
    int myInt = (int) m.baseHealth;
    
     [self->Stats setString:[NSString stringWithFormat: @"Gold:%i \n Income: %i\n Attackers sent: %i\n Base HP %i \n",m.gold,m.totalIncome, m.creepsSent, myInt]];
//    NSLog(@" m.c_type== %d", m.c_type.count); 
//    NSLog(@" m.gold== %d", m.gold); 
//    NSLog(@" m.totalIncome== %d", m.totalIncome); 
//    NSLog(@" homebase life== %f", m.baseHealth ); 

}
- (void) ChangeToBtn_quit2{
    [self removeChild:buttonQuit cleanup:YES];
    buttonQuit = nil;
    buttonQuit = [CCSprite spriteWithFile:@"btn_quit2.png"];
    buttonQuit.scale = .2;
    buttonQuit.position = ccp(285, 35);
    [self addChild:buttonQuit z:0]; 
    
    [self performSelector:@selector(exitApp) withObject:nil afterDelay:(0.7)];
}
- (IBAction)exitApp {
    exit(0);
}

@end
