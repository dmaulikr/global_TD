
#import "Tower.h"
#import "Wave.h"
#import "MKMapView_ZoomLevel.h"
#import "VariableStore.h"
#import "SimpleAudioEngine.h"
#import "CCParticleSystem.h"

@implementation Tower
@synthesize damage = _damage;
@synthesize range = _range;
@synthesize fireRate = fireRate;
@synthesize freezeDur = freezeDur;
@synthesize splashDist = splashDist;
@synthesize target = _target;
@synthesize nextProjectile = _nextProjectile;
@synthesize testSprite = _testSprite;
@synthesize coord;
@synthesize  type;
@synthesize player;
@synthesize shootAction = _shootAction;
@synthesize jumpropeAction = _jumpropeAction;
@synthesize pyroAction = _pyroAction;
@synthesize sunEmitter = _sunEmitter;

- (Creep *)getClosestTarget {
	Creep *closestCreep = nil;
	double maxDistant = 99999;
	
	DataModel *m = [DataModel getModel];
	
    
    for (CCSprite *target in m._targets) {	
        
        if (m.startWatchMyAttack==false){
            
            if (target.tag == self.tag)
                
            { 
                Creep *creep = (Creep *)target;
                double curDistance = ccpDistance(self.position, creep.position);
                
                if (curDistance < maxDistant) {
                    closestCreep = creep;
                    maxDistant = curDistance;
                }
            }
        }
        else  {
            if (target.tag!= self.tag)
                
            { 
                Creep *creep = (Creep *)target;
                double curDistance = ccpDistance(self.position, creep.position);
                
                if (curDistance < maxDistant) {
                    closestCreep = creep;
                    maxDistant = curDistance;
                }
            }
            
        }
        
    }
    
    if (maxDistant < self.range)
        return closestCreep;
    
    
	return nil;
}

-(void)removeIt{
    [self.parent removeChild:self cleanup:YES];
}

@end

@implementation MachineGunTower

+ (id)tower {
	
    
    MachineGunTower *tower = nil;
    if ((tower = [[[super alloc] initWithFile:@"fireworksz14.png"] autorelease])) {
        //tower.range = 50;
        tower.freezeDur = 0.0;
        tower.splashDist = 200;
        tower.damage = 10;
        [tower schedule:@selector(towerLogic:) interval:1.3];
        
        if  ([[VariableStore vStore] getZoom]==16 ){
            tower.scale=0.5;
            tower.range = 180;//70
        }
        
    }
    
    return tower;
    
}

-(id) init
{
	if ((self=[super init]) ) {
		//[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        player = 0;
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"ColoredFireworks.plist"];        
        
        // Create a sprite sheet with the Happy Bear images
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"ColoredFireworks.png"];
        [self addChild:spriteSheet];
        
        // Load up the frames of our animation
        NSMutableArray *shootAnimFrames = [NSMutableArray array];
        for(int i = 1; i <= 13; ++i) {
            if(i >= 10)
            {
                [shootAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Fireworks%d.png", i]]];
            }
            else //1-9 case
            {
                [shootAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Fireworks0%d.png", i]]];                    
            }
        }
        CCAnimation *shootAnim = [CCAnimation animationWithFrames:shootAnimFrames delay:0.1f];
        
        self.shootAction = [CCAnimate actionWithAnimation:shootAnim restoreOriginalFrame:YES];
        
	}
	return self;
}

//--------------
-(Tower *) itemForTouch: (UITouch *) touch
{    DataModel *m = [DataModel getModel];
	CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	for( Tower* item in m._towers ) {
		CGPoint local = [item convertToNodeSpace:touchLocation];
		CGRect r = CGRectMake( item.position.x - item.contentSize.width*item.anchorPoint.x, item.position.y-
                              item.contentSize.height*item.anchorPoint.y,
                              item.contentSize.width, item.contentSize.height);
		r.origin = CGPointZero;
		if( CGRectContainsPoint( r, local ) )
			return item;
        NSLog(@"tower was touched "); 
	}
	return nil;
}
//-----------


-(void)setClosestTarget:(Creep *)closestTarget {
	self.target = closestTarget;
}

-(void)towerLogic:(ccTime)dt {
	
	self.target = [self getClosestTarget];
	
	if (self.target != nil) {
		
		//rotate the tower to face the nearest creep
		CGPoint shootVector = ccpSub(self.target.position, self.position);
		CGFloat shootAngle = ccpToAngle(shootVector);
		CGFloat cocosAngle = CC_RADIANS_TO_DEGREES(-1 * shootAngle);
		
		float rotateSpeed = 0.5 / M_PI; // 1/2 second to roate 180 degrees
		float rotateDuration = fabs(shootAngle * rotateSpeed);    
		
        [self runAction:[CCSequence actions:
                         _shootAction,
                         //[CCRotateTo actionWithDuration:rotateDuration angle:cocosAngle],
						 [CCCallFunc actionWithTarget:self selector:@selector(finishFiring)],
						 nil]];		
        
		//[self runAction:[CCSequence actions:
        //            [CCRotateTo actionWithDuration:rotateDuration angle:cocosAngle],
        //			 [CCCallFunc actionWithTarget:self selector:@selector(finishFiring)],
        //		 nil]];		
	}
}




-(void)creepMoveFinished:(id)sender {
    
	DataModel * m = [DataModel getModel];
	
	CCSprite *sprite = (CCSprite *)sender;
	[self.parent removeChild:sprite cleanup:YES];
	//NSLog(@"dead creep");
	[m._projectiles removeObject:sprite];
	
}

- (void)finishFiring {
	
	DataModel *m = [DataModel getModel];
	if (self.target != NULL) {
        
        self.nextProjectile = [Projectile projectile: self];
        self.nextProjectile.position = self.position;
        
        [self.parent addChild:self.nextProjectile z:1];
        [m._projectiles addObject:self.nextProjectile];
        //Projectile Rotation code
        CGPoint sVector = ccpSub(self.target.position, self.position);
		CGFloat sAngle = ccpToAngle(sVector);
		CGFloat cocosAngle = CC_RADIANS_TO_DEGREES(-1 * sAngle);
		
		float rotateSpeed = 0.0001 / M_PI; // 1/2 second to roate 180 degrees
		float rotateDuration = fabs(sAngle * rotateSpeed);    
        
		[self.nextProjectile runAction:[CCRotateTo actionWithDuration:rotateDuration angle:cocosAngle]];
        ccTime delta = 1.0;
        CGPoint shootVector = ccpSub(self.target.position, self.position);
        CGPoint normalizedShootVector = ccpNormalize(shootVector);
        CGPoint overshotVector = ccpMult(normalizedShootVector, 320);
        CGPoint offscreenPoint = ccpAdd(self.position, overshotVector);
        
        //sound
        [[SimpleAudioEngine sharedEngine] playEffect:@"FireworkSound.aif"];
        
        
        [self.nextProjectile runAction:[CCSequence actions:
                                        [CCMoveTo actionWithDuration:delta position:offscreenPoint],
                                        [CCCallFuncN actionWithTarget:self selector:@selector(creepMoveFinished:)],
                                        nil]];
        
        self.nextProjectile.tag = 1;		
        
        self.nextProjectile = nil;
    }
    
}


@end

@implementation JumpRope

+ (id)tower {
	
    JumpRope *tower = nil;
    if ((tower = [[[super alloc] initWithFile:@"jumpropez14.png"] autorelease])) {
        // tower.range = 25;
        tower.freezeDur = 2.0;
        tower.splashDist = 0.0;
        tower.damage = 4;
        [tower schedule:@selector(towerLogic:) interval:1.3];
    }
    if  ([[VariableStore vStore] getZoom]==16 ){
        tower.scale=0.5;
        tower.range = 50;
    }
    
      
    
    
    
    return tower;
    
}

-(id) init
{
	if ((self=[super init]) ) {
		//[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        player = 0;
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"ColoredJumprope.plist"];        
        
        // Create a sprite sheet with the Happy Bear images
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"ColoredJumprope.png"];
        [self addChild:spriteSheet];
        NSLog(@"plist and png ok");
        // Load up the frames of our animation
        NSMutableArray *jumpropeAnimFrames = [NSMutableArray array];
        for(int i = 1; i <= 10; ++i) {
            if(i >= 10)
            {
                [jumpropeAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Jumprope%d.png", i]]];
            }
            else //1-9 case
            {
                [jumpropeAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Jumprope0%d.png", i]]];                    
            }
        }
        NSLog(@"jumprope added");
        CCAnimation *jumpropeAnim = [CCAnimation animationWithFrames:jumpropeAnimFrames delay:0.1f];
        
        self.jumpropeAction = [CCAnimate actionWithAnimation:jumpropeAnim restoreOriginalFrame:YES];
        
	}
	return self;
}

//--------------
-(Tower *) itemForTouch: (UITouch *) touch
{    DataModel *m = [DataModel getModel];
	CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	for( Tower* item in m._towers ) {
		CGPoint local = [item convertToNodeSpace:touchLocation];
		CGRect r = CGRectMake( item.position.x - item.contentSize.width*item.anchorPoint.x, item.position.y-
                              item.contentSize.height*item.anchorPoint.y,
                              item.contentSize.width, item.contentSize.height);
		r.origin = CGPointZero;
		if( CGRectContainsPoint( r, local ) )
			return item;
        NSLog(@"tower was touched "); 
	}
	return nil;
}
//-----------


-(void)setClosestTarget:(Creep *)closestTarget {
	self.target = closestTarget;
}

-(void)towerLogic:(ccTime)dt {
	
	self.target = [self getClosestTarget];
	
	if (self.target != nil) {
		
		//rotate the tower to face the nearest creep
		CGPoint shootVector = ccpSub(self.target.position, self.position);
		CGFloat shootAngle = ccpToAngle(shootVector);
		CGFloat cocosAngle = CC_RADIANS_TO_DEGREES(-1 * shootAngle);
		
		float rotateSpeed = 0.5 / M_PI; // 1/2 second to roate 180 degrees
		float rotateDuration = fabs(shootAngle * rotateSpeed);    
		
        [self runAction:[CCSequence actions:
                         _jumpropeAction,
                         //[CCRotateTo actionWithDuration:rotateDuration angle:cocosAngle],
						 [CCCallFunc actionWithTarget:self selector:@selector(finishFiring)],
						 nil]];		
        
		//[self runAction:[CCSequence actions:
        //            [CCRotateTo actionWithDuration:rotateDuration angle:cocosAngle],
        //			 [CCCallFunc actionWithTarget:self selector:@selector(finishFiring)],
        //		 nil]];		
	}
}



-(void)creepMoveFinished:(id)sender {
    
	DataModel * m = [DataModel getModel];
	
	CCSprite *sprite = (CCSprite *)sender;
	[self.parent removeChild:sprite cleanup:YES];
	//NSLog(@"dead creep");
	[m._projectiles removeObject:sprite];
	
}

- (void)finishFiring {
	
	DataModel *m = [DataModel getModel];
	if (self.target != NULL) {
        
        self.nextProjectile = [JumpRopeProjectile projectile: self];
        self.nextProjectile.position = self.position;
        if(self.nextProjectile == nil)
        {
            NSLog(@"nil next projectile");
        }
        [self.parent addChild:self.nextProjectile z:1];
        [m._projectiles addObject:self.nextProjectile];
        //Projectile Rotation code
        CGPoint sVector = ccpSub(self.target.position, self.position);
		CGFloat sAngle = ccpToAngle(sVector);
		CGFloat cocosAngle = CC_RADIANS_TO_DEGREES(-1 * sAngle);
		
		float rotateSpeed = 0.0001 / M_PI; // 1/2 second to roate 180 degrees
		float rotateDuration = fabs(sAngle * rotateSpeed);    
        
		[self.nextProjectile runAction:[CCRotateTo actionWithDuration:rotateDuration angle:cocosAngle]];
        ccTime delta = 1.0;
        CGPoint shootVector = ccpSub(self.target.position, self.position);
        CGPoint normalizedShootVector = ccpNormalize(shootVector);
        CGPoint overshotVector = ccpMult(normalizedShootVector, 320);
        CGPoint offscreenPoint = ccpAdd(self.position, overshotVector);
        
        //sound
        [[SimpleAudioEngine sharedEngine] playEffect:@"JumpropeSound.wav"];
        
        [self.nextProjectile runAction:[CCSequence actions:
                                        [CCMoveTo actionWithDuration:delta position:offscreenPoint],
                                        [CCCallFuncN actionWithTarget:self selector:@selector(creepMoveFinished:)],
                                        nil]];
        
        self.nextProjectile.tag = 2;		
        
        self.nextProjectile = nil;
    }
    
}

@end
@implementation Pyro

+ (id)tower {
	
    Pyro *tower = nil;
    if ((tower = [[[super alloc] initWithFile:@"Pyro01.png"] autorelease])) {
        //   tower.range = 100;
        tower.damage = 5;
        tower.freezeDur = 0.0;
        tower.splashDist = 25;
        
        [tower schedule:@selector(towerLogic:) interval:1.3];
    }
    if  ([[VariableStore vStore] getZoom]==16 ){
        tower.scale=0.5;
        tower.range = 100;
    }

    return tower;
    
}

-(id) init
{
	if ((self=[super init]) ) {
		//[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        player = 0;
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"ColoredPyro.plist"];        
        
        // Create a sprite sheet with the Happy Bear images
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"ColoredPyro.png"];
        [self addChild:spriteSheet];
        
        // Load up the frames of our animation
        NSMutableArray *pyroAnimFrames = [NSMutableArray array];
        for(int i = 1; i <= 12; ++i) {
            if(i >= 10)
            {
                [pyroAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Pyro%d.png", i]]];
            }
            else //1-9 case
            {
                [pyroAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Pyro0%d.png", i]]];                    
            }
        }
        CCAnimation *pyroAnim = [CCAnimation animationWithFrames:pyroAnimFrames delay:0.1f];
        
        self.pyroAction = [CCAnimate actionWithAnimation:pyroAnim restoreOriginalFrame:YES];
        
	}
	return self;
}

//--------------
-(Tower *) itemForTouch: (UITouch *) touch
{    DataModel *m = [DataModel getModel];
	CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	for( Tower* item in m._towers ) {
		CGPoint local = [item convertToNodeSpace:touchLocation];
		CGRect r = CGRectMake( item.position.x - item.contentSize.width*item.anchorPoint.x, item.position.y-
                              item.contentSize.height*item.anchorPoint.y,
                              item.contentSize.width, item.contentSize.height);
		r.origin = CGPointZero;
		if( CGRectContainsPoint( r, local ) )
			return item;
        NSLog(@"tower was touched "); 
	}
	return nil;
}
//-----------


-(void)setClosestTarget:(Creep *)closestTarget {
	self.target = closestTarget;
}

-(void)towerLogic:(ccTime)dt {
	
	self.target = [self getClosestTarget];
	
	if (self.target != nil) {
		
		//rotate the tower to face the nearest creep
		CGPoint shootVector = ccpSub(self.target.position, self.position);
		CGFloat shootAngle = ccpToAngle(shootVector);
		CGFloat cocosAngle = CC_RADIANS_TO_DEGREES(-1 * shootAngle);
		
		float rotateSpeed = 0.5 / M_PI; // 1/2 second to roate 180 degrees
		float rotateDuration = fabs(shootAngle * rotateSpeed);    
		
        [self runAction:[CCSequence actions:
                         _pyroAction,
                         //[CCRotateTo actionWithDuration:rotateDuration angle:cocosAngle],
						 [CCCallFunc actionWithTarget:self selector:@selector(finishFiring)],
						 nil]];		
        
		//[self runAction:[CCSequence actions:
        //            [CCRotateTo actionWithDuration:rotateDuration angle:cocosAngle],
        //			 [CCCallFunc actionWithTarget:self selector:@selector(finishFiring)],
        //		 nil]];		
	}
}



-(void)creepMoveFinished:(id)sender {
    
	DataModel * m = [DataModel getModel];
	
	CCSprite *sprite = (CCSprite *)sender;
	[self.parent removeChild:sprite cleanup:YES];
	//NSLog(@"dead creep");
	[m._projectiles removeObject:sprite];
	
}

- (void)finishFiring {
	
	DataModel *m = [DataModel getModel];
	if (self.target != NULL) {
        Projectile *tempProjectile = [PyroProjectile projectile: self]; 
        self.nextProjectile = tempProjectile;
        self.nextProjectile.position = self.position;        
        if(self.nextProjectile == nil)
        {
            NSLog(@"nil next projectile");
        }
        [self.parent addChild:self.nextProjectile z:1];
        [m._projectiles addObject:self.nextProjectile];
        //Projectile Rotation code
        CGPoint sVector = ccpSub(self.target.position, self.position);
		CGFloat sAngle = ccpToAngle(sVector);
		CGFloat cocosAngle = CC_RADIANS_TO_DEGREES(-1 * sAngle);
		
		float rotateSpeed = 0.0001 / M_PI; // 1/2 second to roate 180 degrees
		float rotateDuration = fabs(sAngle * rotateSpeed);    
        
		[self.nextProjectile runAction:[CCRotateTo actionWithDuration:rotateDuration angle:cocosAngle]];
        ccTime delta = 1.0;
        CGPoint shootVector = ccpSub(self.target.position, self.position);
        CGPoint normalizedShootVector = ccpNormalize(shootVector);
        CGPoint overshotVector = ccpMult(normalizedShootVector, 320);
        CGPoint offscreenPoint = ccpAdd(self.position, overshotVector);
        
        //sound
        [[SimpleAudioEngine sharedEngine] playEffect:@"FlameSound.wav"];
        //paritcles
        //CCParticleSystem *particleSystem = [[CCParticleSun alloc] initWithTotalParticles:200];
        //[self addChild:particleSystem];
        //[particleSystem release];
        //particleSystem.position = ccp(self.position.x,self.position.y);
        
        //[particleSystem setTexture:[[CCTextureCache sharedTextureCache] addImage:@"start.png"]];
        //particleSystem.gravity = ccp(0,-1000);
        //self.sunEmitter = [[CCParticleSun alloc] init];
        //self.sunEmitter.positionInPixels = self.positionInPixels;
        //self.sunEmitter.positionType = kCCPositionTypeFree;
        //self.sunEmitter.emitterMode = kCCParticleModeGravity;
        //self.sunEmitter.duration = 0.5;
        //self.sunEmitter.sourcePosition = ccp(self.target.position.x-self.position.x
                                           //  ,self.target.position.y-self.position.y-50);
        //self.sunEmitter.sourcePosition = CGPointMake((self.target.position.x-self.position.x)/2,(self.target.position.y-self.position.y)/2);
        //CLLocation *loc = self.coord;
       // CGPoint tarPoint = [m.routeMapView convertCoordinate:loc.coordinate toPointToView:m.cocos_view];
    
        //CGSize winSize = [CCDirector sharedDirector].winSize;
       // self.sunEmitter.sourcePosition = ccp(0, 0);
        //self.position = ccp(winSize.width/2, winSize.height/2);  
       // self.sunEmitter.position =ccp(self.position.x-60, self.position.y-50);//[[CCDirector sharedDirector] convertToGL:tarPoint];
        //NSLog(@"Tower pos!!!%f,%f", self.position.x, self.position.y);
               // coinTD = [CCSprite spriteWithFile:@"coinTD.png"];
        //self.testSprite= [Projectile projectile: self];
        //self.testSprite.position = self.position;
        //[self.parent addChild:self.testSprite z:1];
        //self.sunEmitter.gravity = CGPointMake(0, 90);//ccp(self.target.position.x-self.position.x,self.target.position.y-self.position.y);
        //self.sunEmitter.position = ccp(self.target.position.x, self.target.position.y);
        //self.sunEmitter.life = 0.5f;
        //[self addChild:self.sunEmitter];
        [self.nextProjectile runAction:[CCSequence actions:
                                     //  tempProjectile.pyroProjectileAction,
                                        [CCMoveTo actionWithDuration:delta position:offscreenPoint],
                                        [CCCallFuncN actionWithTarget:self selector:@selector(creepMoveFinished:)],
                                        nil]];
        
        self.nextProjectile.tag = 3;		
        
        self.nextProjectile = nil;
    }
    
}

@end

@implementation AddAreaTower

+ (id)tower {
	
    AddAreaTower *tower = nil;
    if ((tower = [[[super alloc] initWithFile:@"SquareT.png"] autorelease])) {
        
        //[tower schedule:@selector(towerLogic:) interval:1.3];
    }
    if  ([[VariableStore vStore] getZoom]==16 ){
        tower.scale=1;
    }
    
    return tower;
}

-(id) init
{
	if ((self=[super init]) ) {
        
	}
	return self;
}

@end

@implementation AddEnemyAreaTower

+ (id)tower {
	
    AddEnemyAreaTower *tower = nil;
    if ((tower = [[[super alloc] initWithFile:@"SquareEnemyT.png"] autorelease])) {
        
        //[tower schedule:@selector(towerLogic:) interval:1.3];
    }
    if  ([[VariableStore vStore] getZoom]==16 ){
        tower.scale=1;
    }
    
    return tower;
}

-(id) init
{
	if ((self=[super init]) ) {
        
	}
	return self;
}

@end


