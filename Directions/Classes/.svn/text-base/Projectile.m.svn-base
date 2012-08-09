//
//  Projectile.m
//  GlobalTD-1.0
//
//  Created by Raushan Karayeva on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//Projectile.m
#import "Projectile.h"
@implementation Projectile
@synthesize parentTower = parentTower;
@synthesize coord;
@synthesize pyroProjectileAction = _pyroProjectileAction;

+ (id)projectile: (id) sender {
    Projectile *projectile = nil;
    if ((projectile = [[[super alloc]
                        initWithFile:@"firework_projectile.png"] autorelease])) {
        projectile.parentTower = sender;
    }
    return projectile;
}

- (void) dealloc
{
    [super dealloc];
}
@end

@implementation JumpRopeProjectile
+ (id)projectile : (id) sender{
    
    JumpRopeProjectile *projectile = nil;
    if ((projectile = [[[super alloc] initWithFile:@"Projectile.png"] autorelease])) {
        projectile.parentTower = sender;
        projectile.opacity = 0.0;
    }
    return projectile;
}

- (void) dealloc
{
    [super dealloc];
}
@end

@implementation PyroProjectile
+ (id)projectile : (id) sender{
   // NSLog(@"initializing PyroProjectile01.png");
    PyroProjectile *projectile = nil;
    if ((projectile = [[[super alloc]
                        initWithFile:@"PyroProjectile01.png"] autorelease])) {
     //       NSLog(@"initializeded PyroProjectile01.png");
        projectile.parentTower = sender;
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"ColoredPyroProjectile.plist"];        
        
        // Create a sprite sheet with the Happy Bear images
        //CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"ColoredPyroProjectile.png"];
        //[projectile addChild:spriteSheet];
        
        // Load up the frames of our animation
       // NSMutableArray *pyroProjectileAnimFrames = [NSMutableArray array];
//        for(int i = 1; i <= 3; ++i) {
//
//            [pyroProjectileAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"PyroProjectile0%d.png", i]]];                    
//        }
        
        //[pyroProjectileAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"PyroProjectile01.png"]]];  
        
       // [pyroProjectileAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"PyroProjectile02.png"]]];  
        
      //  [pyroProjectileAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"PyroProjectile03.png"]]];  
        
        //CCAnimation *shootAnim = [CCAnimation animationWithFrames:pyroProjectileAnimFrames delay:0.1f];
        
       // projectile.pyroProjectileAction = [CCAnimate actionWithAnimation:shootAnim restoreOriginalFrame:YES];
      //  NSLog(@"finishing PyroProjectile01.png");

    }
    return projectile;
}

- (void) dealloc
{
    [super dealloc];
}
@end