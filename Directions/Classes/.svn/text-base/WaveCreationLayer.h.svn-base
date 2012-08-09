//
//  HelloWorldLayer.h
//  MobMenu
//
//  Created by Matthew Ein on 2/21/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "DataModel.h"
// HelloWorldLayer
@interface WaveCreationLayer : CCLayer
{
    NSMutableArray *movableSpritesUI;
    CCLabelTTF *scoreLabel;
    CCSprite * addBus_text;
    CCSprite * addDoctors_text;
    CCSprite * addGrandma_text;
    CCSprite * SendWave_text;
    CCSprite * addBus_text2;
    CCSprite * addDoctors_text2; 
    CCSprite * addGrandma_text2; 
    NSMutableArray * myWave; 
    CCLabelTTF *TotalIncomel;
    }
// returns a CCScene that contains the HelloWorldLayer as the only child
//+(CCScene *) scene;
+ (WaveCreationLayer *)sharedWaveCreationLayer;
- (void)t_Begin:(UITouch *)touch withEvent:(UIEvent *)event;
-(void) updateIncomes:(int)amount;
@end
