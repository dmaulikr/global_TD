//
//  Creep.h
//  Cocos2D Build a Tower Defense Game
//
//  Created by iPhoneGameTutorials on 4/4/11.
//  Copyright 2011 iPhoneGameTutorial.com All rights reserved.
//

#import "cocos2d.h"
#import "Creep.h"
//#import "SimpleAudioEngine.h"
#import "Projectile.h"
//#import "DataModel.h"

@interface Tower : CCSprite {
    int player;
	int _range;
    int _damage;
    float fireRate;
    float freezeDur;
    float splashDist;
    int type;
	Creep *_target;
	CCSprite * selSpriteRange;
    CCSprite * testSprite;
    NSMutableArray *_projectiles;
	CCSprite *_nextProjectile;
    CCAction *_shootAction;
    CCAction *_jumpropeAction;
    CCAction *_pyroAction; 
    CLLocation *coord;
    CCParticleSystem *_sunEmitter;
}
@property (nonatomic, assign) int type;
@property (nonatomic, assign) int damage;
@property (nonatomic, assign) int range;
@property (nonatomic, assign) int player;

@property (nonatomic, assign) float fireRate;
@property (nonatomic, assign) float freezeDur;
@property (nonatomic, assign) float splashDist;


@property (nonatomic, retain) CCSprite * nextProjectile;
@property (nonatomic, retain) CCSprite * testSprite;
@property (nonatomic, retain) Creep * target;
@property (nonatomic, assign) CLLocation *coord;
@property (nonatomic, retain) CCAction *shootAction;
@property (nonatomic, retain) CCAction *jumpropeAction;
@property (nonatomic, retain) CCAction *pyroAction;
@property (nonatomic, retain) CCParticleSystem *sunEmitter;

- (Creep *)getClosestTarget;
- (void) removeIt;
@end

@interface MachineGunTower : Tower {
    
}

+ (id)tower;

- (void)setClosestTarget:(Creep *)closestTarget;
- (void)towerLogic:(ccTime)dt;
- (void)creepMoveFinished:(id)sender;
- (void)finishFiring;


@end

@interface JumpRope : Tower {
    
}

+ (id)tower;

- (void)setClosestTarget:(Creep *)closestTarget;
- (void)towerLogic:(ccTime)dt;
- (void)creepMoveFinished:(id)sender;
- (void)finishFiring;

@end

@interface Pyro : Tower {
    
}

+ (id)tower;

- (void)setClosestTarget:(Creep *)closestTarget;
- (void)towerLogic:(ccTime)dt;
- (void)creepMoveFinished:(id)sender;
- (void)finishFiring;

@end

@interface AddAreaTower : Tower {
    
}

+ (id)tower;

@end

@interface AddEnemyAreaTower : Tower {
    
}

+ (id)tower;

@end

