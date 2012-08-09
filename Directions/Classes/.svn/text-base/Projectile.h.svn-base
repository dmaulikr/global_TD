//
//  Projectile.h
//  GlobalTD-1.0
//
//  Created by Raushan Karayeva on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "cocos2d.h"
#import "Tower.h"
#import "DataModel.h"

@interface Projectile : CCSprite {
CLLocation *coord;
CCSprite *_parentTower;
CCAction *_pyroProjectileAction;
}
@property (nonatomic, assign) CCSprite *parentTower;
@property (nonatomic, assign) CLLocation *coord;
@property (nonatomic, retain) CCAction *pyroProjectileAction;



+ (id)projectile: (id) sender;

@end

@interface JumpRopeProjectile : Projectile {
}
+ (id)projectile: (id) sender;

@end

@interface PyroProjectile : Projectile {
}
+ (id)projectile: (id) sender;

@end