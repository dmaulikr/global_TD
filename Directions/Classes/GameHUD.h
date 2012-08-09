//
//  GameHUD.h
//  Cocos2D Build a Tower Defense Game
//
//  Created by iPhoneGameTutorials on 4/4/11.
//  Copyright 2011 iPhoneGameTutorial.com All rights reserved.
//

#import "cocos2d.h"
#import "Tower.h"

@interface GameHUD : CCLayer {
	CCSprite * background;
    CCSprite * HomeBase;
    CCSprite * HomeBase1;
    CCSprite * HomeBase2;
    CCSprite * HomeBase3;
    CCSprite * HomeBase4;
	CCSprite * HomeBaseArea;
    CCSprite * HomeBaseArea1;
    CCSprite * HomeBaseArea2;
    CCSprite * HomeBaseArea3;
    CCSprite * HomeBaseArea4;
    int ChoosingHB;
	CCSprite * selSpriteRange;
    CCSprite * selSprite;
  	CCSprite * tower;
    CCSprite * btn_close;
    CCLabelTTF *label;
    CCSprite *_background;
    CCSprite * towerSprite;
    CCSprite *backgrounds;
    CCSprite *Tsprites;
    NSMutableArray * movableSprites;
    CCParticleSystem *_emitter;    
    CCSprite *descBG;
    CCSprite *upBG;
    CCSprite *coinTD;
      
      CCLabelTTF *descLabel;
    NSMutableArray *images;
    int Row;
    bool descriptionFlag;
    CCSprite *buttonQuit;
    CCSprite *bgWin;
    CCSprite *bgLose;
    CCSprite *winTitle;
    CCSprite *loseTitle;
    CCLabelTTF *resourceLabel;
    CCProgressTimer *healthBar;
    CCProgressTimer *EnemyHealthBar;
        CCLabelTTF *waveCountLabel;
    CCLabelTTF *enemyBaseHpLabel;
    CCLabelTTF *baseHpLabel; 
    bool HBnotActive;
    CCLabelTTF *towerCost1;
    CCLabelTTF *towerCost2;
    CCLabelTTF *towerCost3;
    CCLabelTTF *towerCost4;
    CCLabelTTF *towerCost;
        CCLabelTTF *Stats;
    bool descTrigger;
    
}

@property (nonatomic, assign) bool descriptionFlag;
//@property (nonatomic, assign) float baseHpPercentage;
@property (nonatomic, assign) int resources;
@property (nonatomic, assign) int ChoosingHB;
@property (nonatomic, retain) CCParticleSystem *emitter;

- (void)t_Begin:(UITouch *)touch withEvent:(UIEvent *)event;
- (void)t_Moved:(UITouch *)touch withEvent:(UIEvent *)event;
- (void)t_Cancelled:(UITouch *)touch withEvent:(UIEvent *)event;
- (void)t_Ended:(UITouch *)touch withEvent:(UIEvent *)event;

- (void) addDescription:(int) rowId;
- (void) addTurrets;
- (void) showText:(bool) show;
- (void) removeTurret;
- (void) winWindow;
- (void) loseWindow;
- (void) ChangeToBtn_quit2;

-(void) updateBaseHp:(int)amount;
-(void) updateResources:(int)amount;
-(void) updateResourcesNom;
-(void) updateWaveCount;

+ (GameHUD *)sharedHUD;
@end
